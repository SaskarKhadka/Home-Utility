import 'package:firebase_auth/firebase_auth.dart';
import 'package:home_utility/main.dart';

class UserAuthentication {
  FirebaseAuth _auth = FirebaseAuth.instance;

  User get currentUser => _auth.currentUser;

  String get userID {
    User user = currentUser;
    return user.uid;
  }

  Future<void> signUp(
      {String email, String password, double phoneNo, String name}) async {
    try {
      final firebaseUser = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (firebaseUser != null) {
        //user created
        Map userData = {
          'name': name,
          'email': email,
          'phoneNo': phoneNo,
        };

        // usersRefrence.child(firebaseUser.user.uid).set(userData);

        database.addUserInfo(user: firebaseUser.user, userData: userData);

        //TODO:save user to data base

      } else {
        //TODO:Display error message
      }
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  Future<void> signIn({String email, String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }
}
