import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_utility_pro/constants.dart';

class ProfileButton extends StatefulWidget {
  final Function onPressed;
  final double buttonHeight;
  final double buttonWidth;
  final Color primaryColour;
  final Color shadowColour;
  final double borderSideWidth;
  final Color borderSideColour;
  final double borderRadius;
  final String buttonText;
  final Color textColour;

  const ProfileButton(
      {this.onPressed,
      this.buttonHeight,
      this.buttonWidth,
      this.primaryColour,
      this.shadowColour,
      this.borderSideWidth,
      this.borderSideColour,
      this.borderRadius,
      this.buttonText,
      this.textColour});

  @override
  _ProfileButtonState createState() => _ProfileButtonState();
}

class _ProfileButtonState extends State<ProfileButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: widget.buttonHeight,
        width: widget.buttonWidth,
        child: ElevatedButton(
          onPressed: widget.onPressed,
          style: ElevatedButton.styleFrom(
            primary: widget.primaryColour,
            // Color(0xFF5061AC),
            shadowColor: widget.shadowColour,
            // Color(0xFFFFFFFF),
            side: BorderSide(
              width: widget.borderSideWidth,
              // width: 0.5,
              color: widget.borderSideColour,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(widget.borderRadius),
              ),
            ),
          ),
          child: Center(
            child: Text(
              widget.buttonText,
              style: TextStyle(
                color: widget.textColour,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final Function ontap;
  final String text;
  final Color color;
  final double height;
  final double width;
  final Color shadowcolor;
  final Color borderColour;
  const CustomButton({
    this.ontap,
    this.text,
    this.color,
    this.height,
    this.width,
    this.shadowcolor,
    this.borderColour,
  });
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
        onTap: ontap,
        child: Container(
          height: height == null ? size.height * 0.06 : height,
          width: width == null ? size.width * 0.45 : width,
          decoration: BoxDecoration(
              color: color == null ? Color(0xff024BBC) : color,
              borderRadius: BorderRadius.all(Radius.circular(30)),
              border: Border.all(
                  color:
                      borderColour == null ? Color(0xff024BBC) : borderColour),
              boxShadow: [
                BoxShadow(
                  color: shadowcolor == null
                      ? Color(0xff085dcf).withOpacity(0.3)
                      : shadowcolor.withOpacity(0.3),
                  spreadRadius: 5,
                  blurRadius: 20,
                  offset: Offset(3, 7), // changes position of shadow
                ),
              ]),
          child: Center(
            child: Text(text,
                style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontSize: 14,
                )),
          ),
        ));
  }
}
