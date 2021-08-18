import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_utility_pro/constants.dart';
import 'package:home_utility_pro/screens/mainScreen.dart';

class AboutPage extends StatelessWidget {
  static const id = '\AboutPage';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBlackColour,
        appBar: AppBar(
          toolbarHeight: 60,
          elevation: 2.0,
          centerTitle: true,
          shadowColor: Colors.white,
          leading: IconButton(
            onPressed: () => Get.toNamed(MainScreen.id),
            icon: Icon(Icons.arrow_back),
          ),
          title: Text(
            'About',
            style: GoogleFonts.montserrat(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.w400,
              letterSpacing: 2.5,
            ),
          ),
        ),
        body: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  top: 20.0, left: 20.0, right: 20.0, bottom: 20.0),
              child: Text(
                'Finding a technician these days can be very tedious. People have to search very hard and they end up wasting their whole day in search of a technician. There are also cases of people being deceived. There are various incidents of failure of getting a technician of our need in just a short span of time. However if you find a technician without proper guidance, there is a high chance that you might overpay for your task.\n\nHome Utility provides a platform for people, with a motive to guide them towards finding a good, trustable and well-experienced technician at an affordable price as per their needs. It can help people save their valuable time and provide them the best services. It facilitates users and provide employment to technicians. ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 28.0, bottom: 5.0, left: 20.0, right: 20.0),
                  child: Text(
                    'Developers: ',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  width: 100.0,
                  child: Divider(
                    color: Colors.white70,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                  child: Text(
                    'Saskar Khadka',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                  child: Text(
                    'Gaurav Khadka',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                  child: Text(
                    'Rohan Dhakal',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                  child: Text(
                    'Saugat Poudel',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                  child: Text(
                    'Saugat Adhikari',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
