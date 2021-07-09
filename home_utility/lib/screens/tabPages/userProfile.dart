import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_utility/components/dialogBox.dart';
import 'package:home_utility/constants.dart';
import 'package:home_utility/controllers/colourController.dart';
import 'package:home_utility/controllers/userController.dart';
import 'package:home_utility/main.dart';
import 'package:home_utility/screens/logInScreen.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:home_utility/location/google_map_screen.dart';

import '../registrationScreen.dart';

class UserProfile extends StatelessWidget {
  final userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    //    double screenHeight = MediaQuery.of(context).size.height;
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child:
              // Obx(() {
              //   if (userController == null && userController.userData == null) {
              //     return Center(
              //       child: CircularProgressIndicator(),
              //     );
              //   }
              //   return
              Container(
            child: Stack(
              textDirection: TextDirection.ltr,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      height: 130,
                      width: double.infinity,
                      color: Colors.black,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10),
                      child: Container(
                        width: screenWidth,
                        decoration: BoxDecoration(
                            color: Color(0xff6A5CD0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(23))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 60, left: 20),
                              child: Obx(
                                () {
                                  if (userController.user.isEmpty)
                                    return Text(
                                      'Username',
                                      // userData['userName'],
                                      style: GoogleFonts.montserrat(
                                          fontSize: 22,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    );
                                  return Text(
                                    userController.user[0].userName,
                                    // userData['userName'],
                                    style: GoogleFonts.montserrat(
                                        fontSize: 22,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(height: 30),
                          ],
                        ),
                      ),
                    ),
                    // Container(
                    //   height: 10,
                    //   width: double.infinity,
                    //   color: Colors.black,
                    // ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10),
                      child: Container(
                        width: screenWidth,
                        decoration: BoxDecoration(
                          color: Color(0xff1F1D2B),
                          border: Border.all(
                            color: kWhiteColour,
                            width: 1.0,
                            style: BorderStyle.solid,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: <Widget>[
                              SizedBox(width: 10),
                              Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xffea473c),
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Color(0xffea473c).withOpacity(0.6),
                                        spreadRadius: 3,
                                        blurRadius: 10,
                                        offset: Offset(
                                            2, 4), // changes position of shadow
                                      ),
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Icon(
                                    EvaIcons.personOutline,
                                    color: Colors.white,
                                    size: 40,
                                  ),
                                ),
                              ),
                              SizedBox(width: 50),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('USERNAME',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(height: 6),
                                  Obx(
                                    () {
                                      if (userController.user.isEmpty)
                                        return Text('Username',
                                            // userData['userName'],
                                            style: GoogleFonts.roboto(
                                                fontSize: 16,
                                                color: Colors.white70));
                                      return Text(
                                        userController.user[0].userName,
                                        // userData['userName'],
                                        style: GoogleFonts.roboto(
                                            fontSize: 16,
                                            color: Colors.white70),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10),
                      child: Container(
                        width: screenWidth,
                        decoration: BoxDecoration(
                            color: Color(0xff1F1D2B),
                            border: Border.all(
                              color: kWhiteColour,
                              width: 1.0,
                              style: BorderStyle.solid,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: <Widget>[
                              SizedBox(width: 10),
                              Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xff2CCD7A),
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Color(0xff2CCD7A).withOpacity(0.6),
                                        spreadRadius: 3,
                                        blurRadius: 10,
                                        offset: Offset(
                                            2, 4), // changes position of shadow
                                      ),
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Icon(
                                    EvaIcons.emailOutline,
                                    color: Colors.white,
                                    size: 40,
                                  ),
                                ),
                              ),
                              SizedBox(width: 50),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('EMAIL',
                                        style: GoogleFonts.montserrat(
                                            fontSize: 20,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(height: 6),
                                    Obx(
                                      () {
                                        if (userController.user.isEmpty)
                                          return Text('Email',
                                              // userData['userName'],
                                              style: GoogleFonts.roboto(
                                                  fontSize: 16,
                                                  color: Colors.white70));
                                        return Text(
                                          userController.user[0].userEmail,
                                          // userData['userName'],
                                          style: GoogleFonts.roboto(
                                              fontSize: 16,
                                              color: Colors.white70),
                                        );
                                      },
                                    ),
                                  ]),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10),
                      child: Container(
                        width: screenWidth,
                        decoration: BoxDecoration(
                            color: Color(0xff1F1D2B),
                            border: Border.all(
                              color: kWhiteColour,
                              width: 1.0,
                              style: BorderStyle.solid,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: <Widget>[
                              SizedBox(width: 10),
                              Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xff8F77FF),
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Color(0xff8F77FF).withOpacity(0.6),

                                        spreadRadius: 3,
                                        blurRadius: 10,
                                        offset: Offset(
                                            2, 4), // changes position of shadow
                                      ),
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Icon(
                                    EvaIcons.phoneOutline,
                                    color: Colors.white,
                                    size: 40,
                                  ),
                                ),
                              ),
                              SizedBox(width: 50),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('PHONE NUMBER',
                                        style: GoogleFonts.montserrat(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(height: 6),
                                    Obx(
                                      () {
                                        if (userController.user.isEmpty)
                                          return Text('Phone Number',
                                              // userData['userName'],
                                              style: GoogleFonts.roboto(
                                                  fontSize: 16,
                                                  color: Colors.white70));
                                        return Text(
                                          '${userController.user[0].userPhoneNo}',
                                          // userData['userName'],
                                          style: GoogleFonts.roboto(
                                              fontSize: 16,
                                              color: Colors.white70),
                                        );
                                      },
                                    ),
                                  ]),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10),
                      child: Container(
                        width: screenWidth,
                        decoration: BoxDecoration(
                            color: Color(0xff1F1D2B),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: <Widget>[
                              SizedBox(width: 10),
                              Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xffFEC946),
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Color(0xffFEC946).withOpacity(0.6),
                                        spreadRadius: 3,
                                        blurRadius: 10,
                                        offset: Offset(
                                            2, 4), // changes position of shadow
                                      ),
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Icon(
                                    EvaIcons.homeOutline,
                                    color: Colors.white,
                                    size: 40,
                                  ),
                                ),
                              ),
                              SizedBox(width: 50),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('ADDRESS',
                                        style: GoogleFonts.montserrat(
                                            fontSize: 20,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(height: 6),
                                    Text('Bharatpur,Chitwan',
                                        style: GoogleFonts.roboto(
                                            fontSize: 16,
                                            color: Colors.white70)),
                                  ]),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      padding: EdgeInsets.only(
                        right: 10.0,
                        left: 10.0,
                      ),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => GoogleMapScreen()),
                                );
                              },
                              child: Container(
                                height: size.height * 0.07,
                                width: size.width * 0.4,
                                decoration: BoxDecoration(
                                    color: Color(0xFF3BACA2),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Color(0xff8F77FF).withOpacity(0.3),
                                        spreadRadius: 3,
                                        blurRadius: 10,
                                        offset: Offset(
                                            2, 7), // changes position of shadow
                                      ),
                                    ]),
                                child: Center(
                                  child: Text(
                                    'Edit Profile',
                                    style: GoogleFonts.roboto(
                                        color: Colors.white70, fontSize: 18),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            GestureDetector(
                              onTap: () async {
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context) => DialogBox(
                                    title: 'Signing Out',
                                  ),
                                );
                                await userAuthentication.signOut();
                                Get.offAndToNamed(LogInScreen.id);
                              },
                              child: Container(
                                height: size.height * 0.07,
                                width: size.width * 0.4,
                                decoration: BoxDecoration(
                                    color: Color(0xFFCF433E),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Color(0xff8F77FF).withOpacity(0.3),
                                        spreadRadius: 3,
                                        blurRadius: 10,
                                        offset: Offset(
                                            2, 7), // changes position of shadow
                                      ),
                                    ]),
                                child: Center(
                                  child: Text(
                                    'Sign Out',
                                    style: GoogleFonts.roboto(
                                        color: Colors.white70, fontSize: 18),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: 60,
                  left: 130,
                  right: 130,
                  child: Obx(() {
                    if (userController.user[0].profileUrl == null ||
                        userController.user[0].profileUrl.isEmpty) {
                      return CircleAvatar(
                        radius: 55,
                        backgroundColor: Colors.black,
                        backgroundImage: AssetImage('images/person.png'),
                      );
                    }

                    return CircleAvatar(
                      radius: 55,
                      backgroundColor: Colors.black,
                      backgroundImage: Image.network(
                        userController.user[0].profileUrl,
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
                Positioned(
                  top: 142,
                  left: 170,
                  right: 120,
                  child: GetX<ColourController>(
                      init: ColourController(),
                      builder: (colourController) {
                        return CircleAvatar(
                          radius: 15,
                          backgroundColor: colourController.color,
                          child: GestureDetector(
                            child: Icon(
                              Icons.camera_alt_rounded,
                              color: Colors.white,
                              size: 15,
                            ),
                            onTap: () async {
                              colourController.changeColour(Colors.black);
                              FilePickerResult file =
                                  await FilePicker.platform.pickFiles(
                                type: FileType.image,
                                allowMultiple: false,
                              );

                              if (file == null) {
                                colourController.changeColour(
                                    Colors.black.withOpacity(0.2));
                                return;
                              }
                              File croppedFile = await ImageCropper.cropImage(
                                  sourcePath: file.files.single.path,
                                  aspectRatioPresets: [
                                    CropAspectRatioPreset.original,
                                    CropAspectRatioPreset.ratio16x9,
                                    CropAspectRatioPreset.ratio3x2,
                                    CropAspectRatioPreset.square,
                                    CropAspectRatioPreset.ratio4x3,
                                  ]);
                              colourController
                                  .changeColour(Colors.black.withOpacity(0.2));

                              if (croppedFile == null) return;

                              // String fileName = file.files.single.name;
                              // String path = file.files.single.path;
                              bool uploaded =
                                  await cloudStorage.uploadFile(croppedFile);

                              if (uploaded)
                                getSnackBar(
                                    title: 'SUCCESS!',
                                    message:
                                        'Your Profile Picture was updated');
                            },
                          ),
                        );
                      }),
                ),
              ],
            ),
            //   );
            // }),
          ),
        ),
      ),
    );
  }
}
