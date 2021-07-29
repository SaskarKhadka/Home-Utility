import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  final Function onTap;
  final Color color;
  final String text;
  CustomButton({
    this.onTap,
    this.color,
    this.text,
  });
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
          width: size.width * 0.4,
          padding: EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 17.0,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40.0),
            color: Color(0xff131313),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.45),
                offset: Offset(2, 7),
                blurRadius: 10,
              ),
            ],
          ),
          child: Center(
            child: Text(
              text,
              style: GoogleFonts.montserrat(
                color: Colors.white,
                fontSize: 20.0,
                letterSpacing: 3,
              ),
            ),
          )),
    );
  }
}

class ProfileButton extends StatelessWidget {
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

  ProfileButton(
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
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: buttonHeight,
        width: buttonWidth,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            primary: primaryColour,
            // Color(0xFF5061AC),
            shadowColor: shadowColour,
            // Color(0xFFFFFFFF),
            side: BorderSide(
              width: borderSideWidth,
              // width: 0.5,
              color: borderSideColour,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(borderRadius),
              ),
            ),
          ),
          child: Center(
            child: Text(
              buttonText,
              style: TextStyle(
                color: textColour,
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class LoginButton extends StatelessWidget {
  final Function ontap;
  final String text;
  const LoginButton({ this.ontap, this.text});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  GestureDetector(
        onTap: ontap,
          child: Container(
          height:size.height* 0.06,
          
          width:size.width * 0.45,
                        decoration: BoxDecoration(
                          color: Color(0xff024BBC),
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                       boxShadow: [
                                    BoxShadow(
                                      color: Color(0xff085dcf).withOpacity(0.3),
                                      spreadRadius: 5,
                                      blurRadius: 20,
                                      offset: Offset(3, 7), // changes position of shadow
                                    ),]
                        ),
                       
                          child: Center(child: Text(text,style: GoogleFonts.roboto(color: Colors.white,fontSize: 14,)),
              ),)
    );
  }
}