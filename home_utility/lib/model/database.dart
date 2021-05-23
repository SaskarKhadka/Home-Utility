import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/interceptors/get_modifiers.dart';
import 'package:home_utility/main.dart';

class Database {
  Future<int> get totalUserRequests async {
    var userID = userAuthentication.userID;
    int counter = 0;
    await usersRefrence
        .child(userID)
        .child('requests')
        .once()
        .then((DataSnapshot snapshot) {
      try {
        Map<dynamic, dynamic>.from(snapshot.value).forEach((key, value) {
          counter++;
        });
        return counter;
      } catch (e) {
        return counter;
      }
    });
    return counter;
  }

  void addUserInfo({User user, Map userData}) {
    usersRefrence.child(user.uid).set(userData);
  }

  void addProsInfo(User user, Map proData) {
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
      {String service,
      String address,
      DateTime date,
      TimeOfDay time,
      String id}) async {
    //TODO: To the userInfo map, add type of job, date and time, (address too if we can't implement the adress directly)
    if (userRequestCounter < 3) {
      String userID = userAuthentication.userID;
      Map userInfo = await database.getUserInfo(userID);
      userInfo['service'] = service;
      userInfo['address'] = address;
      userInfo['date'] = '${date.year}/${date.month}/${date.day}';
      userInfo['time'] = '${formatTime(unformattedTime: time)}';
      userInfo['requestKey'] = '$id';

      requestRefrence.child('$id').set(userInfo);
      final ref = usersRefrence.child(userID).child('requests');
      ref.child(id).set(userInfo);
      userRequestCounter++;
    } else {
      //TODO: Error message saying request if full
      //TODO: Set userRequestCountyer back to 0\
      print('3 request has already been made');
    }
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

  Future<Query> requestQuery(String requestKey) async {
    return usersRefrence
        .child(userAuthentication.userID)
        .child('requests')
        .orderByChild(requestKey);
  }
}
