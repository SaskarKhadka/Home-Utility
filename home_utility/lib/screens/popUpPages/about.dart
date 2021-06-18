import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_utility/screens/mainScreen.dart';

class AboutPage extends StatelessWidget {
  static const id = '\AboutPage';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.indigo.shade50,
        appBar: AppBar(
          toolbarHeight: 67,
          elevation: 2.0,
          centerTitle: true,
          shadowColor: Colors.white,
          leading: IconButton(
            onPressed: () => Get.toNamed(MainScreen.id),
            icon: Icon(Icons.arrow_back_ios),
          ),
          title: Text(
            'Developers',
            style: GoogleFonts.montserrat(
              color: Colors.white,
              fontSize: 35,
              fontWeight: FontWeight.w400,
              letterSpacing: 2.5,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: size.height * 0.07,
                  ),
                  Text(
                    'Saugat Adhikari',
                    style: GoogleFonts.montserrat(
                      letterSpacing: 2.8,
                      wordSpacing: 2.8,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Text(
                    '{Email:saugatadhikari.sa@gmail.com}',
                    style: GoogleFonts.mada(
                      letterSpacing: 2.8,
                      wordSpacing: 2.8,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.07,
                  ),
                  Text(
                    'Rohan Dhakal',
                    style: GoogleFonts.montserrat(
                      letterSpacing: 2.8,
                      wordSpacing: 2.8,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Text(
                    '{Email:dhakalrohan229@gmail.com}',
                    style: GoogleFonts.mada(
                      letterSpacing: 2.8,
                      wordSpacing: 2.8,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.07,
                  ),
                  Text(
                    'Gaurav Khadka',
                    style: GoogleFonts.montserrat(
                      letterSpacing: 2.8,
                      wordSpacing: 2.8,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Text(
                    '{Email:gauravkhadka4593@gmail.com}',
                    style: GoogleFonts.mada(
                      letterSpacing: 2.8,
                      wordSpacing: 2.8,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.07,
                  ),
                  Text(
                    'Saskar Khadka',
                    style: GoogleFonts.montserrat(
                      letterSpacing: 2.8,
                      wordSpacing: 2.8,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Text(
                    '{Email:saskar.khadka@gmail.com}',
                    style: GoogleFonts.mada(
                      letterSpacing: 2.8,
                      wordSpacing: 2.8,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.07,
                  ),
                  Text(
                    'Saugat Poudel',
                    style: GoogleFonts.montserrat(
                      letterSpacing: 2.8,
                      wordSpacing: 2.8,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Text(
                    '{Email:saugat.poudel478@gmail.com}',
                    style: GoogleFonts.mada(
                      letterSpacing: 2.8,
                      wordSpacing: 2.8,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.07,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
