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

  Map getUserInfo() {
    Map userData = {
      'userID': userAuthentication.userID,
    };
    // await usersRefrence.child(uid).once().then(
    //   (DataSnapshot snapshot) {
    //     Map<dynamic, dynamic>.from(snapshot.value).forEach((key, value) {
    //       if (key == 'userName') {
    //         userData['userName'] = value;
    //       }
    //       if (key == 'userPhoneNo') {
    //         userData['userPhoneNo'] = value;
    //       }
    //     });
    //   },
    // );
    print(userData);
    return userData;
  }

  Future<void> saveRequest(
      {String proID,
      String description,
      DateTime dateTime,
      String service,
      String category,
      String municipality,
      String district,
      DateTime date,
      TimeOfDay time,
      String requestKey}) async {
    //TODO: To the userInfo map, add type of job, date and time, (address too if we can't implement the adress directly)
    await totalUsersRequests();
    if (userRequestCounter < 3) {
      String userID = userAuthentication.userID;
      Map userInfo = database.getUserInfo();
      // userInfo.remove('userName');
      // userInfo.remove('userPhoneNo');
      userInfo['dateTime'] = dateTime.toString();
      userInfo['category'] = category;
      userInfo['service'] = service;
      userInfo['userMunicipality'] = municipality;
      userInfo['userDistrict'] = district;
      userInfo['date'] = '${date.year}/${date.month}/${date.day}';
      userInfo['time'] = '${formatTime(unformattedTime: time)}';
      userInfo['requestKey'] = '$requestKey';
      userInfo['state'] = 'pending';

      await requestRefrence.child(requestKey).set(userInfo);

      await requestRefrence.child(requestKey).child('requestedTo').set({
        'proID': proID,
      });
      final ref = usersRefrence.child(userID).child('requests');
      ref.child(requestKey).set({
        'requestKey': requestKey,
        // 'state': 'pending',
      });

      // usersRefrence
      //     .child(userID)
      //     .child('requests')
      //     .child(requestKey)
      //     .child('requestedTo')
      //     .set({
      //   'proID': proID,
      // });
      userRequestCounter++;
      prosRefrence.child(proID).child('requests').child(requestKey).set({
        'requestKey': requestKey,
      });
    } else {
      //TODO: Error message saying request if full
      //TODO: Set userRequestCountyer back to 0
      print('3 request has already been made');
    }
    await totalUsersRequests();
  }

  Future<void> deleteRequest(
      {String category, String requestKey, String proID}) async {
    String userID = userAuthentication.userID;

    // await requestRefrence.child(category).child(requestKey).remove();

    await usersRefrence
        .child(userID)
        .child('requests')
        .child(requestKey)
        .remove();
    await prosRefrence
        .child(proID)
        .child('requests')
        .child(requestKey)
        .remove();
    await requestRefrence.child(requestKey).remove();

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
    // return null;
  }

  Future<Map> requestData({String requestKey}) async {
    DataSnapshot snapshot = await requestRefrence.child(requestKey).once();
    Map data = snapshot.value as Map;
    return data;
  }

  Stream requestDataStream({String requestKey}) {
    // DataSnapshot snapshot = await requestRefrence.child(requestKey).once();
    // Map data = snapshot.value as Map;
    return requestRefrence.child(requestKey).onValue;
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

  Future<void> updateRatingAndReview(
      {String proID, String review, double rating}) async {
    // double proRating;
    // await prosRefrence
    //     .child(proID)
    //     .child('avgRating')
    //     .once()
    //     .then((DataSnapshot snapshot) {
    //   proRating = snapshot.value;
    // });
    // double avgRating = (proRating + rating) / 2;

    DataSnapshot snapshot =
        await prosRefrence.child(proID).child('avgRating').once();

    double avgRating = (snapshot.value + rating) / 2;
    await prosRefrence.child(proID).update(
      {
        'avgRating': avgRating,
      },
    );

    if (review.isNotEmpty) {
      DatabaseReference ref = prosRefrence.child(proID).child('review');
      DatabaseReference key = ref.push();
      await key.set({'review': review});
    }
  }
}
