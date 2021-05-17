import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_utility/screens/logInScreen.dart';
import '../constants.dart';
import '../components/roundedButton.dart';
import '../components/customTextField.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class RegistrationScreen extends StatelessWidget {
  static const id = '/register';
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
                'Register your new account for Home Utility',
                style: GoogleFonts.lato(
                  color: Color(0xffaaabac),
                  fontSize: 15.0,
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              CustomTextField(
                hintText: 'Enter your name',
                icon: EvaIcons.personAddOutline,
                onChanged: null,
                controller: null,
                lableText: 'ENTER NAME',
                obsecure: false,
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              CustomTextField(
                hintText: 'Enter your email',
                icon: EvaIcons.personOutline,
                onChanged: null,
                controller: null,
                lableText: 'ENTER EMAIL',
                obsecure: false,
              ),

              SizedBox(
                height: size.height * 0.03,
              ),
              // Text('Password'),
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
                text: 'SIGN UP',
                onPressed: () {},
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
                        onTap: () => Get.toNamed(LogInScreen.id),
                        child: Text('LOG IN',
                            style: GoogleFonts.roboto(
                              color: Color(0xff024BBC),
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                            ))),
                  ]),
            ],
          ),
        ),
      ),
    );
  }
}
