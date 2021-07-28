import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_utility_pro/constants.dart';
import 'package:home_utility_pro/controllers/userController.dart';
import 'package:home_utility_pro/model/userData.dart';

class GetUsersInfo extends StatelessWidget {
  final String userID;
  GetUsersInfo({this.userID});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetX<UserController>(
        init: UserController(
          userID,
        ),
        builder: (userController) {
          if (userController == null || userController.user.isEmpty) {
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
          UserData userData = userController.user[0];
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
                  // margin:
                  //     EdgeInsets.only(top: 80),
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
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      CircleAvatar(
                        radius: 55.0,
                        backgroundColor: Colors.teal,
                        backgroundImage: NetworkImage(userData.profileUrl),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Center(
                        child: Text(
                          userData.userName.toUpperCase(),
                          style: GoogleFonts.montserrat(
                            fontSize: 20.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 100,
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
                              style: GoogleFonts.montserrat(
                                fontSize: 18.0,
                                color: Colors.greenAccent,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
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
                              '${userData.userPhoneNo}',
                              style: GoogleFonts.montserrat(
                                  fontSize: 16.0,
                                  color: kWhiteColour,
                                  letterSpacing: 1.3,
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
                              userData.userEmail,
                              style: GoogleFonts.montserrat(
                                fontSize: 16.0,
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
