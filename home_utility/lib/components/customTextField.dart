import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController textController;
  final bool isPhoneNumber;
  final IconData icon;
  final String hintText;
  final String labelText;
  CustomTextField({
    this.textController,
    this.isPhoneNumber,
    this.icon,
    this.hintText,
    this.labelText,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  Color _focusColour = Color(0xff737373);
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
            color: kBlackColour.withOpacity(0.2),
            // spreadRadius: 5,
            blurRadius: 10,
            offset: Offset(2, 7),
          ),
        ],
      ),
      child: TextField(
        onTap: () {
          setState(() {
            // _focusColour = Colors.deepOrangeAccent.shade400;
            _focusColour = Color(0xff131313);
          });
        },
        controller: widget.textController,
        keyboardType: widget.isPhoneNumber
            ? TextInputType.number
            : TextInputType.emailAddress,
        // onChanged: widget.onChanged,
        style: GoogleFonts.cabin(
          fontSize: 15,
          // color: Color(0xFFD4145A),
          color: _focusColour,
        ),
        decoration: InputDecoration(
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
            padding: EdgeInsets.only(left: 20.0, right: 25.0),
            child: Icon(
              widget.icon,
              // color: Color(0xFFD4145A),
              color: _focusColour,
            ),
          ),

          fillColor: Colors.white,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              // color: Color(0xFFD4145A),
              color: _focusColour,
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
