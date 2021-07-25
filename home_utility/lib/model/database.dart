import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:home_utility/model/chat.dart';
import 'package:home_utility/model/proData.dart';
import 'package:home_utility/model/userData.dart';
// import 'package:home_utility/model/user.dart';
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
      // Map userInfo = database.getUserInfo();
      // userInfo.remove('userName');
      // userInfo.remove('userPhoneNo');
      Map userInfo = {};
      userInfo['requestedBy'] = {'userID': userID};
      userInfo['requestedTo'] = {'proID': proID};
      userInfo['dateTime'] = dateTime.toString();
      userInfo['category'] = category;
      userInfo['service'] = service;
      userInfo['userMunicipality'] = municipality;
      userInfo['userDistrict'] = district;
      userInfo['date'] = '${date.year}/${date.month}/${date.day}';
      userInfo['time'] = '${formatTime(unformattedTime: time)}';
      userInfo['requestKey'] = '$requestKey';
      userInfo['state'] = 'pending';
      userInfo['isAccepted'] = false;
      userInfo['isRatingPending'] = false;

      await requestRefrence.child(requestKey).set(userInfo);

      await usersRefrence
          .child(userID)
          .child('requests')
          .child(requestKey)
          .set({'requestKey': requestKey});

      userRequestCounter++;
      await prosRefrence.child(proID).child('requests').child(requestKey).set({
        'requestKey': requestKey,
      });
    } else {
      //TODO: Error message saying request if full
      //TODO: Set userRequestCountyer back to 0
      print('3 request has already been made');
    }
    await totalUsersRequests();
  }

  Future<void> changeRatingState({String requestKey, bool state}) async {
    await usersRefrence
        .child(userAuthentication.userID)
        .child('requests')
        .child(requestKey)
        // .child('isRatingPending')
        .update({'isRatingPending': state});
  }

  Future<void> deleteRequest({String requestKey}) async {
    String userID = userAuthentication.userID;

    // await requestRefrence.child(category).child(requestKey).remove();

    await usersRefrence
        .child(userID)
        .child('requests')
        .child(requestKey)
        .remove();

    // userRequestCounter--;
    await totalUsersRequests();
  }

  Future<String> getToken(String proID) async {
    DataSnapshot snapshot =
        await prosRefrence.child(proID).child('token').once();

    String token = snapshot.value;
    return token;
  }

  Future<String> getMyToken() async {
    DataSnapshot snapshot = await usersRefrence
        .child(userAuthentication.userID)
        .child('token')
        .once();
    String token = snapshot.value;
    return token;
  }

  void saveToken(String token) async {
    await usersRefrence
        .child(userAuthentication.userID)
        .update({'token': token});
  }

  // Stream<List<String>> userRequestsStream() {
  //   return usersRefrence
  //       .child(userAuthentication.userID)
  //       .child('requests')
  //       .onValue
  //       .map((Event event) {
  //     List<String> requestKeys = [];
  //     if (event.snapshot.value != null)
  //       Map.from(event.snapshot.value).forEach((key, value) {
  //         requestKeys.add(key);
  //       });

  //     return requestKeys;
  //   });
  //   // return null;
  // }

  Stream userRequestsStream() {
    return usersRefrence
        .child(userAuthentication.userID)
        .child('requests')
        .onValue;
  }

  // Stream<Map<String, RequestData>> userRequestsStream() {
  //   return usersRefrence
  //       .child(userAuthentication.userID)
  //       .child('requests')
  //       .onValue
  //       .map((Event event) {
  //     Map<String, RequestData> requestsData = {};
  //     try {
  //       Map.from(event.snapshot.value).forEach((key, value) {
  //         requestsData[key] = RequestData.fromData(value);
  //       });
  //     } catch (e) {}
  //     return requestsData;
  //   });
  //   // return null;
  // }

  Stream<List<UserData>> userDataStream() {
    return usersRefrence
        .child(userAuthentication.userID)
        .onValue
        .map((Event event) {
      List<UserData> userData = [];
      userData.add(UserData.fromData(event.snapshot.value));
      return userData;
    });
  }

  Stream<Map<String, Chat>> getChatData({String chatID}) {
    return messagesRefrence.child(chatID).onValue.map((Event event) {
      Map<String, Chat> chatData = {};
      try {
        Map.from(event.snapshot.value).forEach((key, value) {
          chatData[key] = Chat.fromData(value);
        });
      } catch (e) {}
      return chatData;
    });
  }

  Stream<List<ProsData>> proDataStream({String proID}) {
    return prosRefrence.child(proID).onValue.map((Event event) {
      List<ProsData> prosData = [];
      // print(event.snapshot.value);
      prosData.add(ProsData.fromData(event.snapshot.value));
      return prosData;
    });
  }

  // Stream<RequestData> requestDataStream({String requestKey}) {
  //   // DataSnapshot snapshot = await requestRefrence.child(requestKey).once();
  //   // Map data = snapshot.value as Map;
  //   // print(requestKey);
  //   return requestRefrence.child(requestKey).onValue.map((event) {
  //     return RequestData.fromData(event.snapshot.value);
  //   });
  // }

  Stream requestDataStream({String requestKey}) {
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
    print('here');
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
    print(isAlreadyUsed);
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
