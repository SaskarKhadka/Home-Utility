import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_utility_pro/components/customButton.dart';
import 'package:home_utility_pro/components/customTextField.dart';
import 'package:home_utility_pro/controllers/colourController.dart';
import 'package:home_utility_pro/controllers/proController.dart';
import 'package:home_utility_pro/main.dart';
import 'package:home_utility_pro/screens/registrationScreen.dart';
import 'package:image_cropper/image_cropper.dart';

import '../../constants.dart';

class ProsProfile extends StatelessWidget {
  final proController = Get.put(ProController());
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // double screenWidth = MediaQuery.of(context).size.width;
    //    double screenHeight = MediaQuery.of(context).size.height;
    Size size = MediaQuery.of(context).size;
    nameController.text = proController.pro[0].prosName;
    phoneController.text = '+977-${proController.pro[0].prosPhoneNo}';
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
                height: size.height * 0.05, //only for users profile
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                ),
                child: Container(
                  // height: size.height * 0.6, //users profile
                  height: size.height * 0.7, //pros profile

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
                                    if (proController.pro.isEmpty)
                                      return Text(
                                        'User name',
                                        style: GoogleFonts.shortStack(
                                            fontSize: 24.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      );
                                    return Text(
                                      proController.pro[0].prosName
                                          .toUpperCase(),
                                      style: GoogleFonts.shortStack(
                                          fontSize: 24.0,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    );
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 6.0),
                                child: Obx(
                                  () {
                                    if (proController.pro.isEmpty)
                                      return Text(
                                        'profession',
                                        style: GoogleFonts.sansita(
                                            fontSize: 16.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      );
                                    return Text(
                                      proController.pro[0].profession,
                                      style: GoogleFonts.sansita(
                                          fontSize: 16.0,
                                          color: Colors.white60,
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
                                            if (proController.pro.isEmpty)
                                              return Text(
                                                'user name',
                                                style: GoogleFonts.raleway(
                                                  fontSize: 16.0,
                                                  color: Colors.white,
                                                  // fontWeight: FontWeight.bold,
                                                ),
                                              );
                                            return Text(
                                              proController.pro[0].prosName,
                                              style: GoogleFonts.raleway(
                                                fontSize: 16.0,
                                                color: Colors.white,
                                                // fontWeight: FontWeight.bold,
                                              ),
                                            );
                                          },
                                        ),
                                        // child: Text(
                                        //   'Rohan Dhakal',
                                        //   style: GoogleFonts.raleway(
                                        //     fontSize: 16.0,
                                        //     color: Colors.white,
                                        //   ),
                                        // ),
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
                                            if (proController.pro.isEmpty)
                                              return Text(
                                                'phone number',
                                                style: GoogleFonts.raleway(
                                                  fontSize: 16.0,
                                                  color: Colors.white,
                                                  // fontWeight: FontWeight.bold,
                                                ),
                                              );
                                            return Text(
                                              '${proController.pro[0].prosPhoneNo}',
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
                                            if (proController.pro.isEmpty)
                                              return Text(
                                                'email',
                                                style: GoogleFonts.raleway(
                                                  fontSize: 16.0,
                                                  color: Colors.white,
                                                  // fontWeight: FontWeight.bold,
                                                ),
                                              );
                                            return Text(
                                              proController.pro[0].prosEmail,
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
                                        Icons.location_on,
                                        size: 22,
                                        color: Colors.blue,
                                      ),
                                    ),
                                    Flexible(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 16.0),
                                        child: Obx(
                                          () {
                                            if (proController.pro.isEmpty)
                                              return Text(
                                                'municipality, district',
                                                style: GoogleFonts.raleway(
                                                  fontSize: 16.0,
                                                  color: Colors.white,
                                                  // fontWeight: FontWeight.bold,
                                                ),
                                              );
                                            return Text(
                                              proController
                                                      .pro[0].prosMunicipality +
                                                  ', ' +
                                                  proController
                                                      .pro[0].prosDistrict,
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
                            if (proController.pro[0].profileUrl == null ||
                                proController.pro[0].profileUrl.isEmpty) {
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
                                proController.pro[0].profileUrl,
                                loadingBuilder: (context, child, progress) {
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
                                              'Your Profile Picture was updated');
                                  },
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                ),
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
                height: size.height * 0.05,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
