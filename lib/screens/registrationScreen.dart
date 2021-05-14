import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_utility/screens/logInScreen.dart';
import '../constants.dart';
import '../components/roundedButton.dart';

class RegistrationScreen extends StatelessWidget {
  static const id = '/register';
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
                'Register as a User',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 25.0,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {},
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your name',
                ),
              ),
              SizedBox(
                height: 20.0,
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
              // Text('Password'),
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
                text: 'Create Account',
                onPressed: () {},
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Text(
                  'Already have an account?',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
              RoundedButton(
                  color: Colors.lightBlueAccent,
                  text: 'Login Here',
                  onPressed: () {
                    Get.toNamed(LogInScreen.id);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
