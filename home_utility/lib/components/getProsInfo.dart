import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_utility/constants.dart';
import 'package:home_utility/controllers/proController.dart';
import 'package:home_utility/model/proData.dart';

class GetProsInfo extends StatelessWidget {
  static const id = '\getProsInfo';
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
                    borderRadius: BorderRadius.circular(20.0),
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
                          prosData.prosName.toUpperCase(),
                          style: GoogleFonts.shortStack(
                            fontSize: 20.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 6.0),
                        child: Text(
                          prosData.profession,
                          style: GoogleFonts.sansita(
                            fontSize: 16.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      RatingStars(
                        value: prosData.avgRating,
                        starCount: 5,
                        starSize: 15,
                        starColor: Color(0xffF3CF31),
                        starSpacing: 2,
                        starOffColor: const Color(0xffe7e8ea),
                        valueLabelColor: Colors.red,
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
                                const EdgeInsets.only(top: 26.0, left: 20.0),
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
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Text(
                              '${prosData.prosPhoneNo}',
                              style: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  color: kWhiteColour,
                                  fontWeight: FontWeight.bold),
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
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Text(
                              prosData.prosEmail,
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
  }
}
