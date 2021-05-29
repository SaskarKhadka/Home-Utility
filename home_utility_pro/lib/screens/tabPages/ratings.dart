import 'package:flutter/material.dart';

class Ratings extends StatefulWidget {
  @override
  _RatingsState createState() => _RatingsState();
}

class _RatingsState extends State<Ratings> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Text('Pros ratings'),
        ),
      ),
    );
  }
}
