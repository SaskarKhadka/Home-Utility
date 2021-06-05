import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_utility_pro/constants.dart';
import '../components/customButton.dart';
import 'logInScreen.dart';
// import 'registrationScreen.dart';

class WelcomeScreen extends StatelessWidget {
  static const String id = '/';
  @override
  Widget build(BuildContext context) {
    //this screen is going to be kinda like a template screen

    return Scaffold(
      // backgroundColor: kBlackColour,
      backgroundColor: kWhiteColour,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 50.0,
          ),
          Text(
            '*Home Utility Icon*',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.w800,
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.black,
              child: Image.asset(
                'images/splashscreen.gif',
                fit: BoxFit.fill,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: CustomButton(
              text: 'Get Started'.toUpperCase(),
              // color: Colors.black,
              onTap: () {
                Get.offAllNamed(LogInScreen.id);
              },
            ),
          ),
        ],
      ),
    );
  }
}
