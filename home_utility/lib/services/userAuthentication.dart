import 'package:firebase_auth/firebase_auth.dart';
import 'package:home_utility/model/database.dart';
import '../main.dart';

class UserAuthentication {
  Database _databse = Database();
  FirebaseAuth _auth = FirebaseAuth.instance;

  User get currentUser => _auth.currentUser;

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

        _databse.addUserInfo(user: firebaseUser.user, userData: userData);

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
