import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import '../main.dart';

class Database {
  void addProsInfo({User user, Map proData}) {
    prosRefrence.child(user.uid).set(proData);
  }

  Future<Map> getProsInfo() async {
    String userID = userAuthentication.userID;
    Map prosData = {
      'proID': userID,
    };
    await prosRefrence.child(userAuthentication.userID).once().then(
      (DataSnapshot snapshot) {
        Map.from(snapshot.value).forEach(
          (key, value) {
            if (key == 'prosName') {
              prosData['prosName'] = value;
            }
            if (key == 'prosPhoneNo') {
              prosData['prosPhoneNo'] = value;
            }
          },
        );
      },
    );
    // print(prosData);
    return prosData;
  }

  Future<void> deleteRequest({String requestKey}) async {
    print(userAuthentication.userID);
    // requestRefrence.child(category).child(requestKey).remove();

    await prosRefrence
        .child(userAuthentication.userID)
        .child('requests')
        .child(requestKey)
        .remove();

    // await usersRefrence
    //     .child(userAuthentication.userID)
    //     .child('requests')
    //     .child(requestKey)
    //     .remove();
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

  Stream userDataStream({String userID}) {
    return usersRefrence.child(userID).onValue;
  }

  Future<Map> requestData({String requestKey}) async {
    // DataSnapshot snapshot =
    //     await requestRefrence.child(category).child(requestKey).once();
    DataSnapshot snapshot = await requestRefrence.child(requestKey).once();

    print(snapshot.value);

    Map data = snapshot.value as Map;

    return data;
  }

  Stream requestDataStream({String requestKey}) {
    return requestRefrence.child(requestKey).onValue;
  }

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
    prosRefrence.child(userID).update({
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

  Future<void> changeState({String requestKey, String state}) async {
    await requestRefrence.child(requestKey).update({'state': state});
  }

  Future<void> saveRequestAsJob({String requestKey}) async {
    await prosRefrence
        .child(userAuthentication.userID)
        .child('requests')
        .child(requestKey)
        .remove();

    await prosRefrence
        .child(userAuthentication.userID)
        .child('jobs')
        .child(requestKey)
        .set({
      'requestKey': requestKey,
    });
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
