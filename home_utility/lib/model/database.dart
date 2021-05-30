import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../main.dart';

class Database {
  void totalUsersRequests() async {
    await usersRefrence
        .child(userAuthentication.userID)
        .child('requests')
        .once()
        .then((value) {
      // print(value.value);
      if (value.value != null) {
        userRequestCounter = Map.from(value.value).length;
        print(userRequestCounter);
      } else
        userRequestCounter = 0;
    });
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
      userInfo['state'] = 'pending';

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

  Future<void> deleteRequest(String requestKey) async {
    String userID = userAuthentication.userID;

    await requestRefrence.child(requestKey).remove();
    await usersRefrence
        .child(userID)
        .child('requests')
        .child(requestKey)
        .remove();
    // userRequestCounter--;
  }

  Future<Query> requestQuery(String requestKey) async {
    // return requestRefrence
    //     .orderByChild('uid')
    //     .equalTo(userAuthentication.userID);
    return usersRefrence
        .child(userAuthentication.userID)
        .child('requests')
        .orderByChild(requestKey);
  }

  Future<bool> checkAccount(User user) async {
    bool accountExists = false;
    await usersRefrence.child(user.uid).once().then((DataSnapshot snapshot) {
      if (snapshot.value != null)
        accountExists = true;
      else
        accountExists = false;
    });
    return accountExists;
  }

  Future<bool> checkPhoneNumber(int phoneNo) async {
    bool isAlreadyUsed = true;
    print(phoneNo);
    Query query = usersRefrence.orderByChild('phoneNo').equalTo(phoneNo);
    await query.once().then((DataSnapshot snapshot) {
      if (snapshot.value != null)
        isAlreadyUsed = true;
      else
        isAlreadyUsed = false;
    });
    return isAlreadyUsed;
  }
}
