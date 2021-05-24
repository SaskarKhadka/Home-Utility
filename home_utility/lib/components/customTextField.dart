import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  // final TextInputType keyboardType;
  final String hintText;
  final String lableText;
  final TextEditingController controller;
  final bool obsecure;
  final IconData icon;
  final Function onChanged;
  const CustomTextField({
    // this.keyboardType,
    this.hintText,
    this.icon,
    this.onChanged,
    this.controller,
    this.lableText,
    this.obsecure,
  });

  @override
  _NewTextfieldState createState() => _NewTextfieldState();
}

class _NewTextfieldState extends State<CustomTextField> {
  Color focuscolor = Color(0xffaaabac);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.068,
      width: size.width * 0.9,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Color(0xffE8E9ED),
          spreadRadius: 10,
          blurRadius: 20,
          offset: Offset(5, 7), // changes position of shadow
        ),
      ]),
      child: TextField(
        keyboardType: TextInputType
            .emailAddress, //TODO: try changing this for phone number
        onTap: () {
          setState(() {
            focuscolor = Color(0xff085dcf);
          });
        },
        obscureText: widget.obsecure,
        onChanged: widget.onChanged,
        controller: widget.controller,
        style: TextStyle(color: focuscolor),
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 25.0, right: 20),
            child: Icon(
              widget.icon,
              color: focuscolor,
            ),
          ),
          hintText: widget.hintText,
          hintStyle: TextStyle(color: Color(0xffaaabac), fontSize: 14),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.all(Radius.circular(30))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: focuscolor, width: 1.5),
              borderRadius: BorderRadius.all(Radius.circular(25))),
          filled: true,
          fillColor: Colors.white,
          labelText: widget.lableText,
          labelStyle: TextStyle(color: focuscolor, fontSize: 14),
        ),
      ),
    );
  }
}
