// import 'dart:io';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:home_utility/components/dialogBox.dart';
import 'package:home_utility/screens/ourServices.dart';

import '../components/roundedButton.dart';
import 'registrationScreen.dart';
import '../components/customTextField.dart';

class LogInScreen extends StatelessWidget {
  static const id = '/login';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 15.0,
            vertical: 50.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                  height: size.height * 0.3,
                  child: Center(child: Image.asset('images/signin.jpg'))),
              SizedBox(
                height: size.height * 0.01,
              ),
              Text(
                'Welcome back !',
                style: GoogleFonts.montserrat(
                  color: Color(0xff25232c),
                  fontWeight: FontWeight.bold,
                  fontSize: 28.0,
                ),
              ),
              SizedBox(
                height: size.height * 0.025,
              ),
              Text(
                'Log in to your existing account of Home Utility',
                style: GoogleFonts.lato(
                  color: Color(0xffaaabac),
                  fontSize: 15.0,
                ),
              ),
              SizedBox(
                height: size.height * 0.04,
              ),
              CustomTextField(
                hintText: 'Enter your email address',
                icon: EvaIcons.personOutline,
                onChanged: null,
                controller: null,
                lableText: 'ENTER EMAIL',
                obsecure: false,
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              CustomTextField(
                hintText: 'Enter your password',
                icon: EvaIcons.lockOutline,
                onChanged: null,
                controller: null,
                lableText: 'ENTER PASSWORD',
                obsecure: true,
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              RoundedButton(
                text: 'LOG IN',
                onPressed: () async {
                  // showDialog(
                  //   context: context,
                  //   barrierDismissible: false,
                  //   builder: (context) => DialogBox(),
                  // );

                  Get.toNamed(MainScreen.id);
                },
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Dont have an account ?  ',
                    style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                      onTap: () => Get.toNamed(RegistrationScreen.id),
                      child: Text('Sign Up',
                          style: GoogleFonts.roboto(
                            color: Color(0xff024BBC),
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                          ))),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
