import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function onPressed;

  RoundedButton({@required this.text, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: GestureDetector(
          onTap: onPressed,
          child: Container(
            height: size.height * 0.051,
            width: size.width * 0.45,
            decoration: BoxDecoration(
              color: Color(0xff024BBC),
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Color(0xff024BBC).withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 15,
                ),
              ],
            ),
            child: Center(
              child: Text(
                text,
                style: GoogleFonts.roboto(color: Colors.white),
              ),
            ),
          ),
        ));
  }
}
