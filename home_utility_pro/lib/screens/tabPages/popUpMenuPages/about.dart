import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_utility_pro/screens/mainScreen.dart';

class AboutPage extends StatelessWidget {
  static const id = '\AboutPage';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff141a1e),
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
            'Developers',
            style: GoogleFonts.montserrat(
              color: Colors.white,
              fontSize: 35,
              fontWeight: FontWeight.w400,
              letterSpacing: 2.5,
            ),
          ),
        ),
        body: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  top: 28.0, bottom: 16.0, left: 16.0, right: 16.0),
              child: FittedBox(
                child: Material(
                  color: Color(0xff202934),
                  borderRadius: BorderRadius.circular(24.0),
                  shadowColor: Colors.grey,
                  elevation: 5.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Container(
                                  child: Text(
                                "SAUGAT POUDEL",
                                style: GoogleFonts.shortStack(
                                  color: Colors.white,
                                  fontSize: 38.0,
                                ),
                              )),
                              Container(
                                  child: Text(
                                "Flutter UI developer",
                                style: GoogleFonts.sansita(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 200.0,
                        height: 200.0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(24.0),
                          child: Image(
                            image: AssetImage('images/saugat.jpg'),
                            fit: BoxFit.cover,
                            // alignment: Alignment.topRight,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 18.0, bottom: 16.0, left: 16.0, right: 16.0),
              child: FittedBox(
                child: Material(
                  color: Color(0xff202934),
                  borderRadius: BorderRadius.circular(24.0),
                  shadowColor: Colors.grey,
                  elevation: 5.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Container(
                                  child: Text(
                                "ROHAN DHAKAL",
                                style: GoogleFonts.shortStack(
                                  color: Colors.white,
                                  fontSize: 38.0,
                                ),
                              )),
                              Container(
                                  child: Text(
                                "Flutter UI developer",
                                style: GoogleFonts.sansita(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 200.0,
                        height: 200.0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(24.0),
                          child: Image(
                            image: AssetImage('images/rohan.jpg'),
                            fit: BoxFit.cover,
                            // alignment: Alignment.topRight,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 18.0, bottom: 16.0, left: 16.0, right: 16.0),
              child: FittedBox(
                child: Material(
                  color: Color(0xff202934),
                  borderRadius: BorderRadius.circular(24.0),
                  shadowColor: Colors.grey,
                  elevation: 5.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Container(
                                  child: Text(
                                "GAURAV KHADKA",
                                style: GoogleFonts.shortStack(
                                  color: Colors.white,
                                  fontSize: 38.0,
                                ),
                              )),
                              Container(
                                  child: Text(
                                "Flutter UI developer",
                                style: GoogleFonts.sansita(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 200.0,
                        height: 200.0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(24.0),
                          child: Image(
                            image: AssetImage('images/gaurab.jpg'),
                            fit: BoxFit.cover,
                            // alignment: Alignment.topRight,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 18.0, bottom: 16.0, left: 16.0, right: 16.0),
              child: FittedBox(
                child: Material(
                  color: Color(0xff202934),
                  borderRadius: BorderRadius.circular(24.0),
                  shadowColor: Colors.grey,
                  elevation: 5.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Container(
                                  child: Text(
                                "SASKAR KHADKA",
                                style: GoogleFonts.shortStack(
                                  color: Colors.white,
                                  fontSize: 38.0,
                                ),
                              )),
                              Container(
                                  child: Text(
                                "Flutter Backend developer",
                                style: GoogleFonts.sansita(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 200.0,
                        height: 200.0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(24.0),
                          child: Image(
                            image: AssetImage('images/saskar.jpg'),
                            fit: BoxFit.cover,
                            // alignment: Alignment.topRight,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 18.0, bottom: 36.0, left: 16.0, right: 16.0),
              child: FittedBox(
                child: Material(
                  color: Color(0xff202934),
                  borderRadius: BorderRadius.circular(24.0),
                  shadowColor: Colors.grey,
                  elevation: 5.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Container(
                                  child: Text(
                                "SAUGAT ADHIKARI",
                                style: GoogleFonts.shortStack(
                                  color: Colors.white,
                                  fontSize: 38.0,
                                ),
                              )),
                              Container(
                                  child: Text(
                                "Flutter Backend developer",
                                style: GoogleFonts.sansita(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 200.0,
                        height: 200.0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(24.0),
                          child: Image(
                            image: AssetImage('images/saugatadh.jpg'),
                            fit: BoxFit.cover,
                            // alignment: Alignment.topRight,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
