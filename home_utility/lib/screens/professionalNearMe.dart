import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_utility/constants.dart';
import 'package:home_utility/location/userLocation.dart';
import 'package:home_utility/main.dart';
import 'package:search_choices/search_choices.dart';
import 'package:uuid/uuid.dart';
import 'dart:math' show cos, sqrt, asin;

class ProfessionalsNearMe extends StatefulWidget {
  final DateTime dateTime;
  final String description;
  final String category;
  final String service;
  final DateTime date;
  final TimeOfDay time;
  final String municipality;
  final String district;
  final double latitude;
  final double longitude;

  ProfessionalsNearMe({
    this.dateTime,
    this.description,
    this.category,
    this.service,
    this.date,
    this.time,
    this.municipality,
    this.district,
    this.latitude,
    this.longitude,
  });

  @override
  _ProfessionalsNearMeState createState() => _ProfessionalsNearMeState();
}

class _ProfessionalsNearMeState extends State<ProfessionalsNearMe> {
  bool sortByMunVDC = true;
  String _distanceValue;
  double _distanceValueNum;
  Map<String, double> _distanceMap = {
    '250 meter': 250,
    '500 meter': 500,
    '1 Kilometer': 1000,
    '1.25 Kilometer': 1250,
    '1.5 Kilometer': 1500,
    '2 Kilometer': 2000,
    '2.5 Kilometer': 2500,
  };

  @override
  void initState() {
    // TODO: implement initState
    print(widget.category);
    _distanceValue = '250 meter';
    _distanceValueNum = _distanceMap[_distanceValue];
    super.initState();
  }

