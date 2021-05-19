import 'package:firebase_auth/firebase_auth.dart';
import 'package:home_utility/main.dart';

class Database {
  addUserInfo({User user, Map userData}) {
    usersRefrence.child(user.uid).set(userData);
  }
}
