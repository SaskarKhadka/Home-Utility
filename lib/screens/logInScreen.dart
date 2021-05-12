// import 'dart:io';

import 'package:flutter/material.dart';
// import 'package:home_utility/components/dialogBox.dart';
import 'package:home_utility/screens/services.dart';
import '../constants.dart';
import '../components/roundedButton.dart';
import 'registrationScreen.dart';

class LogInScreen extends StatelessWidget {
  static const id = '/login';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 15.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 100.0,
              ),
              Text(
                '*Home Utility Icon*',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 40.0,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'Login as a User',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 25.0,
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {},
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your email',
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {},
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your password',
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              RoundedButton(
                color: Colors.lightBlueAccent,
                text: 'Log In',
                onPressed: () async {
                  // showDialog(
                  //   context: context,
                  //   barrierDismissible: false,
                  //   builder: (context) => DialogBox(),
                  // );

                  Navigator.pushNamed(context, MainScreen.id);
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Text(
                  'Do not have an account?',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
              RoundedButton(
                  color: Colors.lightBlueAccent,
                  text: 'Register Here',
                  onPressed: () {
                    Navigator.pushNamed(context, RegistrationScreen.id);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