  List<DropdownMenuItem<String>> _getItems() {
    List<DropdownMenuItem<String>> items = [];
    List<String> distances = [];
    _distanceMap.forEach((key, value) {
      distances.add(key);
    });
    for (String distance in distances) {
      items.add(
        DropdownMenuItem(
          child: Text(distance),
          value: distance,
        ),
      );
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.category);
    // print('here');
    // print(sortByMunVDC);
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBlackColour,
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 15.0,
                  horizontal: 20.0,
                ),
                child: Text(
                  'Select a Pro',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    color: kWhiteColour,
                    fontSize: 35.0,
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 20.0,
                  ),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: kWhiteColour,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Search Radius:  ',
                            style: GoogleFonts.montserrat(
                              color: kBlackColour,
                              fontSize: 20.0,
                            ),
                          ),
                          DropdownButton(
                            style: GoogleFonts.montserrat(
                              color: kBlackColour,
                              fontSize: 20.0,
                            ),
                            items: _getItems(),
                            value: _distanceValue,
                            onChanged: (newValue) {
                              setState(() {
                                _distanceValue = newValue;
                                _distanceValueNum =
                                    _distanceMap[_distanceValue];
                              });
                            },
                          ),
                        ],
                      ),
                      // SizedBox(
                      //   height: 15.0,
                      // ),
                      // Row(
                      //   children: [
                      //     Text(
                      //       'Sort By:',
                      //       style: GoogleFonts.montserrat(
                      //         color: kBlackColour.withOpacity(0.7),
                      //         fontSize: 15.0,
                      //       ),
                      //     ),
                      //     SizedBox(
                      //       width: 10.0,
                      //     ),
                      //     GestureDetector(
                      //       onTap: () {
                      //         setState(
                      //           () {
                      //             sortByMunVDC = true;
                      //           },
                      //         );
                      //       },
                      //       child: Container(
                      //         padding: EdgeInsets.symmetric(
                      //           vertical: 10.0,
                      //           horizontal: 15.0,
                      //         ),
                      //         decoration: BoxDecoration(
                      //           color: sortByMunVDC
                      //               ? kBlackColour
                      //               : kBlackColour.withOpacity(0.8),
                      //           boxShadow: [
                      //             BoxShadow(
                      //               color: Colors.black.withOpacity(0.3),
                      //               blurRadius: 15,
                      //               offset: Offset(2, 7),
                      //             ),
                      //           ],
                      //           borderRadius: BorderRadius.circular(10.0),
                      //         ),
                      //         child: Text(
                      //           'Municipality',
                      //           style: GoogleFonts.montserrat(
                      //             color: kWhiteColour,
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //     SizedBox(
                      //       width: 10.0,
                      //     ),
                      //     GestureDetector(
                      //       onTap: () {
                      //         setState(() {
                      //           sortByMunVDC = false;
                      //         });
                      //       },
                      //       child: Container(
                      //         padding: EdgeInsets.symmetric(
                      //           vertical: 10.0,
                      //           horizontal: 15.0,
                      //         ),
                      //         decoration: BoxDecoration(
                      //           color: sortByMunVDC
                      //               ? kBlackColour.withOpacity(0.8)
                      //               : kBlackColour,
                      //           boxShadow: [
                      //             BoxShadow(
                      //               color: Colors.black.withOpacity(0.3),
                      //               blurRadius: 15,
                      //               offset: Offset(2, 7),
                      //             ),
                      //           ],
                      //           borderRadius: BorderRadius.circular(10.0),
                      //         ),
                      //         child: Text(
                      //           'District',
                      //           style: GoogleFonts.montserrat(
                      //             color: kWhiteColour,
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      SizedBox(
                        height: 10.0,
                      ),
                      // prosStream(),
                      Expanded(
                        child: ProsStream(
                          dateTime: widget.dateTime,
                          description: widget.description,
                          category: widget.category,
                          service: widget.service,
                          date: widget.date,
                          time: widget.time,
                          municipality: widget.municipality,
                          district: widget.district,
                          sortByMunVDC: sortByMunVDC,
                          latitude: widget.latitude,
                          longitude: widget.longitude,
                          distanceRadius: _distanceValueNum,
                          distanceRadiusStr: _distanceValue,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProsStream extends StatelessWidget {
  final DateTime dateTime;
  final String description;
  final String category;
  final String service;
  final DateTime date;
  final TimeOfDay time;
  final String municipality;
  final String district;
  final bool sortByMunVDC;
  final double latitude;
  final double longitude;
  final double distanceRadius;
  final String distanceRadiusStr;
  ProsStream({
    this.dateTime,
    this.description,
    this.category,
    this.service,
    this.date,
    this.time,
    this.municipality,
    this.district,
    this.sortByMunVDC,
    this.latitude,
    this.longitude,
    this.distanceRadius,
    this.distanceRadiusStr,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return StreamBuilder(
      stream: prosRefrence.onValue,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height * 0.25,
              ),
              Text(
                  'Looking for professionals around your $distanceRadiusStr radius'),
              SizedBox(
                height: 10.0,
              ),
              CircularProgressIndicator(
                backgroundColor: Colors.blue,
              ),
            ],
          );
        }
        Map pros = snapshot.data.snapshot.value;

        // ref.update(messages);
        // print(snapshot.data.snapshot.value);
        // print(messages);
        // if (messages != null) {
        // print(pros);
        List<Map> data = [];
        pros.forEach((key, value) {
          data.add(value as Map);
        });
        int totalRequests = 0;

        // print(data);

        // for(Map data in data) {
        //   ref.child(path)
        // }
        return Container(
          // height: 200, //TODO: manage

          child: ListView.builder(
            // controller: scrollController,
            shrinkWrap: true,
            itemCount: data.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              String profession = data[index]['profession'];

              if (profession != null &&
                  professionToCategory(profession) == category) {
                // String prosMunicipality = data[index]['prosMunicipality'];
                // String prosDistrict = data[index]['prosDistrict'];
                // if (sortByMunVDC) {

                // if (prosMunicipality.toLowerCase() ==
                //         municipality.toLowerCase() &&
                //     prosDistrict.toLowerCase() == district.toLowerCase()) {
                print(data[index]['location']);
                print('$latitude  $longitude');
                double distance = Location().getDistance(
                  latitude + 0.00006,
                  longitude,
                  data[index]['location']['lat'],
                  data[index]['location']['lng'],
                );
                print(distance);

                if (distance <= distanceRadius) {
                  totalRequests++;
                  return _dispalyContainer(data[index]);
                } else if (index == data.length - 1 && totalRequests == 0)
                  return Center(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: size.height * 0.23,
                          ),
                          child: Text(
                            'Looks like there are no professionals registered around your $distanceRadiusStr radius',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: kBlackColour.withOpacity(0.7),
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                else
                  return Container();
                // } else {
                //   if (prosDistrict.toLowerCase() == district.toLowerCase()) {
                //     totalRequests++;
                //     return _dispalyContainer(data[index]);
                //   } else if (index == data.length - 1 && totalRequests == 0)
                //     return Center(
                //       child: Padding(
                //         padding: EdgeInsets.symmetric(
                //           vertical: size.height * 0.25,
                //         ),
                //         child: Text(
                //           'Look like there are no professionals registered in your district',
                //           textAlign: TextAlign.center,
                //           style: TextStyle(
                //             color: kBlackColour.withOpacity(0.7),
                //             fontSize: 15,
                //           ),
                //         ),
                //       ),
                //     );
                //   else
                //     return Container();
                // }
              } else
                return Container();
            },
          ),
        );
      },
    );
  }

  Widget _dispalyContainer(Map data) {
    double rating = double.parse(data['avgRating'].toString());
    // print(data[index]['avgRating'].runtimeType);
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 15.0,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: kBlackColour,
          style: BorderStyle.solid,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: kBlackColour,
          child: Text('PP'),
        ),
        title: Text(data['prosName']),
        subtitle: Row(
          children: [
            Text('Ratings: '),
            SizedBox(
              width: 10.0,
            ),
            RatingBar.builder(
              itemSize: 15,
              onRatingUpdate: (rating) {},
              ignoreGestures: true,
              initialRating: rating,
              glowColor: Colors.amber,

              glowRadius: 1,
              itemPadding: EdgeInsets.all(1),
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              // itemPadding: EdgeInsets.symmetric(
              //     horizontal: 4.0),
              itemBuilder: (context, index) => Icon(
                EvaIcons.star,
                color: Colors.amber,
              ),
            ),
          ],
        ),
        trailing: TextButton(
          onPressed: () {},
          child: Text('Reviews'),
        ),
        onTap: () {
          Get.defaultDialog(
            title: 'Request Placed!',
            titleStyle: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.w600,
            ),
            barrierDismissible: false,
            middleText: 'Your request has been placed',
            confirm: ElevatedButton(
              onPressed: () async {
                // CircularProgressIndicator();
                await database.totalUsersRequests();
                // Get.back();
                // Get.back();
                newRequestKey = Uuid().v1();

                await database.saveRequest(
                    description: description,
                    proID: data['proID'],
                    dateTime: dateTime,
                    requestKey: newRequestKey,
                    category: category,
                    service: service,
                    municipality: municipality,
                    district: district,
                    date: date,
                    time: time);
                Get.back();
                Get.back();
                print(userRequestCounter);
              },
              child: Text(
                'Ok',
                style: TextStyle(
                  color: kWhiteColour,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
