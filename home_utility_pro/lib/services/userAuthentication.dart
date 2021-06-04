import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import '../main.dart';

class UserAuthentication {
  FirebaseAuth _auth = FirebaseAuth.instance;

  User get currentUser => _auth.currentUser;

  String get userID {
    User user = currentUser;
    return user.uid;
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
          'name': name,
          'email': email,
          'phoneNo': phoneNo,
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

  Future<void> signOut() {
    _auth.signOut();
  }
}