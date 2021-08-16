import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_utility_pro/components/customPasswordTextField.dart';
import 'package:home_utility_pro/controllers/logInController.dart';
import 'package:home_utility_pro/reusableTypes.dart';
import 'package:home_utility_pro/screens/prosInfoScreen.dart';
import '../constants.dart';
import 'forgotPasswordScreen.dart';
import '../components/customButton.dart';
import 'mainScreen.dart';
import 'registrationScreen.dart';
import '../components/customTextField.dart';
import '../components/dialogBox.dart';

class Login extends StatelessWidget {
  static const id = '/login';
  final logInController = LogInController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
// final TextStyle display1 = Theme.of(context).textTheme.headline4;
    return Scaffold(
      backgroundColor: Colors.black87,
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                  height: size.height * 0.3,
                  child: Center(child: Image.asset('images/icon.png'))),
              Text(
                'Welcome back !',
                style: GoogleFonts.montserrat(
                    color: Color(0xffECECEC),
                    fontWeight: FontWeight.bold,
                    fontSize: 28),
              ),
              SizedBox(height: size.height * 0.01),
              Text(
                'Log in to your existing account of Home Utility',
                style: GoogleFonts.lato(color: Color(0xffaaabac), fontSize: 15),
              ),
              SizedBox(height: size.height * 0.07),
              NewTextfield(
                textController: logInController.emailController,
                isPhoneNumber: false,
                hintText: 'Enter your email adress',
                lableText: 'ENTER EMAIL',
                icon: EvaIcons.personOutline,
                obsecure: false,
              ),
              SizedBox(height: size.height * 0.03),
              NewPasswordTextField(
                textController: logInController.passwordController,
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                    width: size.width,
                    child: Align(
                        alignment: Alignment.bottomRight,
                        child: GestureDetector(
                            onTap: () {
                              Get.toNamed(ForgetPassword.id);
                            },
                            child: Container(
                                child: Text(
                              'Forgot password?  ',
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 15),
                            ))))),
              ),
              SizedBox(height: size.height * 0.07),
              CustomButton(
                text: 'SIGN IN',
                ontap: () async {
                  // bool proceed = false;
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => DialogBox(
                      title: 'Authenticating',
                    ),
                  );

                  if (logInController.emailController.text.isEmpty) {
                    Get.back();
                    getSnackBar(
                      title: 'ERROR!',
                      message: 'Please enter your email address',
                    );
                    return;
                  } else {
                    if (!logInController.emailController.text.isEmail) {
                      Get.back();
                      // proceed = false;
                      getSnackBar(
                          title: 'ERROR!',
                          message: 'Please enter a valid email address');
                      return;
                    }
                  }
                  if (logInController.passwordController.text.isEmpty) {
                    Get.back();

                    getSnackBar(
                      title: 'ERROR!',
                      message: 'Please enter your password',
                    );
                    return;
                  }

                  String code = await userAuthentication.signIn(
                      email: logInController.emailController.text.trim(),
                      password: logInController.passwordController.text);

                  if (code == 'success') {
                    if (!await userAuthentication.isEmailVerified()) {
                      String email =
                          logInController.emailController.text.trim();
                      await userAuthentication.sendEmailVerification(
                          email: email);

                      // userAuthentication.signOut();
                      // if (code == 'success') {
                      Get.back();
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
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  CircularProgressIndicator(
                                                    color: kBlackColour,
                                                    backgroundColor:
                                                        Colors.white,
                                                  ),
                                                ],
                                              ));
                                      await userAuthentication.reload();
                                      // CircularProgressIndicator();
                                      bool isVerified = await userAuthentication
                                          .isEmailVerified();
                                      if (isVerified) {
                                        prosProfessionValue =
                                            await database.prosProfession;
                                        await resolveToken();
                                        Get.back();
                                        Get.back();
                                        prosProfessionValue == null
                                            ? Get.offAllNamed(ProsInfoScreen.id)
                                            : Get.offAllNamed(MainScreen.id);
                                        getSnackBar(
                                          title: 'CONGRATULATIONS!',
                                          message:
                                              'Your email has been verified',
                                        );
                                      } else {
                                        await userAuthentication.signOut();
                                        Get.back();
                                        Get.back();

                                        getSnackBar(
                                          title: 'ERROR!',
                                          message:
                                              'Your email has not been verified',
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
                                      String code = await userAuthentication
                                          .sendEmailVerification(email: email);

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
                    } else {
                      prosProfessionValue = await database.prosProfession;
                      await resolveToken();
                      Get.back();

                      prosProfessionValue == null
                          ? Get.offAllNamed(ProsInfoScreen.id)
                          : Get.offAllNamed(MainScreen.id);
                    }
                  } else if (code == 'wrong-password') {
                    Get.back();
                    userAuthentication.signOut();
                    getSnackBar(
                        title: 'ERROR!',
                        message:
                            'Wrong Password! Please enter your valid password');
                    return;
                  } else {
                    Get.back();
                    userAuthentication.signOut();
                    getSnackBar(
                      title: 'ERROR!',
                      message:
                          'Record not found! Please create a new account if you donot have one.',
                    );
                    return;
                  }
                },
              ),
              SizedBox(height: size.height * 0.03),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Dont have an account ?  ',
                      style: GoogleFonts.roboto(
                          color: Color(0xffaaabac), fontSize: 16),
                    ),
                    GestureDetector(
                        onTap: () {
                          Get.toNamed(Signup.id);
                        },
                        child: Container(
                            child: Text('Sign Up',
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

  Future<void> resolveToken() async {
    try {
      String token = await database.getMyToken();
      String deviceToken = await FirebaseMessaging.instance.getToken();

      if (token == null || token == '' || token != deviceToken) {
        // String token = await FirebaseMessaging.instance.getToken();
        database.saveToken(deviceToken);
        print(deviceToken);
      }
    } catch (e) {
      print(e);
    }
  }
}
