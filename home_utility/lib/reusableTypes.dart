import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:home_utility/model/database.dart';
import 'package:home_utility/services/cloudStorage.dart';
import 'package:home_utility/services/userAuthentication.dart';

DatabaseReference serviceRefrence =
    FirebaseDatabase.instance.reference().child('services');

DatabaseReference prosRefrence =
    FirebaseDatabase.instance.reference().child('pros');

final cloudStorage = CloudStorage();

//TODO:up

//TODO: probably make another file to store all these resuable accessories

int userRequestCounter;

String newRequestKey;

final userAuthentication = UserAuthentication();

Database database = Database();

DatabaseReference usersRefrence =
    FirebaseDatabase.instance.reference().child('users');

DatabaseReference messagesRefrence =
    FirebaseDatabase.instance.reference().child('messages');

DatabaseReference requestRefrence =
    FirebaseDatabase.instance.reference().child('requests');

String professionToCategory(String profession) {
  String category;
  if (profession.toLowerCase() == 'electronics technician')
    category = 'repair';
  else if (profession.toLowerCase() == 'beautician')
    category = 'beauty';
  else if (profession.toLowerCase() == 'householdChores')
    category = 'householdChores';
  else
    category = '';
  return category;
}

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
