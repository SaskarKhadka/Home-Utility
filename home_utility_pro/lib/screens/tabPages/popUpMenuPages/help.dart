import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_utility_pro/screens/forgotPasswordScreen.dart';
import 'package:home_utility_pro/screens/mainScreen.dart';
import 'package:home_utility_pro/constants.dart';

class HelpPage extends StatelessWidget {
  static const id = '\HelpPage';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
          backgroundColor: Color(0xFF010202),
          appBar: AppBar(
            toolbarHeight: 67,
            elevation: 2.0,
            centerTitle: true,
            shadowColor: Colors.white,
            leading: IconButton(
              onPressed: () => Get.toNamed(MainScreen.id),
              icon: Icon(Icons.arrow_back),
            ),
            title: Text(
              'Support',
              style: GoogleFonts.montserrat(
                color: Colors.white,
                fontSize: 35,
                fontWeight: FontWeight.w400,
                letterSpacing: 2.5,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: size.height * 0.08,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'How can we help You?',
                      style: GoogleFonts.roboto(
                        color: kWhiteColour,
                        fontSize: 24.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(26.0),
                    child: Text(
                      'Home Utility is utility purpose app that '
                      'provides a platform for easy and accessible utility service to users online. '
                      'The major theme of our project is to make it easy for users to book home services '
                      'and for professionals of different occupations to find work.'
                      '\n\nThis is the applications for technicians/ professionals. A technicain can accept, delete requests on Request page'
                      ' and s/he can see the accepted request in Jobs Page whre S/he can chat to the customer, get directions to customers'
                      ' place on map which makes it easier for them to trace the customer for providing services.'
                      '\n\nFeel free to contact us if you have any problem regarding using this application.',
                      style: GoogleFonts.cabin(
                        color: kWhiteColour,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.12,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: Text(
                      'Contact us',
                      style: GoogleFonts.roboto(
                        color: kWhiteColour,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 200.0,
                    child: Divider(color: Colors.tealAccent),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, left: 60.0),
                        child: Icon(Icons.phone, color: Colors.teal, size: 16),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, left: 16.0, right: 8.0),
                        child: Text(
                          '+977-981000000',
                          style: GoogleFonts.raleway(
                            color: kWhiteColour,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0, left: 60.0),
                        child:
                            Icon(Icons.email, color: Colors.yellow, size: 20),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 2.0, left: 16.0, right: 8.0),
                        child: Text(
                          'services.homeutility@gmail.com',
                          style: GoogleFonts.raleway(
                            color: kWhiteColour,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
