import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:home_utility/main.dart';
import 'package:home_utility/screens/forgotPassword.dart';
import '../constants.dart';
import '../services/userAuthentication.dart';
import '../components/customButton.dart';
import 'mainScreen.dart';
import 'registrationScreen.dart';
import '../components/customTextField.dart';
import '../components/dialogBox.dart';
import '../components/customPasswordTextField.dart';
import '../components/backgroundGradient.dart';

class LogInScreen extends StatefulWidget {
  static const id = '/login';

  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final userAuthentication = UserAuthentication();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
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
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 5.0,
                          horizontal: 21.0,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Text(
                          'SIGN IN',
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
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () => Get.toNamed(RegistrationScreen.id),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 4.6,
                          horizontal: 17.0,
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
                          'SIGN UP',
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
                          height: size.height * 0.04,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            CustomTextField(
                              textController: emailController,
                              isPhoneNumber: false,
                              icon: EvaIcons.emailOutline,
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
                              //0.078
                              height: size.height * 0.025,
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                onTap: () {
                                  Get.toNamed(ForgotPassword.id);
                                },
                                child: Text(
                                  'Forgot Password?',
                                  // textAlign: TextAlign.right,
                                  style: GoogleFonts.montserrat(
                                    color: kBlackColour.withOpacity(0.7),
                                    fontSize: 14,
                                    letterSpacing: 1.5,
                                    wordSpacing: 2.0,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              //0.078
                              height: size.height * 0.08,
                            ),
                            CustomButton(
                              color: Colors.orange[900],
                              text: 'SIGN IN',
                              onTap: () async {
                                // bool proceed = false;
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context) => DialogBox(
                                    title: 'Authenticating',
                                  ),
                                );

                                if (emailController.text.isEmpty) {
                                  Get.back();
                                  getSnackBar(
                                    title: 'ERROR!',
                                    message: 'Please enter your email address',
                                  );
                                  return;
                                } else {
                                  if (!emailController.text.isEmail) {
                                    Get.back();
                                    // proceed = false;
                                    getSnackBar(
                                        title: 'ERROR!',
                                        message:
                                            'Please enter a valid email address');
                                    return;
                                  }
                                }
                                if (passwordController.text.isEmpty) {
                                  Get.back();

                                  getSnackBar(
                                    title: 'ERROR!',
                                    message: 'Please enter your password',
                                  );
                                  return;
                                }

                                String code = await userAuthentication.signIn(
                                    email: emailController.text.trim(),
                                    password: passwordController.text);

                                if (code == 'success') {
                                  await database.totalUsersRequests();
                                  Get.back();
                                  Get.offAllNamed(MainScreen.id);
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
                                // } else {
                                // Get.back();
                                // }
                              },
                            ),
                            SizedBox(
                              height: size.height * 0.1,
                            ),
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
}
