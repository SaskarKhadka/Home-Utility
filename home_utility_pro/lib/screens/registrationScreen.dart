import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_utility_pro/constants.dart';
import 'package:home_utility_pro/model/services.dart';
import 'package:home_utility_pro/model/servicesHandler.dart';
import 'package:home_utility_pro/screens/prosInfoScreen.dart';
import 'logInScreen.dart';
import '../components/customButton.dart';
import '../components/customTextField.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/dialogBox.dart';
import '../main.dart';
import '../components/customPasswordTextField.dart';

class RegistrationScreen extends StatefulWidget {
  static const id = '/register';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  String value;
  ServiceHandler serviceHandler = ServiceHandler();
  @override
  void initState() {
    // TODO: implement initState
    value = serviceHandler.getServices()[0].getProfession();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kBlackColour,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: size.height * 0.08,
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => Get.toNamed(LogInScreen.id),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 5.0,
                      horizontal: 21.0,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(
                        style: BorderStyle.solid,
                        color: Colors.white,
                        width: 1.0,
                      ),
                    ),
                    child: Text(
                      'SIGN IN',
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 2,
                        fontSize: 30,
                        wordSpacing: 2,
                        // decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 4.6,
                      horizontal: 17.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Text(
                      'SIGN UP',
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        letterSpacing: 2,
                        fontSize: 30,
                        wordSpacing: 2,
                        // decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(60.0),
                    // topLeft: Radius.circular(120.0),
                    // bottomLeft: Radius.circular(60.0),
                    // bottomRight: Radius.circular(50.0),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: size.height * 0.035,
                    horizontal: size.width * 0.07,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomTextField(
                            textController: nameController,
                            isPhoneNumber: false,
                            icon: EvaIcons.personOutline,
                            labelText: 'Name',
                            hintText: 'Enter your name',
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          // CustomTextField(
                          //   textController: addressController,
                          //   isPhoneNumber: false,
                          //   icon: EvaIcons.personOutline,
                          //   labelText: 'Address',
                          //   hintText: 'Enter your municipality/VDC',
                          // ),
                          // SizedBox(
                          //   height: size.height * 0.03,
                          // ),
                          CustomTextField(
                            textController: phoneController,
                            isPhoneNumber: true,
                            icon: EvaIcons.phoneCallOutline,
                            labelText: 'Phone Number',
                            hintText: 'Enter your phone number',
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          CustomTextField(
                            textController: emailController,
                            isPhoneNumber: false,
                            icon: Icons.email_outlined,
                            labelText: 'Email',
                            hintText: 'Enter your email address',
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          CustomPasswordTextField(
                            textController: passwordController,
                            icon: EvaIcons.lockOutline,
                            labelText: 'Password',
                            hintText: 'Enter your password',
                          ),
                          SizedBox(
                            height: size.height * 0.06,
                          ),
                          CustomButton(
                            text: 'SIGN UP',
                            onTap: () async {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) => DialogBox(
                                  title: 'Registering',
                                ),
                              );

                              await _checkValidation();
                            },
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _checkValidation() async {
    if (nameController.text.trim().isEmpty) {
      Get.back();
      getSnackBar(
        title: 'ERROR!',
        message: 'Your name is mandatory.',
      );
      return;
    } else if (phoneController.text.isEmpty) {
      Get.back();
      getSnackBar(
        title: 'ERROR!',
        message: 'Your phone number is mandatory.',
      );
      return;
    } else if (phoneController.text.trim().length != 10) {
      Get.back();
      getSnackBar(
        title: 'ERROR!',
        message: 'Inavlid phone number.',
      );
      return;
    } else if (!emailController.text.isEmail) {
      Get.back();
      getSnackBar(
        title: 'ERROR!',
        message: 'Please enter a valid email address',
      );
      return;
    } else if (passwordController.text.length < 8) {
      Get.back();
      getSnackBar(
        title: 'ERROR!',
        message: 'Password must be atleast 8 characters long.',
      );
      return;
      // } else if (phoneController.text.trim().length == 10) {
    } else {
      try {
        int phoneNo = int.parse(phoneController.text);

        bool isAlreadyUsed = await database.checkPhoneNumber(phoneNo);

        if (isAlreadyUsed) {
          Get.back();
          getSnackBar(
            title: 'ERROR!',
            message: 'The phone number is already in use',
          );
          return;
        } else {
          String code = await userAuthentication.signUp(
              name: nameController.text.trim(),
              phoneNo: phoneNo,
              email: emailController.text.trim(),
              password: passwordController.text);

          if (code == 'success') {
            Get.back();
            getSnackBar(
              title: 'CONGRATULATIONS!',
              message: 'Your account has been created',
            );
            // // String email = emailController.text.trim();
            // await userAuthentication.sendEmailVerification();

            // // userAuthentication.signOut();
            // // if (code == 'success') {

            // showDialog(
            //   barrierDismissible: false,
            //   context: context,
            //   builder: (context) {
            //     return Dialog(
            //       backgroundColor: kWhiteColour,
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(10.0),
            //         side: BorderSide(
            //           color: kBlackColour,
            //           width: 4.0,
            //           style: BorderStyle.solid,
            //         ),
            //       ),
            //       child: Container(
            //         padding: EdgeInsets.all(20.0),
            //         child: Column(
            //           mainAxisSize: MainAxisSize.min,
            //           children: [
            //             Text(
            //               'We have sent a verification link to your email address.\nYou have to verify your email before moving forward.',
            //               textAlign: TextAlign.center,
            //               style: GoogleFonts.montserrat(
            //                 fontSize: 20.0,
            //               ),
            //             ),
            //             SizedBox(
            //               height: 15,
            //             ),
            //             CustomButton(
            //               onTap: () async {
            //                 await userAuthentication.reload();
            //                 // CircularProgressIndicator();
            //                 if (await userAuthentication.isEmailVerified()) {
            //                   Get.back();

            //                   Get.offAllNamed(ProsInfoScreen.id);
            //                   getSnackBar(
            //                     title: 'CONGRATULATIONS!',
            //                     message: 'Your email has been verified',
            //                   );
            //                 } else {
            //                   Get.back();
            //                   userAuthentication.signOut();
            //                   getSnackBar(
            //                     title: 'ERROR!',
            //                     message: 'Your email has not been verified',
            //                   );
            //                 }
            //               },
            //               text: 'Confirm',
            //             ),
            //             SizedBox(
            //               height: 8,
            //             ),
            //             CustomButton(
            //               onTap: () async {
            //                 String code = await userAuthentication
            //                     .sendEmailVerification();

            //                 if (code == 'too-many-requests') {
            //                   getSnackBar(
            //                       title: 'ALERT!',
            //                       message:
            //                           'Too many requests. We have blocked all requests from this device due to unusual activity. Try again later.');
            //                 }
            //               },
            //               text: 'Resend',
            //             ),
            //           ],
            //         ),
            //       ),
            //     );
            //   },
            // );

            // // prosProfessionValue = await database.prosProfession;
            // // category = professionToCategory(prosProfessionValue);

            // // Get.back();

            Get.offAllNamed(ProsInfoScreen.id);
          } else if (code == 'email-already-exists') {
            Get.back();
            getSnackBar(
              title: 'ERROR!',
              message:
                  'Email already exists! Try logging in if you already have an account.',
            );
            return;
          } else {
            Get.back();
            getSnackBar(
              title: 'ERROR!',
              message: 'Cannot create your account',
            );
            return;
          }
        }
      } catch (e) {
        Get.back();
        getSnackBar(
          title: 'ERROR!',
          message: 'Please enter a valid phone number',
        );
        return;
      }
    }
  }
}

getSnackBar({String title, String message}) {
  Get.snackbar(
    title,
    message,
    titleText: Text(
      title,
      style: TextStyle(
        fontSize: 20.0,
        color: Colors.white,
      ),
    ),
    messageText: Text(
      message,
      style: TextStyle(
        fontSize: 15.0,
        color: Colors.white,
      ),
    ),
    snackPosition: SnackPosition.BOTTOM,
    colorText: Colors.white,
    margin: EdgeInsets.all(15.0),
    padding: EdgeInsets.all(15.0),
    backgroundColor: Color(0xff131313),
    snackStyle: SnackStyle.FLOATING,
  );
}
