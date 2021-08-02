import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_utility_pro/components/customTextField.dart';
import 'package:home_utility_pro/components/dialogBox.dart';
import 'package:home_utility_pro/controllers/textController.dart';
import 'package:home_utility_pro/main.dart';
import 'package:home_utility_pro/components/customButton.dart';
import 'package:home_utility_pro/screens/loginscreen.dart';
import 'signupscreen.dart';
class ForgetPassword extends StatelessWidget {
 static String id = 'forgotPassword';
  @override
  Widget build(BuildContext context) {
    final textController = Get.find<TextController>();
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
                  child: Center(child: Image.asset('images/forgetpassword.png'))
                  ),
                Text('Reset Password !',style: GoogleFonts.montserrat(color: Color(0xffECECEC),fontWeight: FontWeight.bold,fontSize: 28),),
                SizedBox(height: size.height * 0.01),
                Text('Please Enter Your Email Address To', style: GoogleFonts.lato(color: Color(0xffaaabac), fontSize: 15),),
                SizedBox(height: size.height * 0.01),
                Text('Recieve a Varification Code ', style: GoogleFonts.lato(color: Color(0xffaaabac), fontSize: 15),),
                SizedBox(height: size.height * 0.09),
                NewTextfield(
                  textController: textController.emailController,
                  isPhoneNumber: false,
                      hintText: 'Enter your email adress',
                      lableText: 'ENTER EMAIL',
                      icon: EvaIcons.personOutline,
                      obsecure: false,
                      
                  ),
                              
                SizedBox(height: size.height * 0.09),
                CustomButton(
                  text: 'Send Email',
                    ontap: ()async{
                      if (textController.emailController.text.isEmpty) {
                        getSnackBar(
                          title: 'ERROR!',
                          message: 'Please enter your email address',
                        );
                        return;
                      } else if (!textController.emailController.text.isEmail) {
                        getSnackBar(
                          title: 'ERROR!',
                          message: 'Please enter a valid email address',
                        );
                        return;
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) => DialogBox(
                            title: 'Authenticating',
                          ),
                        );
                        String code = await userAuthentication.passwordReset(
                          email: textController.emailController.text.trim(),
                        );
                        Get.back();
                        if (code == 'user-not-found') {
                          Get.back();
                          getSnackBar(
                              title: 'ERROR!', message: 'User not found');
                          return;
                        }
                        // Get.back();
                        showDialog(
                            context: (context),
                            builder: (context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                    side: BorderSide.none,
                                    borderRadius: BorderRadius.circular(20.0)),
                                insetAnimationCurve: Curves.bounceIn,
                                backgroundColor: Color(0xFF110E1F),
                                elevation: 0.0,
                                insetPadding: EdgeInsets.symmetric(
                                  vertical: 25.0,
                                  horizontal: 25.0,
                                ),
                                child: Container(
                                  width: size.width,
                                  decoration: BoxDecoration(
                                    color: Color(0xff141a1e),
                                    borderRadius: BorderRadius.circular(20.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(0, 2),
                                        blurRadius: 10.0,
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 18.0,
                                          left: 8.0,
                                          right: 8.0,
                                        ),
                                        child: Text(
                                          'Confirm Email',
                                          style: GoogleFonts.montserrat(
                                            color: Colors.white,
                                            fontSize: 26,
                                            letterSpacing: 2.0,
                                            wordSpacing: 2.0,
                                            fontStyle: FontStyle.normal,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 250.0,
                                        child: Divider(
                                          color: Colors.white70,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 18.0,
                                          left: 20.0,
                                          right: 18.0,
                                          bottom: 18.0,
                                        ),
                                        child: Text(
                                          'An email has just been sent to you, Visit the link to change your password.',
                                          style: GoogleFonts.montserrat(
                                            color: Colors.white,
                                            fontSize: 19,
                                            letterSpacing: 2.0,
                                            wordSpacing: 2.0,
                                            // fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () => Get.back(),
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            vertical: 10.0,
                                            horizontal: 20.0,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Color(0xff4f5b8a),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color(0xff2f3650),
                                                offset: Offset(0, 1),
                                                blurRadius: 4.0,
                                              ),
                                            ],
                                          ),
                                          child: Text(
                                            'Ok',
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: size.height * 0.02,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                        textController.emailController.clear();
                      }

                    },
                ),
                SizedBox(height: size.height * 0.03),
               
                 SizedBox(height: size.height * 0.01),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:<Widget>[
                    
                      Text('Remember Password ?  ', style: GoogleFonts.roboto(color: Color(0xffaaabac),fontSize: 16),),
                      GestureDetector(
                        onTap: (){
                           Get.toNamed(Login.id);
                        },

                        child: Container(child: Text('Log In ', style: GoogleFonts.roboto(color:  Color(0xff024BBC),fontSize: 18,fontWeight: FontWeight.w600,)))
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