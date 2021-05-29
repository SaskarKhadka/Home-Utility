import 'package:flutter/material.dart';

class ProsProfile extends StatefulWidget {
  @override
  _ProsProfileState createState() => _ProsProfileState();
}

class _ProsProfileState extends State<ProsProfile> {
  @override

  //TODO: Implement user profile
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Text('This is User Profile'),
        ),
      ),
    );
  }
}
