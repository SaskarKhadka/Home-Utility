import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_utility/components/customTextField.dart';
import 'package:home_utility/components/dialogBox.dart';
import 'package:home_utility/main.dart';
import 'package:home_utility/screens/confirmEmail.dart';
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
                    'Enter your email for getting a password reset link.\n\nIf you haven\'t forgotten your password, tap the Sign In button.',
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

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return ConfirmEmail();
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Text(
                    "OR",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),

                  Container(
                    width: 150,
                    height: 60,
                    child: CustomButton(
                      text: 'Sign In',
                      onTap: () {
                        Get.offAllNamed(LogInScreen.id);
                      },
                    ),
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
