import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewPasswordTextField extends StatefulWidget {
  final TextEditingController textController;

  NewPasswordTextField({this.textController});

  @override
  _NewPasswordTextFieldState createState() => _NewPasswordTextFieldState();
}

class _NewPasswordTextFieldState extends State<NewPasswordTextField> {
  Color focusColor = Color(0xffaaabac);
  bool isObscure = true;
  IconData eyeIcon = Icons.visibility_off;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.068,
      width: size.width * 0.9,
      child: TextField(
        onTap: () {
          setState(() {
            focusColor = Color(0xff085dcf);
          });
        },
        controller: widget.textController,
        keyboardType: TextInputType.emailAddress,
        obscureText: isObscure,
        style: TextStyle(color: Colors.grey),
        cursorColor: Color(0xffaaabac),
        decoration: InputDecoration(
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                isObscure = !isObscure;
                if (isObscure)
                  eyeIcon = Icons.visibility_off;
                else
                  eyeIcon = Icons.visibility;
              });
            },
            child: Icon(
              eyeIcon,
              color: focusColor,
            ),
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 25.0, right: 20),
            child: Icon(
              EvaIcons.lockOutline,
              color: focusColor,
            ),
          ),
          hintText: 'Enter your password',
          hintStyle: TextStyle(color: Color(0xffaaabac), fontSize: 14),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: focusColor, width: 1.5),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          filled: true,
          fillColor: Color(0xff101010),
          labelText: 'Enter Password'.toUpperCase(),
          labelStyle: TextStyle(color: focusColor, fontSize: 14),
        ),
      ),
    );
  }
}
