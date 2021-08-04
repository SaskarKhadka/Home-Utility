import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:home_utility/components/detailsDialog.dart';
import 'package:home_utility/screens/popUpPages/about.dart';
import 'package:home_utility/screens/popUpPages/help.dart';
import '../../main.dart';
import 'package:google_fonts/google_fonts.dart';
import '../logInScreen.dart';

class ServicePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Container(
        width: MediaQuery.of(context).size.width,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
                left: 20.0, right: 15, top: 15, bottom: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Find the best\nservice for you",
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 30,
                      ),
                    ),
                    Theme(
                      data: Theme.of(context).copyWith(
                          textTheme: TextTheme().apply(bodyColor: Colors.black),
                          dividerColor: Colors.black,
                          iconTheme: IconThemeData(color: Colors.white)),
                      child: PopupMenuButton<int>(
                        color: Color(0xff17191A),
                        itemBuilder: (BuildContext context) => [
                          PopupMenuItem<int>(
                            value: 0,
                            child: Text(
                              "About us",
                              style: GoogleFonts.roboto(
                                color: Colors.white70,
                                letterSpacing: 1.8,
                              ),
                            ),
                          ),
                          PopupMenuItem<int>(
                              value: 1,
                              child: Text(
                                "Help",
                                style: GoogleFonts.roboto(
                                  color: Colors.white70,
                                  letterSpacing: 1.8,
                                ),
                              )),
                          PopupMenuDivider(),
                          PopupMenuItem<int>(
                              value: 2,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.logout,
                                    color: Colors.red,
                                  ),
                                  const SizedBox(
                                    width: 7,
                                  ),
                                  Text(
                                    "Sign Out",
                                    style: GoogleFonts.roboto(
                                      color: Colors.white70,
                                      letterSpacing: 1.8,
                                    ),
                                  )
                                ],
                              )),
                        ],
                        onSelected: (item) => SelectedItem(context, item),
                        offset: Offset(0, 70),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Repair Devices",
                  style: GoogleFonts.montserrat(
                      color: Color(0xffd17842), fontSize: 20),
                ),
                Divider(
                  color: Color(0xffd17842),
                  endIndent: 300,
                  indent: 30,
                  thickness: 1,
                ),
                ServiceCard(category: 'repair'),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "House Work",
                  style: GoogleFonts.montserrat(
                      color: Color(0xffd17842), fontSize: 20),
                ),
                Divider(
                  color: Color(0xffd17842),
                  endIndent: 300,
                  indent: 30,
                  thickness: 1,
                ),
                ServiceCard(
                  category: 'householdChores',
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Beauty",
                  style: GoogleFonts.montserrat(
                      color: Color(0xffd17842), fontSize: 20),
                ),
                Divider(
                  color: Color(0xffd17842),
                  endIndent: 330,
                  indent: 10,
                  thickness: 1,
                ),
                ServiceCard(
                  category: 'beauty',
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Home Maintenance",
                  style: GoogleFonts.montserrat(
                      color: Color(0xffd17842), fontSize: 20),
                ),
                Divider(
                  color: Color(0xffd17842),
                  endIndent: 300,
                  indent: 30,
                  thickness: 1,
                ),
                ServiceCard(
                  category: 'homeMaintenance',
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}

Future<void> SelectedItem(BuildContext context, int item) async {
  switch (item) {
    case 0:
      Get.toNamed(AboutPage.id);
      break;
    case 1:
      Get.toNamed(HelpPage.id);
      break;
    case 2:
      // showDialog(
      //   context: context,
      //   barrierDismissible: false,
      //   builder: (context) => DialogBox(
      //     title: 'Signing Out',
      //   ),
      // );
      await userAuthentication.signOut();
      Get.offAllNamed(Login.id);
      break;
  }
}

class ServiceCard extends StatelessWidget {
  final String category;

  ServiceCard({this.category});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: serviceRefrence.child(category).onValue,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlue,
              ),
            );
          }
          Map services = snapshot.data.snapshot.value;

          List<Map> data = [];
          if (services != null) {
            services.forEach((key, value) {
              data.add(value as Map);
            });

            return Container(
              height: 250,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.to(DetailsPage(
                              service: data[index]['service'],
                              category: category,
                            ));
                          },
                          child: Container(
                            height: 250,
                            width: 160,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 135,
                                  width: 140,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              data[index]['imgUrl']),
                                          fit: BoxFit.cover)),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data[index]['service'],
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          RatingBar.builder(
                                            initialRating:
                                                data[index]['rating'] == null
                                                    ? 0.99
                                                    : double.parse(data[index]
                                                            ['rating']
                                                        .toString()),
                                            glowColor: Colors.amber,
                                            ignoreGestures: true,
                                            unratedColor: Colors.white54,
                                            itemSize: 17,
                                            glowRadius: 1,
                                            // itemPadding: EdgeInsets.all(2.5),
                                            minRating: 1,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            itemBuilder: (context, index) =>
                                                Icon(
                                              EvaIcons.star,
                                              color: Colors.amber,
                                            ),
                                            onRatingUpdate: (rating) {
                                              // proRating = rating;
                                            },
                                          ),
                                          Container(
                                              height: 30,
                                              width: 30,
                                              decoration: BoxDecoration(
                                                  color: Color(0xffd17842),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Icon(
                                                Icons.add,
                                                color: Colors.white,
                                                size: 20,
                                              ))
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            decoration: BoxDecoration(
                                color: Color(0xff17191A),
                                borderRadius: BorderRadius.circular(20)),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                      ],
                    );
                  }),
            );
          }
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlue,
            ),
          );
        });
  }
}
