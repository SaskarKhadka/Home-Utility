import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
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
          isRegistrationScreen: false,
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomTextField(
                              textController: emailController,
                              isPhoneNumber: true,
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
                              height: size.height * 0.08,
                            ),
                            CustomButton(
                              color: Colors.orange[900],
                              text: 'SIGN IN',
                              onTap: () async {
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context) => DialogBox(),
                                );
                                try {
                                  await userAuthentication.signIn(
                                      email: emailController.text.trim(),
                                      password: passwordController.text);
                                  Get.back();
                                  Get.toNamed(MainScreen.id);
                                } catch (e) {
                                  print(e);
                                }
                              },
                            ),
                            SizedBox(
                              height: size.height * 0.1,
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     Text(
                            //       'Don\'t have an account?',
                            //       textAlign: TextAlign.center,
                            //       style: GoogleFonts.montserrat(
                            //         fontSize: 16.0,
                            //         color: Colors.black.withOpacity(0.5),
                            //       ),
                            //     ),
                            //     TextButton(
                            //         onPressed: () =>
                            //             Get.toNamed(RegistrationScreen.id),
                            //         child: Text(
                            //           'Register Here',
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
}
