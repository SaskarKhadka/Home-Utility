import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../components/roundedButton.dart';
import 'logInScreen.dart';
// import 'registrationScreen.dart';

class WelcomeScreen extends StatelessWidget {
  static const String id = '/';
  @override
  Widget build(BuildContext context) {
    //this screen is going to be kinda like a template screen

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
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
              child:
                  Center(child: Text('A little bit of description probably')),
            )),
            RoundedButton(
              color: Colors.lightBlueAccent,
              text: 'Get Started',
              onPressed: () {
                Get.toNamed(LogInScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
