import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_utility_pro/constants.dart';

class AcceptedRequests extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBlackColour,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'My Jobs',
            style: GoogleFonts.montserrat(
              color: kWhiteColour,
              fontSize: 35.0,
              letterSpacing: 1.5,
            ),
          ),
          toolbarHeight: 67,
          shadowColor: kWhiteColour,
          elevation: 2,
        ),
        body: Center(
          child: Text(
            'You have not accepted any requests',
            style: TextStyle(
              color: kWhiteColour,
              fontSize: 20.0,
            ),
          ),
        ),
      ),
    );
  }
}
