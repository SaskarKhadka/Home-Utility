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
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                    Widget>[
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
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide.none,
                                      borderRadius:
                                          BorderRadius.circular(20.0)),

                                  insetAnimationCurve: Curves.bounceIn,
                                  // backgroundColor: Color(0xFF110E1F),
                                  elevation: 0.0,
                                  // backgroundColor: Color(0xff141a1e),
                                  backgroundColor: Colors.white,
                                  child: Stack(
                                    children: [
                                      Container(
                                        width: size.width,
                                        padding: EdgeInsets.only(
                                          top: 0.0,
                                          bottom: 20.0,
                                          left: 20.0,
                                          right: 20.0,
                                        ),
                                        margin: EdgeInsets.only(top: 80),
                                        decoration: BoxDecoration(
                                          color: Color(0xff141a1e),
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey,
                                              offset: Offset(0, 2),
                                              blurRadius: 10.0,
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SizedBox(
                                              height: size.height * 0.09,
                                            ),
                                            Center(
                                              child: Text(
                                                'Rohan Dhakal'.toUpperCase(),
                                                style: GoogleFonts.shortStack(
                                                  fontSize: 20.0,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 6.0),
                                              child: Text(
                                                'Electronics Technician',
                                                style: GoogleFonts.sansita(
                                                  fontSize: 16.0,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: size.height * 0.006,
                                            ),
                                            RatingStars(
                                              starCount: 5,
                                              starSize: 15,
                                              starColor: Color(0xffF3CF31),
                                              starSpacing: 2,
                                              starOffColor:
                                                  const Color(0xffe7e8ea),
                                              valueLabelColor: Colors.red,
                                              value: rating,
                                            ),
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 26.0,
                                                          left: 20.0),
                                                  child: Text(
                                                    'Contact Details:',
                                                    style: GoogleFonts.raleway(
                                                      fontSize: 14.0,
                                                      color: Colors.greenAccent,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20.0),
                                                  child: SizedBox(
                                                    width: 180,
                                                    child: Divider(
                                                      color: Colors.blueGrey,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 16.0),
                                                  child: Icon(
                                                    Icons.phone,
                                                    color: Colors.teal,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 16.0),
                                                  child: Text(
                                                    '9816933888',
                                                    style:
                                                        GoogleFonts.montserrat(
                                                      fontSize: 14,
                                                      color: kWhiteColour,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: size.height * 0.005,
                                            ),
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 16.0),
                                                  child: Icon(
                                                    Icons.email,
                                                    size: 22,
                                                    color: Colors.yellow,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 16.0),
                                                  child: Text(
                                                    'dhakalrohan229@gmail.com',
                                                    style: GoogleFonts.raleway(
                                                      fontSize: 14.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: size.height * 0.05,
                                            ),
                                            GestureDetector(
                                              onTap: () => Get.back(),
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                  vertical: 10.0,
                                                  horizontal: 20.0,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Color(0xff4f5b8a),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Color(0xff2f3650),
                                                      offset: Offset(0, 1),
                                                      blurRadius: 4.0,
                                                    ),
                                                  ],
                                                ),
                                                child: Text(
                                                  'Ok',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                        top: 20,
                                        left: 45.0,
                                        right: 45.0,
                                        child: CircleAvatar(
                                          radius: 55.0,
                                          backgroundColor: Colors.redAccent,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              });
                        },
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
                                          color: Colors.white60, fontSize: 16))
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
                                        color: Colors.white60, fontSize: 16),
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
