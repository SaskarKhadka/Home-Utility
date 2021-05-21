import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:home_utility/main.dart';

class Database {
  addUserInfo({User user, Map userData}) {
    usersRefrence.child(user.uid).set(userData);
  }

  addProsInfo(User user, Map proData) {
    //prosRefrence.child(user.uid).set(userData);
  }

  Future<Map> getUserInfo(String uid) async {
    Map userData = {
      'uid': uid,
    };
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

  Future<void> saveRequest(
      {String service, DateTime date, TimeOfDay time}) async {
    //TODO: To the userInfo map, add type of job, date and time, (address too if we can't implement the adress directly)
    // if (userRequestCounter <= 3) {
    String userID = userAuthentication.userID;
    Map userInfo = await database.getUserInfo(userID);
    userInfo['service'] = service;
    userInfo['date'] = '${date.year}/${date.month}/${date.day}';
    userInfo['time'] = '${formatTime(unformattedTime: time)}';
    requestRefrence.child('Request ${++requestCounter}').set(userInfo);
    usersRefrence.child(userID).child('requests').update(
        {'request ${++userRequestCounter}': 'Request ${++requestCounter}'});
    // } else {
    //TODO: Error message saying request if full
    //TODO: Set userRequestCountyer back to 0
  }

  void deleteRequest(String service) async {
    // if (userRequestCounter > 0) {
    String userID = userAuthentication.userID;
    // usersRefrence.child(uid).once().then((value) => null);
    await requestRefrence
        .child(userID)
        .child('requests')
        .once()
        .then((DataSnapshot snapshot) {
      Map<dynamic, dynamic>.from(snapshot.value).forEach((key, value) {
        if (key == 'request $userRequestCounter') {
          usersRefrence.child(userID).child('requests').child(key).remove();
        }
      });
    });
    //
  }
}
