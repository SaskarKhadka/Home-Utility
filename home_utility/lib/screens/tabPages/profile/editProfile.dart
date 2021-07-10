import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_utility/components/customButton.dart';
import 'package:home_utility/components/customPasswordTextField.dart';
import 'package:home_utility/components/customTextField.dart';
import 'package:home_utility/constants.dart';
import 'package:home_utility/controllers/colourController.dart';
import 'package:home_utility/controllers/userController.dart';
import 'package:home_utility/main.dart';
import 'package:home_utility/screens/registrationScreen.dart';

import 'package:image_cropper/image_cropper.dart';

import '../../logInScreen.dart';

class EditProfile extends StatefulWidget {
  static const id = 'editProfile';
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final userController = Get.put(UserController());

  TextEditingController nameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(0xff141a1e),
      body: SingleChildScrollView(
        child: Container(
          child: StreamBuilder(
            stream: prosRefrence.child(userAuthentication.userID).onValue,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              Map userData = snapshot.data.snapshot.value;
              nameController.text = userController.user[0].userName;
              phoneController.text =
                  '+977-${userController.user[0].userPhoneNo}';
              // passController.text = userController.user[0].password;
              // passController.text = userData['userPassword'];

              return Padding(
                padding: const EdgeInsets.all(8.0),
                // child: Container(
                //   width: screenWidth,
                //   color: Color(0xff141a1e),
                child: Stack(
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: size.height * 0.05,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: Obx(() {
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
                        SizedBox(
                          height: size.height * 0.05,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xFF252A30),
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
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: CustomTextField2(
                                      textcontroller: nameController,
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
                                    textcontroller: phoneController,
                                    textColour: Colors.white,
                                    icon: Icons.phone,
                                    iconColour: Colors.green,
                                    cursorColour: Colors.white,
                                    borderRadius: 30.0,
                                  ),
                                  SizedBox(
                                    height: size.height * 0.02,
                                  ),
                                  CustomPasswordTextField2(
                                    focusColour2: Colors.tealAccent,
                                    focusColour: Colors.grey,
                                    labelText: 'My Password',
                                    hintText: 'Update Password',
                                    textcontroller: passController,
                                    textColour: Colors.white,
                                    icon: Icons.lock,
                                    iconColour: Colors.orange,
                                    cursorColour: Colors.white,
                                    borderRadius: 30.0,
                                    isFilled: false,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.05,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: ProfileButton(
                                onPressed: () {
                                  // Get.offAllNamed(LogInScreen.id);
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
                            )
                          ],
                        ),
                      ],
                    ),
                    Positioned(
                      top: 155,
                      left: 220,
                      right: 120,
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
                                  size: 16,
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
                                            'Your Profile Picture was updated');
                                },
                              ),
                            );
                          }),
                    ),
                  ],
                ),
                // ),
              );
            },
          ),
        ),
      ),
    );
  }
}
