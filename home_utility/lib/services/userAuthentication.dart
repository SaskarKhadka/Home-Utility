import 'package:firebase_auth/firebase_auth.dart';
import 'package:home_utility/main.dart';

class UserAuthentication {
  FirebaseAuth _auth = FirebaseAuth.instance;

  User get currentUser => _auth.currentUser;

  String get userID {
    User user = currentUser;
    return user.uid;
  }

  Future<String> signUp({
    String email,
    String password,
    int phoneNo,
    String name,
    double latitude,
    double longitude,
  }) async {
    String code;
    try {
      final firebaseUser = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (firebaseUser != null) {
        // added//
        Map location = {
          'lat': latitude,
          'lng': longitude,
        };
        //user created
        Map userData = {
          'userID': firebaseUser.user.uid,
          'userName': name,
          'userEmail': email,
          'userPhoneNo': phoneNo,
          'location': location,
          'userPassword': password,
        };
        // added//

        // usersRefrence.child(firebaseUser.user.uid).set(userData);

        database.addUserInfo(user: firebaseUser.user, userData: userData);
        code = 'success';

        //TODO:save user to database

      } else {
        //TODO:Display error message
        code = 'error';
      }
    } on FirebaseAuthException catch (e) {
      print(e.code);
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
      code = accountExists ? 'success' : 'record-not-found';
    } on FirebaseAuthException catch (e) {
      print(e.code);
      code = e.code;
    }

    return code;
  }

  Future<String> passwordReset({String email}) async {
    String code;
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      print(code);
      code = e.code;
    }
    return code;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
