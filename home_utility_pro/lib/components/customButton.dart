import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_utility_pro/constants.dart';

class CustomButton extends StatelessWidget {
  final Function onTap;
  final String text;
  CustomButton({
    this.onTap,
    this.text,
  });
  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
          // width: size.width * 0.4,
          padding: EdgeInsets.symmetric(
            horizontal: 15.0,
            vertical: 17.0,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40.0),
            color: kBlackColour,
            // gradient: LinearGradient(
            //   colors: [
            //     Colors.orange[500],
            //     Colors.orange[600],
            //     Colors.orange[700],
            //     Colors.orange[800],
            //   ],
            // ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.35),
                offset: Offset(0, 7),
                blurRadius: 10,
              ),
            ],
          ),
          child: Center(
            child: Text(
              text,
              style: GoogleFonts.montserrat(
                color: kWhiteColour,
                fontSize: 20.0,
                letterSpacing: 3,
              ),
            ),
          )),
    );
  }
}
