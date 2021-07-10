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
