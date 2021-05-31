import 'package:flutter/material.dart';

class BackgroundGradient extends StatelessWidget {
  final Widget child;
  final bool isRegistrationScreen;
  BackgroundGradient({this.child, this.isRegistrationScreen});
  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      // height: size.height,
      color: Color(0xff131313),
      // decoration: BoxDecoration(
      //   color: Colors.white,
      //   gradient: LinearGradient(
      //     colors: [
      //       Colors.orange[800],
      //       Colors.orange[600],
      //       Colors.orange[500],
      //       Colors.orange[400],
      //     ],
      //   ),
      // ),
      child: child,
    );
  }
}
