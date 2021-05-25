import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_utility/components/backgroundGradient.dart';
import 'logInScreen.dart';
import '../components/customButton.dart';
import '../components/customTextField.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/dialogBox.dart';
import 'mainScreen.dart';
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
      body: SingleChildScrollView(
        child: BackgroundGradient(
          isRegistrationScreen: true,
          child: Column(
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
                    InkWell(
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
                    InkWell(
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
                              color: Colors.orange[900],
                              text: 'SIGN UP',
                              onTap: () async {
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context) => DialogBox(),
                                );

                                _checkValidation();
                              },
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     Text(
                            //       'Already have an account?',
                            //       textAlign: TextAlign.center,
                            //       style: GoogleFonts.montserrat(
                            //         fontSize: 16.0,
                            //         color: Colors.black.withOpacity(0.5),
                            //       ),
                            //     ),
                            //     TextButton(
                            //         onPressed: () => Get.back(),
                            //         child: Text(
                            //           'Login Here',
                            //           style: GoogleFonts.montserrat(
                            //             fontSize: 16.0,
                            //             color: Colors.orange[800],
                            //           ),
                            //         ))
                            //   ],
                            // ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
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
    } else if (phoneController.text.trim().length == 10) {
      try {
        double phoneNo = double.parse(phoneController.text);

        try {
          await userAuthentication.signUp(
              name: nameController.text.trim(),
              phoneNo: phoneNo,
              email: emailController.text.trim(),
              password: passwordController.text);
          Get.back();
          Get.toNamed(MainScreen.id);
          getSnackBar(
            title: 'CONGRATULATIONS!',
            message: 'Your account has been created',
          );
          // Get.snackbar(title, message)
        } catch (e) {
          Get.back();
          getSnackBar(
            title: 'ERROR!',
            message: e.toString(),
          );
        }
      } catch (e) {
        Get.back();
        getSnackBar(
          title: 'ERROR!',
          message: 'Please enter a valid phone number',
        );
      }
    } else if (!emailController.text.trim().contains('@')) {
      Get.back();
      getSnackBar(
        title: 'ERROR!',
        message: 'Inavlid email address.',
      );

      return;
    } else if (passwordController.text.length < 8) {
      Get.back();
      getSnackBar(
        title: 'ERROR!',
        message: 'Password must be atleast 8 characters long.',
      );
      return;
    }
  }
}

getSnackBar({String title, String message}) {
  Get.snackbar(
    title,
    message,
    snackPosition: SnackPosition.BOTTOM,
  );
}
