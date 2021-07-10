import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_utility_pro/components/customButton.dart';
import 'package:home_utility_pro/components/displayField.dart';
import 'package:home_utility_pro/controllers/colourController.dart';
import 'package:home_utility_pro/controllers/proController.dart';
import 'package:home_utility_pro/location/userLocation.dart';
import 'package:home_utility_pro/main.dart';
import 'package:home_utility_pro/screens/googleMapsScreen.dart';
import 'package:home_utility_pro/screens/registrationScreen.dart';
import 'package:home_utility_pro/screens/tabPages/profile/editprofile.dart';
import 'package:image_cropper/image_cropper.dart';

import '../../constants.dart';

class ProsProfile extends StatelessWidget {
  final proController = Get.put(ProController());

  @override
  Widget build(BuildContext context) {
    // double screenWidth = MediaQuery.of(context).size.width;
    //    double screenHeight = MediaQuery.of(context).size.height;
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff141a1e),
        body: SingleChildScrollView(
          child: Container(
            child: Stack(
              // textDirection: TextDirection.ltr,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(25.0),
                    //   child: CircleAvatar(
                    //     radius: 65.0,
                    //     backgroundColor: Colors.white,
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Obx(() {
                        if (proController.pro[0].profileUrl == null ||
                            proController.pro[0].profileUrl.isEmpty) {
                          return CircleAvatar(
                            radius: 65,
                            backgroundColor: kWhiteColour,
                            backgroundImage: AssetImage('images/person.png'),
                          );
                        }

                        return CircleAvatar(
                          radius: 55,
                          backgroundColor: Colors.black,
                          backgroundImage: Image.network(
                            proController.pro[0].profileUrl,
                            loadingBuilder: (context, child, progress) {
                              if (progress == null) return child;
                              return CircularProgressIndicator(
                                color: kWhiteColour,
                              );
                            },
                          ).image,
                        );
                        // return CircleAvatar(
                        //   radius: 55,
                        //   backgroundColor: Colors.black,
                        //   backgroundImage: NetworkImage(
                        //     proController.pro[0].profileUrl,
                        //   ),
                        // );
                      }),
                    ),
                    Obx(
                      () {
                        if (proController.pro.isEmpty)
                          return Text(
                            'Username',
                            // userData['userName'],
                            style: GoogleFonts.castoro(
                                fontSize: 30,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          );
                        return Text(
                          proController.pro[0].prosName,
                          // userData['userName'],
                          style: GoogleFonts.castoro(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        );
                      },
                    ),

                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Obx(
                      () {
                        if (proController.pro.isEmpty)
                          return Text(
                            'profession',
                            // userData['userName'],
                            style: GoogleFonts.shortStack(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          );
                        return Text(
                          proController.pro[0].profession,
                          // userData['userName'],
                          style: GoogleFonts.shortStack(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        );
                      },
                    ),

                    SizedBox(
                      width: 200.0,
                      child: Divider(
                        color: Colors.white54,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.011,
                    ),
                    SizedBox(
                      height: size.height * 0.011,
                    ),
                    DisplayField(
                      icon: EvaIcons.phone,
                      iconSize: 20.0,
                      iconColour: Colors.teal,
                      borderRadius: 50.0,
                      text: '${proController.pro[0].prosPhoneNo}',
                      displaytext: 'Phone Number',
                      textColour: Colors.black,
                      marginHorizontal: 25.0,
                      marginVertical: 10.0,
                      boxColor: Colors.white,
                    ),
                    DisplayField(
                      icon: EvaIcons.email,
                      iconSize: 20.0,
                      iconColour: Color(0xfffbbf11),
                      borderRadius: 50.0,
                      text: proController.pro[0].prosEmail,
                      displaytext: 'Email',
                      textColour: Colors.black,
                      marginHorizontal: 25.0,
                      marginVertical: 10.0,
                      boxColor: Colors.white,
                    ),
                    DisplayField(
                      icon: Icons.location_on,
                      iconSize: 20.0,
                      iconColour: Colors.blue,
                      borderRadius: 50.0,
                      text: proController.pro[0].prosMunicipality +
                          ', ' +
                          proController.pro[0].prosDistrict,
                      displaytext: 'Address',
                      textColour: Colors.black,
                      marginHorizontal: 25.0,
                      marginVertical: 10.0,
                      boxColor: Colors.white,
                    ),

                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ProfileButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditProfile()),
                              );
                            },
                            buttonHeight: 45.0,
                            primaryColour: kPrimaryColor,
                            shadowColour: kSecondaryColor,
                            borderRadius: 8.0,
                            borderSideWidth: 0.5,
                            borderSideColour: kSecondaryColor,
                            buttonText: 'Edit Profile',
                            textColour: kSecondaryColor,
                          ),
                        ),
                        Expanded(
                          child: ProfileButton(
                            onPressed: () {},
                            buttonHeight: 45.0,
                            primaryColour: kPrimaryColor,
                            shadowColour: kSecondaryColor,
                            borderRadius: 8.0,
                            borderSideWidth: 0.5,
                            borderSideColour: kSecondaryColor,
                            buttonText: 'Sign Out',
                            textColour: kSecondaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.30,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
