import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:uuid/uuid.dart';

import '../constants.dart';
import '../main.dart';

class RatingCard extends StatelessWidget {
  final String username;
  final String address;
  final String profession;
  final double rating;
  final String proID;

  final DateTime dateTime;
  final String description;
  final String category;
  final String service;
  final DateTime date;
  final TimeOfDay time;
  final String municipality;
  final String district;
  final double latitude;
  final double longitude;

  RatingCard({
    this.username,
    this.address,
    this.profession,
    this.rating,
    this.proID,
    this.dateTime,
    this.description,
    this.category,
    this.service,
    this.date,
    this.time,
    this.municipality,
    this.district,
    this.latitude,
    this.longitude,
  });

  // const RatingCard();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    //    double screenHeight = MediaQuery.of(context).size.height;
    Size size = MediaQuery.of(context).size;
    return Container(
      width: screenWidth,
      decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25))),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: <Widget>[
                SizedBox(width: 10),
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xff27272A),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xff27272A).withOpacity(0.3),
                          spreadRadius: 3,
                          blurRadius: 10,
                          offset: Offset(2, 4), // changes position of shadow
                        ),
                      ]),
                  child: Image.asset('images/user.png'),
                ),
                SizedBox(width: 50),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(username,
                          style: GoogleFonts.montserrat(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      SizedBox(height: 5),
                      Text(address,
                          style: GoogleFonts.roboto(
                              fontSize: 16, color: Colors.white70)),
                      SizedBox(height: 6),
                      RatingStars(
                        value: rating,
                        starCount: 5,
                        starSize: 15,
                        starColor: Color(0xffF3CF31),
                        starSpacing: 2,
                        starOffColor: const Color(0xffe7e8ea),
                        valueLabelColor: Colors.red,
                      ),
                      SizedBox(height: 10),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Color(0xff1A1A1A),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Container(
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.person,
                                        size: 20,
                                        color: Colors.white60,
                                      ),
                                      Text('See Profile',
                                          style: TextStyle(
                                              color: Colors.white60,
                                              fontSize: 16))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Color(0xff1A1A1A),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Container(
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.phone,
                                        size: 20,
                                        color: Colors.white60,
                                      ),
                                      Text(
                                        'Contact',
                                        style: TextStyle(
                                            color: Colors.white60,
                                            fontSize: 16),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 8),
                    ]),
              ],
            ),
            SizedBox(height: 10),
            GestureDetector(
              child: Container(
                width: screenWidth * 0.8,
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text('SEND REQUEST FOR WORK ',
                      style: GoogleFonts.roboto(
                          fontSize: 15.0, fontWeight: FontWeight.bold)),
                ),
              ),
              onTap: () {
                Get.defaultDialog(
                  title: 'Request Placed!',
                  titleStyle: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.w600,
                  ),
                  barrierDismissible: false,
                  middleText: 'Your request has been placed',
                  confirm: ElevatedButton(
                    onPressed: () async {
                      // CircularProgressIndicator();
                      await database.totalUsersRequests();
                      // Get.back();
                      // Get.back();
                      String newRequestKey = Uuid().v1();

                      await database.saveRequest(
                          description: description,
                          // proID: data['proID'],
                          proID: proID,
                          dateTime: dateTime,
                          requestKey: newRequestKey,
                          category: category,
                          service: service,
                          municipality: municipality,
                          district: district,
                          date: date,
                          time: time);
                      Get.back();
                      Get.back();
                      print(userRequestCounter);
                    },
                    child: Text(
                      'Ok',
                      style: TextStyle(
                        color: kWhiteColour,
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}