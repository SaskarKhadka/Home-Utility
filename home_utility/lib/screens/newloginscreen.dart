import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_utility/controllers/logInController.dart';
import 'package:home_utility/main.dart';
import 'newforgetpasswordscreen.dart';
import 'package:home_utility/screens/signupscreen.dart';
import '../constants.dart';
import '../components/customButton.dart';
import 'mainScreen.dart';

import '../components/customTextField.dart';
import '../components/dialogBox.dart';

class Login extends StatelessWidget {

  static const id = '/login';
  final logInController = LogInController();
  @override
  Widget build(BuildContext context) {
Size size = MediaQuery.of(context).size;
// final TextStyle display1 = Theme.of(context).textTheme.headline4;
    return Scaffold(
      backgroundColor:Colors.black87,
      body: SafeArea(
              child: Container(
         
          child: SingleChildScrollView(
           child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             crossAxisAlignment: CrossAxisAlignment.center,
             children:<Widget> [
                Container(
                  
                  height: size.height * 0.3,
                  child: Center(child: Image.asset('images/icon.png'))
                  ),
                Text('Welcome back !',style: GoogleFonts.montserrat(color: Color(0xffECECEC),fontWeight: FontWeight.bold,fontSize: 28),),
                SizedBox(height: size.height * 0.01),
                Text('Log in to your existing account of Home Utility', style: GoogleFonts.lato(color: Color(0xffaaabac), fontSize: 15),),
                SizedBox(height: size.height * 0.07),
                NewTextfield(
                      textController: logInController.emailController,
                      isPhoneNumber: false,
                      hintText: 'Enter your email adress',
                      lableText: 'ENTER EMAIL',
                      icon: EvaIcons.personOutline,
                      obsecure: false,
                      
                  ),
                SizedBox(height: size.height * 0.03),
                NewTextfield(
                   textController:
                                  logInController.passwordController,
                    hintText: 'Enter your password',
                      lableText: 'ENTER PASSWORD',
                      icon: EvaIcons.lockOutline,
                      obsecure: true,
                      isPhoneNumber: false,
                ),
                SizedBox(height:10),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    width: size.width,
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child:  
                      GestureDetector(
                        onTap: (){
                          Get.toNamed(ForgetPassword.id);
                        },
                        child: Container(child: Text('Forget password?  ',style: TextStyle(color: Colors.blue,fontSize: 15),))))),
                ),
                SizedBox(height: size.height * 0.07),
                LoginButton(
                  text: 'SIGN IN',
                    ontap: ()async{
                          showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context) => DialogBox(
                                    title: 'Authenticating',
                                  ),
                                );

                                if (logInController
                                    .emailController.text.isEmpty) {
                                  Get.back();
                                  getSnackBar(
                                    title: 'ERROR!',
                                    message: 'Please enter your email address',
                                  );
                                  return;
                                } else {
                                  if (!logInController
                                      .emailController.text.isEmail) {
                                    Get.back();
                                    // proceed = false;
                                    getSnackBar(
                                        title: 'ERROR!',
                                        message:
                                            'Please enter a valid email address');
                                    return;
                                  }
                                }
                                if (logInController
                                    .passwordController.text.isEmpty) {
                                  Get.back();

                                  getSnackBar(
                                    title: 'ERROR!',
                                    message: 'Please enter your password',
                                  );
                                  return;
                                }

                                String code = await userAuthentication.signIn(
                                    email: logInController.emailController.text
                                        .trim(),
                                    password: logInController
                                        .passwordController.text);

                                if (code == 'success') {
                                  await database.totalUsersRequests();
                                  Get.back();
                                  Get.offAllNamed(MainScreen.id);
                                } else if (code == 'wrong-password') {
                                  Get.back();
                                  userAuthentication.signOut();
                                  getSnackBar(
                                      title: 'ERROR!',
                                      message:
                                          'Wrong Password! Please enter your valid password');
                                  return;
                                } else {
                                  Get.back();
                                  userAuthentication.signOut();
                                  getSnackBar(
                                    title: 'ERROR!',
                                    message:
                                        'Record not found! Please create a new account if you donot have one.',
                                  );
                                  return;
                                }

                    },
                ),
                SizedBox(height: size.height * 0.03),
               
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:<Widget>[
                    
                      Text('Dont have an account ?  ', style: GoogleFonts.roboto(color: Color(0xffaaabac),fontSize: 16),),
                      GestureDetector(
                        onTap: (){
                          Get.toNamed(Signup.id);
                        },
                        child: Container(child: Text('Sign Up', style: GoogleFonts.roboto(color:  Color(0xff024BBC),fontSize: 18,fontWeight: FontWeight.w600,)))
                      ),
                  ]
                ),
           
           ],)
          ),
        ),
      ) ,
    );
  }
}