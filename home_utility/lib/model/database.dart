import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:home_utility/main.dart';

class Database {
  addUserInfo({User user, Map userData}) {
    usersRefrence.child(user.uid).set(userData);
  }

  Future<Map> getUserInfo(String uid) async {
    Map userData = {};
    await usersRefrence.child(uid).once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic>.from(snapshot.value).forEach((key, value) {
        if (key == 'name') {
          userData['name'] = value;
        }
        if (key == 'phoneNo') {
          userData['phoneNo'] = value;
        }
      });
    });
    return userData;
  }
}
