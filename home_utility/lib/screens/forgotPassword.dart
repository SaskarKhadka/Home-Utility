import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_utility/components/customTextField.dart';
import 'package:home_utility/components/dialogBox.dart';
import 'package:home_utility/main.dart';
import 'package:home_utility/screens/logInScreen.dart';
import '../services/userAuthentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:home_utility/components/customButton.dart';

import 'registrationScreen.dart';

class ForgotPassword extends StatefulWidget {
  static String id = 'forgotPassword';

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 67,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back),
        ),
        title: Text(
          'Reset Password',
          style: GoogleFonts.montserrat(
            color: Colors.white,
            fontSize: 35,
            fontWeight: FontWeight.w400,
            letterSpacing: 1.5,
          ),
        ),
      ),
      // backgroundColor: Color(0xFFEBEBEB),
      body: SingleChildScrollView(
        child: Form(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: size.height * 0.1,
                  ),
                  Text(
                    'Enter your email for getting a password reset link.\n\nIf you don\'t want to change your password, then you can go back.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.09,
                  ),
                  CustomTextField(
                    textController: emailController,
                    isPhoneNumber: false,
                    icon: EvaIcons.emailOutline,
                    labelText: 'Email',
                    hintText: 'Enter your email address',
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  // ignore: deprecated_member_use

                  Container(
                    width: 200,
                    height: 60,
                    child: CustomButton(
                      text: 'Send Email',
                      onTap: () async {
                        if (emailController.text.isEmpty) {
                          getSnackBar(
                            title: 'ERROR!',
                            message: 'Please enter your email address',
                          );
                          return;
                        } else if (!emailController.text.isEmail) {
                          getSnackBar(
                            title: 'ERROR!',
                            message: 'Please enter a valid email address',
                          );
                          return;
                        }
                        await userAuthentication.passwordReset(
                          email: emailController.text.trim(),
                        );

                        showDialog(
                            context: (context),
                            builder: (context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                    side: BorderSide.none,
                                    borderRadius: BorderRadius.circular(20.0)),
                                insetAnimationCurve: Curves.bounceIn,
                                backgroundColor: Color(0xFF110E1F),
                                elevation: 0.0,
                                insetPadding: EdgeInsets.symmetric(
                                  vertical: 25.0,
                                  horizontal: 25.0,
                                ),
                                child: Container(
                                  width: size.width,
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
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 18.0,
                                          left: 8.0,
                                          right: 8.0,
                                        ),
                                        child: Text(
                                          'Confirm Email',
                                          style: GoogleFonts.shortStack(
                                            color: Colors.white,
                                            fontSize: 26,
                                            letterSpacing: 2.0,
                                            wordSpacing: 2.0,
                                            fontStyle: FontStyle.normal,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        child: Divider(
                                          color: Colors.tealAccent,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 18.0,
                                          left: 20.0,
                                          right: 18.0,
                                          bottom: 18.0,
                                        ),
                                        child: Text(
                                          'An email has just been sent to you, Click the link provided to complete registration.',
                                          style: GoogleFonts.roboto(
                                            color: Colors.white,
                                            fontSize: 16,
                                            letterSpacing: 2.0,
                                            wordSpacing: 2.0,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
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
                                            borderRadius:
                                                BorderRadius.circular(10.0),
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
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: size.height * 0.02,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
