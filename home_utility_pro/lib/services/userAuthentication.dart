import 'package:firebase_auth/firebase_auth.dart';
import '../main.dart';

class UserAuthentication {
  FirebaseAuth _auth = FirebaseAuth.instance;

  User get currentUser => _auth.currentUser;

  String get userID {
    User user = currentUser;
    return user.uid;
  }

  Future<void> reload() async {
    User user = currentUser;
    return await user.reload();
  }

  Future<String> signUp(
      {String email, String password, int phoneNo, String name}) async {
    String code;
    try {
      final firebaseUser = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (firebaseUser != null) {
        //user created
        Map proData = {
          'proID': firebaseUser.user.uid,
          'prosName': name,
          'prosEmail': email,
          'prosPhoneNo': phoneNo,
        };

        // usersRefrence.child(firebaseUser.user.uid).set(userData);

        database.addProsInfo(user: firebaseUser.user, proData: proData);
        code = 'success';

        //TODO:save user to data base

      } else {
        //TODO:Display error message
        code = 'error';
      }
    } on FirebaseAuthException catch (e) {
      code = e.code;
    }
    return code;
  }

  Future<String> signIn({String email, String password}) async {
    String code;
    try {
      final firebaseUser = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      bool accountExists = await database.checkAccount(firebaseUser.user);
      accountExists ? code = 'success' : code = 'record-not-found';
    } on FirebaseAuthException catch (e) {
      return code = e.code;
    }

    return code;
  }

  Future<bool> isEmailVerified() async {
    User user = currentUser;
    await user.reload();
    if (user.emailVerified) {
      return true;
    } else
      return false;
  }

  Future<String> sendEmailVerification({String email}) async {
    User user = currentUser;
    String code;
    try {
      await user.sendEmailVerification();
      code = 'success';
    } on FirebaseAuthException catch (e) {
      code = e.code;
    }
    print(code);
    return code;
  }

  Future<String> passwordReset({String email}) async {
    String code;
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      code = e.code;
    }
    print(code);
    return code;
  }

  void signOut() {
    _auth.signOut();
  }
}
