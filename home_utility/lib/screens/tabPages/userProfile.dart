import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_utility/components/customButton.dart';
import 'package:home_utility/components/customTextField.dart';
import 'package:home_utility/constants.dart';
import 'package:home_utility/controllers/colourController.dart';
import 'package:home_utility/controllers/textController.dart';
import 'package:home_utility/controllers/userController.dart';
import 'package:home_utility/reusableTypes.dart';
import 'package:home_utility/screens/logInScreen.dart';
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
    // textController.nameController.text = userController.user[0].userName;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
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
                          child: Container(
                            margin: EdgeInsets.only(top: size.height * 0.08),
                            child: SingleChildScrollView(
                              physics: NeverScrollableScrollPhysics(),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    height: size.height * 0.002,
                                  ),
                                  Center(
                                    child: Obx(
                                      () {
                                        if (userController.user.isEmpty)
                                          return Text(
                                            'username',
                                            style: GoogleFonts.montserrat(
                                              fontSize: 21.0,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          );
                                        return Text(
                                          userController.user[0].userName
                                              .toUpperCase(),
                                          style: GoogleFonts.montserrat(
                                            fontSize: 21.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: 120,
                                    height: 20,
                                    child: Divider(
                                      color: Colors.blueGrey,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 30.0, left: 20.0),
                                        child: Text(
                                          'My Information:',
                                          style: GoogleFonts.raleway(
                                            fontSize: 20.0,
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
                                            const EdgeInsets.only(left: 20.0),
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
                                            size: 25.0,
                                            color: Colors.purpleAccent,
                                          ),
                                        ),
                                        Flexible(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 16.0),
                                            child: Obx(
                                              () {
                                                if (userController.user.isEmpty)
                                                  return Text(
                                                    'userName',
                                                    style:
                                                        GoogleFonts.montserrat(
                                                      fontSize: 18.0,
                                                      color: Colors.white,
                                                      // fontWeight: FontWeight.bold,
                                                    ),
                                                  );
                                                return Text(
                                                  userController
                                                      .user[0].userName,
                                                  style: GoogleFonts.montserrat(
                                                    fontSize: 18.0,
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
                                            size: 25.0,
                                            color: Colors.teal,
                                          ),
                                        ),
                                        Flexible(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 16.0),
                                            child: Obx(
                                              () {
                                                if (userController.user.isEmpty)
                                                  return Text(
                                                    'phone number',
                                                    style:
                                                        GoogleFonts.montserrat(
                                                      fontSize: 18.0,
                                                      color: Colors.white,
                                                      // fontWeight: FontWeight.bold,
                                                    ),
                                                  );
                                                return Text(
                                                  '${userController.user[0].userPhoneNo}',
                                                  style: GoogleFonts.montserrat(
                                                    fontSize: 18.0,
                                                    color: Colors.white,
                                                    letterSpacing: 1.3,
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
                                            size: 25.0,
                                            color: Colors.orangeAccent,
                                          ),
                                        ),
                                        Flexible(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 16.0),
                                            child: Obx(
                                              () {
                                                if (userController.user.isEmpty)
                                                  return Text(
                                                    'email',
                                                    style:
                                                        GoogleFonts.montserrat(
                                                      fontSize: 18.0,
                                                      color: Colors.white,
                                                      // fontWeight: FontWeight.bold,
                                                    ),
                                                  );
                                                return Text(
                                                  userController
                                                      .user[0].userEmail,
                                                  style: GoogleFonts.montserrat(
                                                    fontSize: 18.0,
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
                        ),
                      ),
                      Positioned(
                        top: 20,
                        left: 45.0,
                        right: 45.0,
                        child: Obx(
                          () {
                            if (userController.user == null ||
                                userController.user.isEmpty) {
                              return CircleAvatar(
                                radius: 55.0,
                                backgroundColor: kWhiteColour,
                                backgroundImage:
                                    AssetImage('images/person.png'),
                              );
                            }

                            return CircleAvatar(
                              radius: 55,
                              backgroundColor: Colors.teal,
                              backgroundImage:
                                  userController.user[0].profileUrl == null
                                      ? AssetImage('images/person.png')
                                      : Image.network(
                                          userController.user[0].profileUrl,
                                          loadingBuilder:
                                              (context, child, progress) {
                                            if (progress == null) return child;
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
                        top: 110.0,
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
                                    colourController.changeColour(Colors.white);
                                    try {
                                      final pickedImage = ImagePicker();
                                      final pickedFile =
                                          await pickedImage.pickImage(
                                              source: ImageSource.gallery);

                                      File file = File(pickedFile.path);

                                      if (file == null) {
                                        colourController
                                            .changeColour(Colors.white54);
                                        return;
                                      }
                                      File croppedFile =
                                          await ImageCropper.cropImage(
                                              sourcePath: pickedFile.path,
                                              aspectRatioPresets: [
                                            CropAspectRatioPreset.original,
                                            CropAspectRatioPreset.ratio16x9,
                                            CropAspectRatioPreset.ratio3x2,
                                            CropAspectRatioPreset.square,
                                            CropAspectRatioPreset.ratio4x3,
                                          ]);
                                      colourController
                                          .changeColour(Colors.white54);

                                      if (croppedFile == null) return;

                                      // String fileName = file.files.single.name;
                                      // String path = file.files.single.path;
                                      bool uploaded = await cloudStorage
                                          .uploadFile(croppedFile);

                                      if (uploaded)
                                        getSnackBar(
                                            title: 'SUCCESS!',
                                            message:
                                                'Your Profile Picture was updated');
                                      else
                                        getSnackBar(
                                            title: 'ERROR!',
                                            message:
                                                'Your Profile Picture could not be updated');
                                    } catch (e) {
                                      print(e);
                                      colourController
                                          .changeColour(Colors.white54);
                                    }
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
                height: size.height * 0.02,
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
                            // isScrollControlled: true,
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
                                                labelText: 'New UserName',
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
                                              labelText: 'New Phone Number',
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
                                              textController.phoneController
                                                  .clear();
                                              textController.nameController
                                                  .clear();
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
                                            onPressed: () async {
                                              if (textController
                                                      .phoneController.text
                                                      .trim()
                                                      .isEmpty &&
                                                  textController
                                                      .nameController.text
                                                      .trim()
                                                      .isEmpty) {
                                                Get.back();
                                                return;
                                              } else if (textController
                                                  .phoneController.text
                                                  .trim()
                                                  .isEmpty) {
                                                Get.back();
                                                await usersRefrence
                                                    .child(userAuthentication
                                                        .userID)
                                                    .update({
                                                  'userName': textController
                                                      .nameController.text
                                                      .trim(),
                                                });
                                                getSnackBar(
                                                    title: 'SUCCESS!',
                                                    message:
                                                        'Your username was changed');
                                                textController.phoneController
                                                    .clear();
                                                textController.nameController
                                                    .clear();
                                                return;
                                              } else if (textController
                                                  .nameController.text
                                                  .trim()
                                                  .isEmpty) {
                                                if (textController
                                                        .phoneController.text
                                                        .trim()
                                                        .length !=
                                                    10) {
                                                  Get.back();
                                                  getSnackBar(
                                                      title: 'ERROR!',
                                                      message:
                                                          'Invalid Phone Number');
                                                  textController.phoneController
                                                      .clear();
                                                  textController.nameController
                                                      .clear();
                                                  return;
                                                }

                                                int phoneNo;
                                                try {
                                                  phoneNo = int.parse(
                                                      textController
                                                          .phoneController.text
                                                          .trim());
                                                } catch (e) {
                                                  Get.back();
                                                  getSnackBar(
                                                      title: 'ERROR!',
                                                      message:
                                                          'Invalid Phone Number');
                                                  textController.phoneController
                                                      .clear();
                                                  textController.nameController
                                                      .clear();
                                                  return;
                                                }
                                                await usersRefrence
                                                    .child(userAuthentication
                                                        .userID)
                                                    .update({
                                                  'userPhoneNo': phoneNo,
                                                });
                                                getSnackBar(
                                                    title: 'SUCCESS!',
                                                    message:
                                                        'Your phone number was changed');
                                                textController.phoneController
                                                    .clear();
                                                textController.nameController
                                                    .clear();
                                                return;
                                              } else {
                                                if (textController
                                                        .phoneController.text
                                                        .trim()
                                                        .length !=
                                                    10) {
                                                  Get.back();
                                                  getSnackBar(
                                                      title: 'ERROR!',
                                                      message:
                                                          'Invalid Phone Number');
                                                  textController.phoneController
                                                      .clear();
                                                  textController.nameController
                                                      .clear();
                                                  return;
                                                }

                                                int phoneNo;
                                                try {
                                                  phoneNo = int.parse(
                                                      textController
                                                          .phoneController.text
                                                          .trim());
                                                } catch (e) {
                                                  Get.back();
                                                  getSnackBar(
                                                      title: 'ERROR!',
                                                      message:
                                                          'Invalid Phone Number');
                                                  textController.phoneController
                                                      .clear();
                                                  textController.nameController
                                                      .clear();
                                                  return;
                                                }
                                                Get.back();
                                                await usersRefrence
                                                    .child(userAuthentication
                                                        .userID)
                                                    .update({
                                                  'userPhoneNo': phoneNo,
                                                  'userName': textController
                                                      .nameController.text
                                                      .trim(),
                                                });
                                                getSnackBar(
                                                    title: 'SUCCESS!',
                                                    message:
                                                        'Your profile was updated');
                                                textController.phoneController
                                                    .clear();
                                                textController.nameController
                                                    .clear();
                                                // return;
                                                // Get.back();
                                                return;
                                              }
                                            },
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
                      onPressed: () {
                        userAuthentication.signOut();
                        Get.offAllNamed(Login.id);
                      },
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
