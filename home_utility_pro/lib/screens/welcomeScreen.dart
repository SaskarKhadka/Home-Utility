import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_utility_pro/main.dart';
import 'package:home_utility_pro/screens/mainScreen.dart';
import 'package:home_utility_pro/screens/prosInfoScreen.dart';
import 'logInScreen.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = '/';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 4),
        () => Get.offAllNamed(
            userAuthentication.currentUser == null ? Login.id : MainScreen.id));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              // height: 50.0,
              height: size.height * 0.3,
            ),
            Container(
                width: size.width * 0.45,
                color: Colors.black,
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 100.0,
                      child: Image.asset(
                        'images/icon.png',
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Home Utility',
                      style: GoogleFonts.shortStack(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                )),
            SizedBox(
              height: size.height * 0.3,
            ),
          ],
        ),
      ),
    );
  }
}
