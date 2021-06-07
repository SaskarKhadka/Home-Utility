import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../main.dart';

class Database {
  void addProsInfo({User user, Map proData}) {
    prosRefrence.child(user.uid).set(proData);
  }

  Future<Map> getProsInfo(String uid) async {
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

  void deleteRequest(String requestKey) {
    String userID = userAuthentication.userID;
    requestRefrence.child(requestKey).remove();
  }

  Future<Query> requestQuery({String category}) async {
    // return requestRefrence.child(prosProfessionValue).orderByChild(requestKey);
    return requestRefrence
        .child(category)
        .orderByChild('category')
        .equalTo(prosProfessionValue);
  }

  Stream userRequestsStream() {
    print(category);
    if (category == '') return null;
    return requestRefrence.child(category).onValue;
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

  void updateProfession(String profession) {
    String userID = userAuthentication.userID;
    prosRefrence.child(userID).update({
      'profession': profession,
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
    Query query = prosRefrence.orderByChild('phoneNo').equalTo(phoneNo);
    await query.once().then((DataSnapshot snapshot) {
      if (snapshot.value != null)
        isAlreadyUsed = true;
      else
        isAlreadyUsed = false;
    });
    return isAlreadyUsed;
  }

  Future<void> changeState(
      {String userID, String category, String requestKey, String state}) async {
    await requestRefrence.child(category).child(requestKey).update(
      {
        'state': state,
      },
    );
    await usersRefrence
        .child(userID)
        .child('requests')
        .child(requestKey)
        .update(
      {
        'state': state,
      },
    );
  }
}
