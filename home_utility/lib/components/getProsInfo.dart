import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_utility/constants.dart';
import 'package:home_utility/controllers/proController.dart';
import 'package:home_utility/model/proData.dart';

class GetProsInfo extends StatelessWidget {
  final String proID;
  GetProsInfo({this.proID});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetX<ProController>(
        init: ProController(
          proID,
        ),
        builder: (proController) {
          if (proController == null || proController.pro.isEmpty) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  color: kWhiteColour,
                  backgroundColor: kWhiteColour,
                ),
              ],
            );
          }
          ProsData prosData = proController.pro[0];
          return Dialog(
            shape: RoundedRectangleBorder(
                side: BorderSide.none,
                borderRadius: BorderRadius.circular(20.0)),
            elevation: 10.0,
            backgroundColor: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: size.width,
                  padding: EdgeInsets.only(
                    top: 15.0,
                    bottom: 20.0,
                    left: 20.0,
                    right: 20.0,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xff141a1e),
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white38,
                        offset: Offset(0, 2),
                        blurRadius: 10.0,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 55.0,
                        backgroundColor: Colors.teal,
                        backgroundImage: prosData.profileUrl == null
                            ? AssetImage('images/person.png')
                            : NetworkImage(prosData.profileUrl),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Flexible(
                        child: Center(
                          child: Text(
                            prosData.prosName.toUpperCase(),
                            style: GoogleFonts.montserrat(
                              fontSize: 20.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 6.0),
                          child: Text(
                            prosData.profession,
                            style: GoogleFonts.montserrat(
                              fontSize: 16.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      RatingBar.builder(
                        initialRating: prosData.avgRating,
                        glowColor: Colors.amber,
                        itemSize: 20,
                        unratedColor: Colors.white54,
                        ignoreGestures: true,
                        glowRadius: 1,
                        itemPadding: EdgeInsets.all(5),
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        // itemPadding: EdgeInsets.symmetric(
                        //     horizontal: 4.0),
                        itemBuilder: (context, index) => Icon(
                          EvaIcons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          // proRating = rating;
                        },
                      ),
                      SizedBox(
                        width: 150,
                        child: Divider(
                          color: Colors.blueGrey,
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 20.0, left: 20.0),
                            child: Text(
                              'Contact Details:',
                              style: GoogleFonts.montserrat(
                                fontSize: 18.0,
                                color: Colors.greenAccent,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
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
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Icon(
                              Icons.phone,
                              color: Colors.teal,
                            ),
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Text(
                                '${prosData.prosPhoneNo}',
                                style: GoogleFonts.montserrat(
                                  fontSize: 16.0,
                                  color: kWhiteColour,
                                  letterSpacing: 1.3,
                                ),
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
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Icon(
                              Icons.email,
                              size: 22,
                              color: Colors.yellow,
                            ),
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Text(
                                prosData.prosEmail,
                                style: GoogleFonts.montserrat(
                                  fontSize: 16.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.035,
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
                            borderRadius: BorderRadius.circular(10.0),
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
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}

class GetProsReviews extends StatelessWidget {
  final proID;
  GetProsReviews({this.proID});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetX<ProController>(
        init: ProController(proID),
        builder: (proController) {
          if (proController == null || proController.pro.isEmpty)
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  color: kWhiteColour,
                  backgroundColor: kWhiteColour,
                ),
              ],
            );
          Map prosReviews = proController.pro[0].review;
          List<String> reviews = [];
          List<Container> container = [
            Container(
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                child: Column(
                  children: [
                    Text(
                      'Customer Reviews',
                      style: GoogleFonts.montserrat(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 28.0,
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.6,
                      child: Divider(
                        color: kWhiteColour.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ];
          try {
            prosReviews.forEach((key, value) {
              reviews.add(value['review']);
              container.add(Container(
                  child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xFF353C57),
                          // color: Color(0xFF2C2569),
                          borderRadius: BorderRadius.circular(12.0)),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 14.0, right: 10.0, bottom: 6.0, top: 6.0),
                        child: Row(
                          children: [
                            Flexible(
                              child: Text(
                                value['review'],
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.white70,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )));
            });
          } catch (e) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  side: BorderSide.none,
                  borderRadius: BorderRadius.circular(20.0)),
              elevation: 10.0,
              // backgroundColor: Color(0xff141a1e),
              backgroundColor: Color(0xFF333a56),

              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                    child: Column(
                      children: [
                        Text(
                          'Customer Reviews',
                          style: GoogleFonts.montserrat(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 28.0,
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.6,
                          child: Divider(
                            color: kWhiteColour.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 18.0, left: 10.0, right: 10.0, top: 20.0),
                    child: Column(
                      children: [
                        Text(
                          'This user doesnot have any reviews',
                          style: GoogleFonts.cabin(
                            color: Colors.white54,
                            fontSize: 18.0,
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        GestureDetector(
                          onTap: () => Get.back(),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 10.0,
                              horizontal: 20.0,
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xFF3E4872),
                              borderRadius: BorderRadius.circular(10.0),
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
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }

          return Dialog(
              shape: RoundedRectangleBorder(
                  side: BorderSide.none,
                  borderRadius: BorderRadius.circular(20.0)),
              elevation: 10.0,
              // backgroundColor: Color(0xFF2F2E72),
              backgroundColor: Color(0xFF333a56),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: container,
                  ),
                ),
              ));
        });
  }
}
