import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../main.dart';

class Database {
  Future<void> totalUsersRequests() async {
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

  Future<Map> getUserInfo(String uid) async {
    Map userData = {
      'userID': uid,
    };
    await usersRefrence.child(uid).once().then(
      (DataSnapshot snapshot) {
        Map<dynamic, dynamic>.from(snapshot.value).forEach((key, value) {
          if (key == 'userName') {
            userData['userName'] = value;
          }
          if (key == 'userPhoneNo') {
            userData['userPhoneNo'] = value;
          }
        });
      },
    );
    print(userData);
    return userData;
  }

  Future<void> saveRequest(
      {DateTime dateTime,
      String service,
      String category,
      String address,
      DateTime date,
      TimeOfDay time,
      String requestKey}) async {
    //TODO: To the userInfo map, add type of job, date and time, (address too if we can't implement the adress directly)
    await totalUsersRequests();
    if (userRequestCounter < 3) {
      String userID = userAuthentication.userID;
      Map userInfo = await database.getUserInfo(userID);
      userInfo['dateTime'] = dateTime.toString();
      userInfo['category'] = category;
      userInfo['service'] = service;
      userInfo['userAddress'] = address;
      userInfo['date'] = '${date.year}/${date.month}/${date.day}';
      userInfo['time'] = '${formatTime(unformattedTime: time)}';
      userInfo['requestKey'] = '$requestKey';
      // userInfo['state'] = 'pending';

      requestRefrence.child(category).child('$requestKey').set(userInfo);
      requestRefrence.child(category).child('$requestKey').child('state').set(
        {'state': 'pending'},
      );
      final ref = usersRefrence.child(userID).child('requests');
      ref.child(requestKey).set(userInfo);
      usersRefrence
          .child(userID)
          .child('requests')
          .child('$requestKey')
          .child('state')
          .set(
        {'state': 'pending'},
      );
      userRequestCounter++;
    } else {
      //TODO: Error message saying request if full
      //TODO: Set userRequestCountyer back to 0\
      print('3 request has already been made');
    }
    await totalUsersRequests();
  }

  Future<void> deleteRequest({String category, String requestKey}) async {
    String userID = userAuthentication.userID;

    await requestRefrence.child(category).child(requestKey).remove();
    await usersRefrence
        .child(userID)
        .child('requests')
        .child(requestKey)
        .remove();
    // userRequestCounter--;
    await totalUsersRequests();
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

  Stream userRequestsStream() {
    return usersRefrence
        .child(userAuthentication.userID)
        .child('requests')
        .onValue;
  }

  Future<bool> checkAccount(User user) async {
    bool accountExists = false;
    // Query query = usersRefrence.orderByChild('uid').equalTo(user.uid);
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
    Query query = usersRefrence.orderByChild('userPhoneNo').equalTo(phoneNo);
    await query.once().then(
      (DataSnapshot snapshot) {
        if (snapshot.value != null)
          isAlreadyUsed = true;
        else
          isAlreadyUsed = false;
      },
    );
    return isAlreadyUsed;
  }

  Future<void> addService(
      {String category, String serviceName, String imgUrl}) async {
    Map data = {
      'category': category,
      'service': serviceName,
      'imgUrl': imgUrl,
    };
    await serviceRefrence.child(category).child(serviceName).set(data);
  }

  // Future<Map> myProsInfo(String requestKey) async {
  //   Map data = {};
  //   String pro;
  //   usersRefrence
  //       .child(userAuthentication.userID)
  //       .child('requests')
  //       .child(requestKey)
  //       .child('prosInfo')
  //       .once()
  //       .then(
  //     (DataSnapshot snapshot) {
  //       pro = snapshot.value;
  //     },
  //   );

  // }
}
