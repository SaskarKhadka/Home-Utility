import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_utility_pro/constants.dart';

class CustomPasswordTextField extends StatefulWidget {
  final TextEditingController textController;
  final IconData icon;
  final String hintText;
  final String labelText;
  CustomPasswordTextField({
    this.textController,
    this.icon,
    this.hintText,
    this.labelText,
  });

  @override
  _CustomPasswordTextFieldState createState() =>
      _CustomPasswordTextFieldState();
}

class _CustomPasswordTextFieldState extends State<CustomPasswordTextField> {
  IconData eyeIcon = Icons.visibility_off;
  Color _focusColour = Color(0xff737373);
  bool isObscureText = true;
  // Color _focusColour;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.09,
      // width: size.width * 0.9,r
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            // spreadRadius: 5,
            blurRadius: 10,
            offset: Offset(0, 7),
          ),
        ],
      ),
      child: TextField(
        onTap: () {
          setState(() {
            // _focusColour = Colors.deepOrangeAccent.shade400;
            _focusColour = kBlackColour;
          });
        },
        controller: widget.textController,
        keyboardType: TextInputType.emailAddress,
        obscureText: isObscureText,
        obscuringCharacter: '*',
        style: GoogleFonts.cabin(
          fontSize: 15,
          // color: Color(0xFFD4145A),
          color: _focusColour,
        ),
        decoration: InputDecoration(
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                isObscureText = !isObscureText;
                if (isObscureText)
                  eyeIcon = Icons.visibility_off;
                else
                  eyeIcon = Icons.visibility;
              });
            },
            child: Icon(
              eyeIcon,
              color: _focusColour,
            ),
          ),

          labelText: widget.labelText,
          labelStyle: GoogleFonts.cabin(
            fontSize: 17.5,
            // color: Color(0xFFD4145A),
            color: _focusColour,
          ),
          hintText: widget.hintText,
          hintStyle: GoogleFonts.cabin(
            fontSize: 15,
            // color: Color(0xFFD4145A),
            color: _focusColour,
          ),
          // helperText: 'saskar@gmail.com',
          // errorText: 'error',
          // floatingLabelBehavior: FloatingLabelBehavior.auto,
          contentPadding: EdgeInsets.all(20.0),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 25.0),
            child: Icon(
              widget.icon,
              // color: Color(0xFFD4145A),
              color: _focusColour,
            ),
          ),

          fillColor: kWhiteColour,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              // color: Color(0xFFD4145A),
              color: _focusColour,
              // style: BorderStyle.none,
              width: 1.0,
            ),
            borderRadius: BorderRadius.all(Radius.circular(40.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              // color: Color(0xFFD4145A),
              color: _focusColour,
              width: 2.0,
            ),
            borderRadius: BorderRadius.all(Radius.circular(40.0)),
          ),
        ),
      ),
    );
  }
}

class CustomPasswordTextField2 extends StatefulWidget {
  final TextEditingController textcontroller;

  final IconData icon;
  final String hintText;
  final String labelText;
  final Color focusColour;
  final Color focusColour2;
  final Color textColour;
  final Color iconColour;
  final Color cursorColour;
  final double borderRadius;
  final bool isFilled;

  CustomPasswordTextField2({
    this.textcontroller,
    this.icon,
    this.hintText,
    this.labelText,
    this.focusColour,
    this.focusColour2,
    this.textColour,
    this.iconColour,
    this.cursorColour,
    this.borderRadius,
    this.isFilled,
  });
  @override
  _CustomPasswordTextField2State createState() =>
      _CustomPasswordTextField2State();
}

class _CustomPasswordTextField2State extends State<CustomPasswordTextField2> {
  IconData eyeIcon = Icons.visibility_off;

  bool isObscureText = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.09,
      // width: size.width * 0.9,r
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40.0),
      ),
      child: TextField(
        onTap: () {
          setState(() {
            widget.focusColour2;
          });
        },
        controller: widget.textcontroller,
        keyboardType: TextInputType.emailAddress,
        obscureText: isObscureText,
        obscuringCharacter: '*',
        style: GoogleFonts.cabin(
          fontSize: 15,
          color: widget.textColour,
        ),
        cursorColor: widget.cursorColour,
        decoration: InputDecoration(
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                isObscureText = !isObscureText;
                if (isObscureText)
                  eyeIcon = Icons.visibility_off;
                else
                  eyeIcon = Icons.visibility;
              });
            },
            child: Icon(
              eyeIcon,
              color: widget.focusColour,
            ),
          ),
          fillColor: kWhiteColour,
          filled: widget.isFilled,
          labelText: widget.labelText,
          labelStyle: GoogleFonts.cabin(
            fontSize: 17.5,
            color: widget.textColour,
          ),
          hintText: widget.hintText,
          hintStyle: GoogleFonts.cabin(
            fontSize: 15,
            color: widget.textColour,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 25.0),
            child: Icon(
              widget.icon,
              color: widget.iconColour,
            ),
          ),
          enabledBorder: new OutlineInputBorder(
            borderSide: new BorderSide(
              color: widget.focusColour,
            ),
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: new BorderSide(
              color: widget.focusColour2,
            ),
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
        ),
      ),
    );
  }
}
