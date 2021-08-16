import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:home_utility_pro/model/database.dart';
import 'package:home_utility_pro/services/cloudStorage.dart';
import 'package:home_utility_pro/services/userAuthentication.dart';

final userAuthentication = UserAuthentication();

final cloudStorage = CloudStorage();

Database database = Database();

String prosProfessionValue;

String userToken;

DatabaseReference prosRefrence =
    FirebaseDatabase.instance.reference().child('pros');

DatabaseReference usersRefrence =
    FirebaseDatabase.instance.reference().child('users');

DatabaseReference requestRefrence =
    FirebaseDatabase.instance.reference().child('requests');

DatabaseReference messagesRefrence =
    FirebaseDatabase.instance.reference().child('messages');

String formatTime({TimeOfDay unformattedTime}) {
  String time = '';

  if (unformattedTime.hourOfPeriod <= 9) {
    if (unformattedTime.hour == 12) {
      time += '${unformattedTime.hour}';
    } else
      time += '0${unformattedTime.hourOfPeriod}';
  } else
    time += '${unformattedTime.hourOfPeriod}';

  if (unformattedTime.minute <= 9)
    time += ':0${unformattedTime.minute}';
  else
    time += ':${unformattedTime.minute}';
  String periodOfDay = unformattedTime.period == DayPeriod.am ? ' am' : ' pm';
  return time + periodOfDay;
}
