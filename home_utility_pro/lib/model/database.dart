import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:home_utility_pro/model/chat.dart';
import 'package:home_utility_pro/model/prosData.dart';
import 'package:home_utility_pro/model/userData.dart';
import '../main.dart';

class Database {
  void addProsInfo({User user, Map proData}) {
    prosRefrence.child(user.uid).set(proData);
  }

  Future<Map> getUserLocation({String userID}) async {
    DataSnapshot snapshot =
        await usersRefrence.child(userID).child('location').once();
    return snapshot.value as Map;
  }

  Future<void> deleteRequest({String requestKey}) async {
    print(userAuthentication.userID);

    await prosRefrence
        .child(userAuthentication.userID)
        .child('requests')
        .child(requestKey)
        .remove();
  }

  Future<void> cancelRequest({String requestKey, String userID}) async {
    await prosRefrence
        .child(userAuthentication.userID)
        .child('requests')
        .child(requestKey)
        .remove();

    await usersRefrence
        .child(userID)
        .child('requests')
        .child(requestKey)
        .remove();

    await requestRefrence.child(requestKey).remove();
  }

  Future<Query> requestQuery({String category}) async {
    // return requestRefrence.child(prosProfessionValue).orderByChild(requestKey);
    return requestRefrence
        .child(category)
        .orderByChild('category')
        .equalTo(prosProfessionValue);
  }

  Stream userRequestsStream() {
    // return requestRefrence.child(category).onValue;
    return prosRefrence
        .child(userAuthentication.userID)
        .child('requests')
        .onValue;
  }

  Future<String> getToken(String userID) async {
    DataSnapshot snapshot =
        await usersRefrence.child(userID).child('token').once();
    String token = snapshot.value;
    return token;
  }

  Future<String> getMyToken() async {
    DataSnapshot snapshot = await prosRefrence
        .child(userAuthentication.userID)
        .child('token')
        .once();
    String token = snapshot.value;
    return token;
  }

  void saveToken(String token) async {
    await prosRefrence
        .child(userAuthentication.userID)
        .update({'token': token});
  }

  // Stream<List<String>> userRequestsStream() {
  //   // return requestRefrence.child(category).onValue;
  //   return prosRefrence
  //       .child(userAuthentication.userID)
  //       .child('requests')
  //       .onValue
  //       .map((event) {
  //     List<String> keys = [];
  //     try {
  //       Map.from(event.snapshot.value).forEach((key, value) {
  //         keys.add(key);
  //       });
  //     } catch (e) {}
  //     return keys;
  //   });
  // }

  Stream<List<UserData>> userDataStream({String userID}) {
    return usersRefrence.child(userID).onValue.map((Event event) {
      List<UserData> userData = [];
      userData.add(UserData.fromData(event.snapshot.value));
      return userData;
    });
  }

  // Future<Map> requestData({String requestKey}) async {
  //   // DataSnapshot snapshot =
  //   //     await requestRefrence.child(category).child(requestKey).once();
  //   DataSnapshot snapshot = await requestRefrence.child(requestKey).once();

  //   print(snapshot.value);

  //   Map data = snapshot.value as Map;

  //   return data;
  // }

  Stream<List<ProsData>> proDataStream() {
    return prosRefrence
        .child(userAuthentication.userID)
        .onValue
        .map((Event event) {
      List<ProsData> prosData = [];
      // print(event.snapshot.value);
      prosData.add(ProsData.fromData(event.snapshot.value));
      return prosData;
    });
  }

  // Stream<RequestData> requestDataStream({String requestKey}) {
  //   return requestRefrence.child(requestKey).onValue.map((Event event) {
  //     return RequestData.fromData(event.snapshot.value);
  //   });
  // }

  Stream requestDataStream({String requestKey}) {
    return requestRefrence.child(requestKey).onValue;
  }

  // Stream<Map<String, RequestData>> requestDataStream() {
  //   return prosRefrence
  //       .child(userAuthentication.userID)
  //       .child('requests')
  //       .onValue
  //       .map((Event event) {
  //     Map<String, RequestData> requestData = {};
  //     try {
  //       Map.from(event.snapshot.value).forEach((key, value) {
  //         requestData[key] = RequestData.fromData(value);
  //       });
  //     } catch (e) {}
  //     return requestData;
  //   });
  // }

  // Stream<Map<String, RequestData>> jobDataStream() {
  //   return prosRefrence
  //       .child(userAuthentication.userID)
  //       .child('jobs')
  //       .onValue
  //       .map((Event event) {
  //     // print(event.snapshot.value);
  //     Map<String, RequestData> requestData = {};
  //     try {
  //       Map.from(event.snapshot.value).forEach((key, value) {
  //         requestData[key] = RequestData.fromData(value);
  //       });
  //     } catch (e) {}
  //     // print(requestData);
  //     return requestData;
  //   });
  // }

  Future<String> get prosProfession async {
    String profession;
    String userID = userAuthentication.userID;
    print(userID);
    await prosRefrence.child(userID).once().then((value) {
      Map.from(value.value).forEach((key, value) {
        if (key == 'profession') {
          profession = value;
        }
      });
    });
    return profession;
  }

  Future<void> updateProsInfo(
      {String profession, String municipality, String district}) async {
    String userID = userAuthentication.userID;
    await prosRefrence.child(userID).update({
      'profession': profession,
      'prosMunicipality': municipality,
      'prosDistrict': district,
    });
  }

  Future<bool> checkAccount(User user) async {
    bool accountExists = false;
    await prosRefrence.child(user.uid).once().then((DataSnapshot snapshot) {
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
    Query query = prosRefrence.orderByChild('prosPhoneNo').equalTo(phoneNo);
    await query.once().then((DataSnapshot snapshot) {
      if (snapshot.value != null)
        isAlreadyUsed = true;
      else
        isAlreadyUsed = false;
    });
    return isAlreadyUsed;
  }

  // Future<void> changeRatingState({String requestKey, bool state}) async {
  //   await requestRefrence.child(requestKey)
  //       // .child('isRatingPending')
  //       .update({'isRatingPending': state});
  // }

  Future<void> changeAcceptedState(
      {String requestKey, bool state, String userID}) async {
    await requestRefrence.child(requestKey).update({'isAccepted': state});
    // await prosRefrence
    //     .child(userAuthentication.userID)
    //     .child('requests')
    //     .child(requestKey)
    //     .update({'isAccepted': state});
    // print(userID);

    // await usersRefrence
    //     .child(userID)
    //     .child('requests')
    //     .child(requestKey)
    //     .update({'isAccepted': state});
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

  Future<void> saveRequestAsJob({String requestKey}) async {
    await prosRefrence
        .child(userAuthentication.userID)
        .child('requests')
        .child(requestKey)
        .remove();

    prosRefrence
        .child(userAuthentication.userID)
        .child('jobs')
        .child(requestKey)
        .set({'requestKey': requestKey});
    // requestData);
    // DataSnapshot snapshot =
    //     await requestRefrence.child(category).child(requestKey).once();

    // Map requestInfo = snapshot.value;
    // String userID = userAuthentication.userID;
    // // print(requestInfo);
    // // print(userID);
    // DatabaseReference ref = prosRefrence.child(userID).child('jobs');
    // ref.child(requestKey).set(requestInfo);
  }

  Future<void> deleteJob({String requestKey}) async {
    prosRefrence
        .child(userAuthentication.userID)
        .child('jobs')
        .child(requestKey)
        .remove();
  }

  Stream acceptedRequestStream() {
    return prosRefrence.child(userAuthentication.userID).child('jobs').onValue;
  }
}
