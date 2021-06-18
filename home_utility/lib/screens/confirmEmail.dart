import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_utility/constants.dart';

import 'forgotPassword.dart';

class ConfirmEmail extends StatelessWidget {
  static String id = 'confirmEmail';
  const ConfirmEmail({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 67,
        elevation: 2.0,
        centerTitle: true,
        shadowColor: Colors.white,
        leading: IconButton(
          onPressed: () => Get.toNamed(ForgotPassword.id),
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          'Go back',
          style: GoogleFonts.montserrat(
            color: Colors.white,
            fontSize: 35,
            fontWeight: FontWeight.w400,
            letterSpacing: 1.5,
          ),
        ),
      ),

      backgroundColor: kBlackColour,
      // body: Container(
      body: Center(
          child: Text(
        'An email has just been sent to you, Click the link provided to complete registration.',
        style: GoogleFonts.roboto(
          color: Colors.white,
          fontSize: 16,
          letterSpacing: 2.0,
          wordSpacing: 2.0,
          fontStyle: FontStyle.italic,
        ),
      )),
      // ),
    );
  }
}
