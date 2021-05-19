import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_utility/screens/logInScreen.dart';
import '../components/roundedButton.dart';
import '../components/customTextField.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/userAuthentication.dart';
import '../components/dialogBox.dart';
import 'ourServices.dart';

class RegistrationScreen extends StatelessWidget {
  final userAuthentication = UserAuthentication();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

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
                controller: nameController,
                lableText: 'ENTER NAME',
                obsecure: false,
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              CustomTextField(
                // keyboardType: TextInputType.number,
                hintText: 'Enter your phone number',
                icon: EvaIcons.phone,
                onChanged: null,
                controller: phoneController,
                lableText: 'ENTER PHONE NUMBER',
                obsecure: false,
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              CustomTextField(
                // keyboardType: TextInputType.emailAddress,
                hintText: 'Enter your email',
                icon: EvaIcons.personOutline,
                onChanged: null,
                controller: emailController,
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
                controller: passwordController,
                lableText: 'ENTER PASSWORD',
                obsecure: true,
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              RoundedButton(
                text: 'SIGN UP',
                onPressed: () async {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => DialogBox(),
                  );

                  _checkValidation();
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

  Future<void> _checkValidation() async {
    if (nameController.text.trim().isEmpty) {
      Get.back();
      Get.snackbar('ERROR!', 'Your name is mandatory.',
          snackPosition: SnackPosition.BOTTOM);
      return;
    } else if (phoneController.text.isEmpty) {
      Get.back();
      Get.snackbar('ERROR!', 'Your phone number is mandatory.',
          snackPosition: SnackPosition.BOTTOM);
      return;
    } else if (phoneController.text.trim().length != 10) {
      Get.back();
      Get.snackbar('ERROR!', 'Inavlid phone number.',
          snackPosition: SnackPosition.BOTTOM);
      return;
    } else if (phoneController.text.trim().length == 10) {
      try {
        double phoneNo = double.parse(phoneController.text);

        try {
          await userAuthentication.signUp(
              name: nameController.text.trim(),
              phoneNo: phoneNo,
              email: emailController.text.trim(),
              password: passwordController.text);
          Get.back();
          Get.toNamed(MainScreen.id);
          Get.snackbar('CONGRATULATIONS!', 'Your account has been created',
              snackPosition: SnackPosition.BOTTOM);
          // Get.snackbar(title, message)
        } catch (e) {
          Get.back();
          Get.snackbar('ERROR!', e.toString(),
              snackPosition: SnackPosition.BOTTOM);
        }
      } catch (e) {
        Get.back();
        Get.snackbar('ERROR!', 'Please enter a valid phone number',
            snackPosition: SnackPosition.BOTTOM);
      }
    } else if (!emailController.text.trim().contains('@')) {
      Get.back();
      Get.snackbar('ERROR!', 'Inavlid email address.',
          snackPosition: SnackPosition.BOTTOM);

      return;
    } else if (passwordController.text.length < 8) {
      Get.back();
      Get.snackbar('ERROR!', 'Password must be atleast 8 characters long.',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
  }
}
