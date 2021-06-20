import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_utility_pro/main.dart';

import '../../constants.dart';

class ProsProfile extends StatelessWidget {
  const ProsProfile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    //    double screenHeight = MediaQuery.of(context).size.height;
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Container(
            child: StreamBuilder(
                stream: prosRefrence.child(userAuthentication.userID).onValue,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  Map prosData = snapshot.data.snapshot.value;
                  return Stack(
                    // textDirection: TextDirection.ltr,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Container(
                            height: 130,
                            width: double.infinity,
                            color: Colors.black,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10),
                            child: Container(
                              width: screenWidth,
                              decoration: BoxDecoration(
                                  color: Color(0xff6A5CD0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(23))),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(top: 60),
                                    child: Text(
                                      prosData['prosName'],
                                      style: GoogleFonts.montserrat(
                                          fontSize: 22,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    prosData['profession'],
                                    style: GoogleFonts.montserrat(
                                        fontSize: 16, color: Colors.white70),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  // SizedBox(height: 30),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10),
                            child: Container(
                              width: screenWidth,
                              decoration: BoxDecoration(
                                color: Color(0xff1F1D2B),
                                border: Border.all(
                                  color: kWhiteColour,
                                  width: 1.0,
                                  style: BorderStyle.solid,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  children: <Widget>[
                                    SizedBox(width: 10),
                                    Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xffea473c),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color(0xffea473c)
                                                  .withOpacity(0.6),
                                              spreadRadius: 3,
                                              blurRadius: 10,
                                              offset: Offset(2,
                                                  4), // changes position of shadow
                                            ),
                                          ]),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Icon(
                                          EvaIcons.personOutline,
                                          color: Colors.white,
                                          size: 40,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 50),
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text('USERNAME',
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold)),
                                          SizedBox(height: 6),
                                          Text(prosData['prosName'],
                                              style: GoogleFonts.roboto(
                                                  fontSize: 16,
                                                  color: Colors.white70)),
                                        ]),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10),
                            child: Container(
                              width: screenWidth,
                              decoration: BoxDecoration(
                                  color: Color(0xff1F1D2B),
                                  border: Border.all(
                                    color: kWhiteColour,
                                    width: 1.0,
                                    style: BorderStyle.solid,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  children: <Widget>[
                                    SizedBox(width: 10),
                                    Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xff2CCD7A),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color(0xff2CCD7A)
                                                  .withOpacity(0.6),

                                              spreadRadius: 3,
                                              blurRadius: 10,
                                              offset: Offset(2,
                                                  4), // changes position of shadow
                                            ),
                                          ]),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Icon(
                                          EvaIcons.emailOutline,
                                          color: Colors.white,
                                          size: 40,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 50),
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text('EMAIL',
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold)),
                                          SizedBox(height: 6),
                                          Text(prosData['prosEmail'],
                                              style: GoogleFonts.roboto(
                                                  fontSize: 16,
                                                  color: Colors.white70)),
                                        ]),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10),
                            child: Container(
                              width: screenWidth,
                              decoration: BoxDecoration(
                                  color: Color(0xff1F1D2B),
                                  border: Border.all(
                                    color: kWhiteColour,
                                    width: 1.0,
                                    style: BorderStyle.solid,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  children: <Widget>[
                                    SizedBox(width: 10),
                                    Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xff8F77FF),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color(0xff8F77FF)
                                                  .withOpacity(0.6),
                                              spreadRadius: 3,
                                              blurRadius: 10,
                                              offset: Offset(2,
                                                  4), // changes position of shadow
                                            ),
                                          ]),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Icon(
                                          EvaIcons.phoneOutline,
                                          color: Colors.white,
                                          size: 40,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 50),
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text('PHONE NO',
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold)),
                                          SizedBox(height: 6),
                                          Text('${prosData['prosPhoneNo']}',
                                              style: GoogleFonts.roboto(
                                                  fontSize: 16,
                                                  color: Colors.white70)),
                                        ]),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10),
                            child: Container(
                              width: screenWidth,
                              decoration: BoxDecoration(
                                  color: Color(0xff1F1D2B),
                                  border: Border.all(
                                    color: kWhiteColour,
                                    width: 1.0,
                                    style: BorderStyle.solid,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  children: <Widget>[
                                    SizedBox(width: 10),
                                    Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xffFEC946),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color(0xffFEC946)
                                                  .withOpacity(0.6),
                                              spreadRadius: 3,
                                              blurRadius: 10,
                                              offset: Offset(2,
                                                  4), // changes position of shadow
                                            ),
                                          ]),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Icon(
                                          EvaIcons.homeOutline,
                                          color: Colors.white,
                                          size: 40,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 50),
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text('ADDRESS',
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold)),
                                          SizedBox(height: 6),
                                          Text(
                                              prosData['prosMunicipality'] +
                                                  ', ' +
                                                  prosData['prosDistrict'],
                                              style: GoogleFonts.roboto(
                                                  fontSize: 16,
                                                  color: Colors.white70)),
                                        ]),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 30),
                          Container(
                            child: Center(
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      height: size.height * 0.07,
                                      width: size.width * 0.4,
                                      decoration: BoxDecoration(
                                          color: Color(0xFF3BACA2),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(22)),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color(0xff8F77FF)
                                                  .withOpacity(0.3),
                                              spreadRadius: 3,
                                              blurRadius: 10,
                                              offset: Offset(2,
                                                  7), // changes position of shadow
                                            ),
                                          ]),
                                      child: Center(
                                        child: Text(
                                          'Edit Profile',
                                          style: GoogleFonts.roboto(
                                              color: Colors.white70,
                                              fontSize: 18),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      height: size.height * 0.07,
                                      width: size.width * 0.4,
                                      decoration: BoxDecoration(
                                          color: Color(0xFFCF433E),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color(0xff8F77FF)
                                                  .withOpacity(0.3),
                                              spreadRadius: 3,
                                              blurRadius: 10,
                                              offset: Offset(2,
                                                  7), // changes position of shadow
                                            ),
                                          ]),
                                      child: Center(
                                        child: Text(
                                          'Sign Out',
                                          style: GoogleFonts.roboto(
                                              color: Colors.white70,
                                              fontSize: 18),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 30),
                        ],
                      ),
                      Positioned(
                        top: 60,
                        left: 130,
                        right: 130,
                        child: CircleAvatar(
                          radius: 55,
                          backgroundColor: Colors.black,
                          backgroundImage: AssetImage('images/person.png'),
                        ),
                      ),
                      Positioned(
                        top: 142,
                        left: 170,
                        right: 120,
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.black,
                          child: IconButton(
                            icon: Icon(
                              Icons.camera_alt_rounded,
                              color: Colors.white,
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ),
                    ],
                  );
                }),
          ),
        ),
      ),
    );
  }
}
