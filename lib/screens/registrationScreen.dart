import 'package:flutter/material.dart';
import '../constants.dart';
import '../components/roundedButton.dart';

class RegistrationScreen extends StatelessWidget {
  static const id = '/register';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 15.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Home Utility',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 50.0,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            // Text('Email'),
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
              text: 'Register',
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
