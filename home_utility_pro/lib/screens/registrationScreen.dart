import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:home_utility_pro/components/customPasswordTextField.dart';
import 'package:home_utility_pro/controllers/registrationController.dart';
import 'package:home_utility_pro/location/userLocation.dart';
import 'package:home_utility_pro/screens/prosInfoScreen.dart';
import '../constants.dart';
import '../components/customButton.dart';
import '../components/customTextField.dart';
import '../components/dialogBox.dart';
import 'package:home_utility_pro/reusableTypes.dart';

class Signup extends StatelessWidget {
  static const id = '/register';
  final registrationController = RegistrationController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
// final TextStyle display1 = Theme.of(context).textTheme.headline4;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: size.height * 0.03),
              Container(
                  height: size.height * 0.15,
                  child: Center(child: Image.asset('images/icon.png'))),
              Text(
                'Sign up !',
                style: GoogleFonts.montserrat(
                    color: Color(0xffECECEC),
                    fontWeight: FontWeight.bold,
                    fontSize: 28),
              ),
              SizedBox(height: size.height * 0.01),
              Text(
                'Create a new account for Home Utility',
                style: GoogleFonts.lato(color: Color(0xffaaabac), fontSize: 15),
              ),
              SizedBox(height: size.height * 0.07),
              NewTextfield(
                textController: registrationController.nameController,
                isPhoneNumber: false,
                hintText: 'Enter your Name',
                lableText: 'ENTER NAME',
                icon: EvaIcons.personOutline,
                obsecure: false,
              ),
              SizedBox(height: size.height * 0.03),
              NewTextfield(
                textController: registrationController.emailController,
                isPhoneNumber: false,
                hintText: 'Enter your email adress',
                lableText: 'ENTER EMAIL',
                icon: EvaIcons.emailOutline,
                obsecure: false,
              ),
              SizedBox(height: size.height * 0.03),
              NewTextfield(
                textController: registrationController.phoneController,
                isPhoneNumber: true,
                hintText: 'Enter your Phone no.',
                lableText: 'ENTER PHONE NO.',
                icon: EvaIcons.phoneCallOutline,
                obsecure: false,
              ),
              SizedBox(height: size.height * 0.03),
              NewPasswordTextField(
                textController: registrationController.passwordController,
              ),
              SizedBox(height: size.height * 0.07),
              CustomButton(
                text: 'Sign Up',
                ontap: () async {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => DialogBox(
                      title: 'Registering',
                    ),
                  );

                  _checkValidation(context);
                },
              ),
              SizedBox(height: size.height * 0.03),
              SizedBox(height: size.height * 0.01),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Already have an account ?  ',
                      style: GoogleFonts.roboto(
                          color: Color(0xffaaabac), fontSize: 16),
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                            child: Text('Sign in',
                                style: GoogleFonts.roboto(
                                  color: Color(0xff024BBC),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                )))),
                  ]),
            ],
          )),
        ),
      ),
    );
  }

  Future<void> _checkValidation(BuildContext context) async {
    if (registrationController.nameController.text.trim().isEmpty) {
      Get.back();
      getSnackBar(
        title: 'ERROR!',
        message: 'Your name is mandatory.',
      );
      return;
    } else if (registrationController.phoneController.text.isEmpty) {
      Get.back();
      getSnackBar(
        title: 'ERROR!',
        message: 'Your phone number is mandatory.',
      );
      return;
    } else if (registrationController.phoneController.text.trim().length !=
        10) {
      Get.back();
      getSnackBar(
        title: 'ERROR!',
        message: 'Inavlid phone number.',
      );
      return;
    } else if (!registrationController.emailController.text.isEmail) {
      Get.back();
      getSnackBar(
        title: 'ERROR!',
        message: 'Please enter a valid email address',
      );
      return;
    } else if (registrationController.passwordController.text.length < 8) {
      Get.back();
      getSnackBar(
        title: 'ERROR!',
        message: 'Password must be atleast 8 characters long.',
      );
      return;
      // } else if (phoneController.text.trim().length == 10) {
    } else if (!registrationController.passwordController.text
        .contains(RegExp(r"[a-z]"))) {
      Get.back();
      getSnackBar(
        title: 'ERROR!',
        message: 'Password must contain at least one small alphabet.',
      );
      return;
    } else if (!registrationController.passwordController.text
        .contains(RegExp(r"[A-Z]"))) {
      Get.back();
      getSnackBar(
        title: 'ERROR!',
        message: 'Password must contain at least one capital alphabet.',
      );
      return;
    } else if (!registrationController.passwordController.text
        .contains(RegExp(r"[0-9]"))) {
      Get.back();
      getSnackBar(
        title: 'ERROR!',
        message: 'Password must contain at least one numerals.',
      );
      return;
    } else if (!registrationController.passwordController.text
        .contains(RegExp(r"[!@#$%^&*(),.?:{}|<>]"))) {
      Get.back();
      getSnackBar(
        title: 'ERROR!',
        message: 'Password must contain at least one special character.',
      );
      return;
    } else {
      try {
        int phoneNo;
        try {
          phoneNo =
              int.parse(registrationController.phoneController.text.trim());
        } catch (e) {
          Get.back();
          getSnackBar(
            title: 'ERROR!',
            message: 'Please enter a valid phone number',
          );
          return;
        }

        UserLocation userLocation = UserLocation();
        Position location = await userLocation.getLocation();

        String code = await userAuthentication.signUp(
          name: registrationController.nameController.text.trim(),
          phoneNo: phoneNo,
          email: registrationController.emailController.text.trim(),
          password: registrationController.passwordController.text,
          latitude: location.latitude,
          longitude: location.longitude,
        );

        if (code == 'success') {
          await userAuthentication.sendEmailVerification();

          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return Dialog(
                backgroundColor: kWhiteColour,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: BorderSide(
                    color: kBlackColour,
                    width: 4.0,
                    style: BorderStyle.solid,
                  ),
                ),
                child: Container(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'We have sent a verification link to your email address.\nYou have to verify your email before moving forward.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                          fontSize: 20.0,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      CustomButton(
                        color: kBlackColour,
                        shadowcolor: Colors.white,
                        borderColour: kBlackColour,
                        ontap: () async {
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) => Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircularProgressIndicator(
                                        color: kBlackColour,
                                        backgroundColor: Colors.white,
                                      ),
                                    ],
                                  ));
                          await userAuthentication.reload();
                          // CircularProgressIndicator();
                          if (await userAuthentication.isEmailVerified()) {
                            String token =
                                await FirebaseMessaging.instance.getToken();
                            await database.saveToken(token);
                            Get.back();
                            Get.back();
                            Get.offAllNamed(ProsInfoScreen.id);
                            getSnackBar(
                              title: 'CONGRATULATIONS!',
                              message: 'Your email has been verified',
                            );
                          } else {
                            await userAuthentication.signOut();
                            Get.back();
                            Get.back();
                            getSnackBar(
                              title: 'ERROR!',
                              message: 'Your email has not been verified',
                            );
                          }
                        },
                        text: 'Confirm',
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      CustomButton(
                        color: kBlackColour,
                        shadowcolor: Colors.white,
                        borderColour: kBlackColour,
                        ontap: () async {
                          String code =
                              await userAuthentication.sendEmailVerification();

                          if (code == 'too-many-requests') {
                            getSnackBar(
                                title: 'ALERT!',
                                message:
                                    'Too many requests. We have blocked all requests from this device due to unusual activity. Try again later.');
                          }
                        },
                        text: 'Resend',
                      ),
                    ],
                  ),
                ),
              );
            },
          );
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
        // }
      } catch (e) {
        Get.back();
        print(e);
        getSnackBar(
          title: 'ERROR!',
          message: '$e',
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
