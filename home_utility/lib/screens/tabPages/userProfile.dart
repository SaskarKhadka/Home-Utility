import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_utility/components/customButton.dart';
import 'package:home_utility/components/customTextField.dart';
import 'package:home_utility/constants.dart';
import 'package:home_utility/controllers/colourController.dart';
import 'package:home_utility/controllers/textController.dart';
import 'package:home_utility/controllers/userController.dart';
import 'package:home_utility/main.dart';
import 'package:home_utility/screens/registrationScreen.dart';
import 'package:image_cropper/image_cropper.dart';

class UserProfile extends StatelessWidget {
  static const id = '\UserProfile';
  final userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    final textController = Get.find<TextController>();
    // double screenWidth = MediaQuery.of(context).size.width;
    //    double screenHeight = MediaQuery.of(context).size.height;
    Size size = MediaQuery.of(context).size;
    textController.nameController.text = userController.user[0].userName;
    textController.phoneController.text =
        '+977-${userController.user[0].userPhoneNo}';
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff141a1e),
        // backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height * 0.08, //only for user profile
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                ),
                child: Container(
                  height: size.height * 0.6, //user profile
                  // height: size.height * 0.7, //pros profile

                  width: size.width,
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Container(
                          width: size.width,
                          padding: EdgeInsets.only(
                            top: 10.0,
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
                                child: Obx(
                                  () {
                                    if (userController.user.isEmpty)
                                      return Text(
                                        'User name',
                                        style: GoogleFonts.shortStack(
                                            fontSize: 24.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      );
                                    return Text(
                                      userController.user[0].userName
                                          .toUpperCase(),
                                      style: GoogleFonts.shortStack(
                                          fontSize: 24.0,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    );
                                  },
                                ),
                              ),

                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 36.0, left: 20.0),
                                    child: Text(
                                      'My Information:',
                                      style: GoogleFonts.raleway(
                                        fontSize: 16.0,
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
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 8.0,
                                  bottom: 8.0,
                                ),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 16.0),
                                      child: Icon(
                                        Icons.person,
                                        size: 22,
                                        color: Colors.purpleAccent,
                                      ),
                                    ),
                                    Flexible(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 16.0),
                                        child: Obx(
                                          () {
                                            if (userController.user.isEmpty)
                                              return Text(
                                                'userName',
                                                style: GoogleFonts.raleway(
                                                  fontSize: 16.0,
                                                  color: Colors.white,
                                                  // fontWeight: FontWeight.bold,
                                                ),
                                              );
                                            return Text(
                                              userController.user[0].userName,
                                              style: GoogleFonts.raleway(
                                                fontSize: 16.0,
                                                color: Colors.white,
                                                // fontWeight: FontWeight.bold,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 8.0,
                                  bottom: 8.0,
                                ),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 16.0),
                                      child: Icon(
                                        Icons.phone,
                                        size: 22,
                                        color: Colors.teal,
                                      ),
                                    ),
                                    Flexible(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 16.0),
                                        child: Obx(
                                          () {
                                            if (userController.user.isEmpty)
                                              return Text(
                                                'phone number',
                                                style: GoogleFonts.raleway(
                                                  fontSize: 16.0,
                                                  color: Colors.white,
                                                  // fontWeight: FontWeight.bold,
                                                ),
                                              );
                                            return Text(
                                              '${userController.user[0].userPhoneNo}',
                                              style: GoogleFonts.raleway(
                                                fontSize: 16.0,
                                                color: Colors.white,
                                                // fontWeight: FontWeight.bold,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // ),
                              SizedBox(
                                height: size.height * 0.005,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 8.0,
                                  bottom: 8.0,
                                ),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 16.0),
                                      child: Icon(
                                        Icons.email,
                                        size: 22,
                                        color: Colors.orangeAccent,
                                      ),
                                    ),
                                    Flexible(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 16.0),
                                        child: Obx(
                                          () {
                                            if (userController.user.isEmpty)
                                              return Text(
                                                'email',
                                                style: GoogleFonts.raleway(
                                                  fontSize: 16.0,
                                                  color: Colors.white,
                                                  // fontWeight: FontWeight.bold,
                                                ),
                                              );
                                            return Text(
                                              userController.user[0].userEmail,
                                              style: GoogleFonts.raleway(
                                                fontSize: 16.0,
                                                color: Colors.white,
                                                // fontWeight: FontWeight.bold,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // ),
                              SizedBox(
                                height: size.height * 0.005,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 20,
                        left: 45.0,
                        right: 45.0,
                        child: Obx(
                          () {
                            if (userController.user[0].profileUrl == null ||
                                userController.user[0].profileUrl.isEmpty) {
                              return CircleAvatar(
                                radius: 65,
                                backgroundColor: kWhiteColour,
                                backgroundImage:
                                    AssetImage('images/person.png'),
                              );
                            }

                            return CircleAvatar(
                              radius: 55,
                              backgroundColor: Colors.redAccent,
                              backgroundImage: Image.network(
                                userController.user[0].profileUrl,
                                loadingBuilder: (context, child, usergress) {
                                  if (usergress == null) return child;
                                  return CircularProgressIndicator(
                                    color: kWhiteColour,
                                  );
                                },
                              ).image,
                            );
                          },
                          // child: CircleAvatar(
                          //   radius: 55.0,
                          //   backgroundColor: Colors.redAccent,
                          // ),
                        ),
                      ),
                      Positioned(
                        top: 125.0,
                        left: 100.0,
                        right: 35.0,
                        child: GetX<ColourController>(
                            init: ColourController(),
                            builder: (colourController) {
                              return CircleAvatar(
                                radius: 12,
                                backgroundColor: colourController.color,
                                child: GestureDetector(
                                  child: Icon(
                                    Icons.camera_alt_rounded,
                                    color: Colors.black,
                                    size: 17,
                                  ),
                                  onTap: () async {
                                    colourController
                                        .changeColour(Colors.tealAccent);
                                    FilePickerResult file =
                                        await FilePicker.platform.pickFiles(
                                      type: FileType.image,
                                      allowMultiple: false,
                                    );

                                    if (file == null) {
                                      colourController.changeColour(
                                          Colors.tealAccent.withOpacity(0.8));
                                      return;
                                    }
                                    File croppedFile =
                                        await ImageCropper.cropImage(
                                            sourcePath: file.files.single.path,
                                            aspectRatioPresets: [
                                          CropAspectRatioPreset.original,
                                          CropAspectRatioPreset.ratio16x9,
                                          CropAspectRatioPreset.ratio3x2,
                                          CropAspectRatioPreset.square,
                                          CropAspectRatioPreset.ratio4x3,
                                        ]);
                                    colourController.changeColour(
                                        Colors.tealAccent.withOpacity(0.8));

                                    if (croppedFile == null) return;

                                    // String fileName = file.files.single.name;
                                    // String path = file.files.single.path;
                                    bool uploaded = await cloudStorage
                                        .uploadFile(croppedFile);

                                    if (uploaded)
                                      getSnackBar(
                                          title: 'SUCCESS!',
                                          message:
                                              'Your userfile Picture was updated');
                                  },
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.04,
              ),
              Row(
                children: [
                  Expanded(
                    child: ProfileButton(
                      onPressed: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => EditProfile()),
                        // );
                        showBottomSheet(
                            elevation: 4.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(26.0),
                                topRight: Radius.circular(26.0),
                              ),
                            ),
                            // backgroundColor: Color(0xFF0E0E0F),
                            backgroundColor: Color(0xFF1D1E20),
                            context: context,
                            builder: (context) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 16.0),
                                        child: Text(
                                          'Edit Info',
                                          style: GoogleFonts.shortStack(
                                            color: kWhiteColour,
                                            fontSize: 24.0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 200,
                                    child: Divider(
                                      color: Colors.tealAccent,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(15.0),
                                        ),
                                      ),
                                      // height: size.height * 0.3,
                                      // width: screenWidth,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0),
                                              child: CustomTextField2(
                                                textcontroller: textController
                                                    .nameController,
                                                focusColour2: Colors.tealAccent,
                                                focusColour: Colors.grey,
                                                isPhoneNumber: false,
                                                labelText: 'My UserName',
                                                hintText: 'Update Username',
                                                textColour: Colors.white,
                                                icon: Icons.person,
                                                iconColour: Colors.blue,
                                                cursorColour: Colors.white,
                                                borderRadius: 30.0,
                                              ),
                                            ),
                                            SizedBox(
                                              height: size.height * 0.02,
                                            ),
                                            CustomTextField2(
                                              focusColour2: Colors.tealAccent,
                                              focusColour: Colors.grey,
                                              isPhoneNumber: false,
                                              labelText: 'My Phone Number',
                                              hintText: 'Update Phone Number',
                                              textcontroller: textController
                                                  .phoneController,
                                              textColour: Colors.white,
                                              icon: Icons.phone,
                                              iconColour: Colors.green,
                                              cursorColour: Colors.white,
                                              borderRadius: 30.0,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 8.0,
                                      right: 8.0,
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Expanded(
                                          child: ProfileButton(
                                            onPressed: () {
                                              Get.back();
                                            },
                                            buttonHeight: 45.0,
                                            primaryColour: kPrimaryColor,
                                            shadowColour: kSecondaryColor,
                                            borderRadius: 8.0,
                                            borderSideWidth: 0.5,
                                            borderSideColour: kSecondaryColor,
                                            buttonText: 'Cancel',
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
                                            buttonText: 'Update Profile',
                                            textColour: kSecondaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            });
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
                height: size.height * 0.02,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
