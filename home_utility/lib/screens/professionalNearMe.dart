import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_utility/constants.dart';
import 'package:home_utility/main.dart';
import 'package:uuid/uuid.dart';

class ProfessionalsNearMe extends StatefulWidget {
  final DateTime dateTime;
  final String category;
  final String service;
  final DateTime date;
  final TimeOfDay time;
  final String municipality;
  final String district;

  ProfessionalsNearMe({
    this.dateTime,
    this.category,
    this.service,
    this.date,
    this.time,
    this.municipality,
    this.district,
  });

  @override
  _ProfessionalsNearMeState createState() => _ProfessionalsNearMeState();
}

class _ProfessionalsNearMeState extends State<ProfessionalsNearMe> {
  bool sortByMunVDC = true;

  @override
  void initState() {
    // TODO: implement initState
    print(widget.category);
    super.initState();
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
                      // SizedBox(
                      //   height: 15.0,
                      // ),
                      Row(
                        children: [
                          Text(
                            'Sort By:',
                            style: GoogleFonts.montserrat(
                              color: kBlackColour.withOpacity(0.7),
                              fontSize: 15.0,
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(
                                () {
                                  sortByMunVDC = true;
                                },
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 10.0,
                                horizontal: 15.0,
                              ),
                              decoration: BoxDecoration(
                                color: sortByMunVDC
                                    ? kBlackColour
                                    : kBlackColour.withOpacity(0.8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    blurRadius: 15,
                                    offset: Offset(2, 7),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Text(
                                'Municipality/VDC',
                                style: GoogleFonts.montserrat(
                                  color: kWhiteColour,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                sortByMunVDC = false;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 10.0,
                                horizontal: 15.0,
                              ),
                              decoration: BoxDecoration(
                                color: sortByMunVDC
                                    ? kBlackColour.withOpacity(0.8)
                                    : kBlackColour,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    blurRadius: 15,
                                    offset: Offset(2, 7),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Text(
                                'District',
                                style: GoogleFonts.montserrat(
                                  color: kWhiteColour,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      // prosStream(),
                      ProsStream(
                        dateTime: widget.dateTime,
                        category: widget.category,
                        service: widget.service,
                        date: widget.date,
                        time: widget.time,
                        municipality: widget.municipality,
                        district: widget.district,
                        sortByMunVDC: sortByMunVDC,
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
  final String category;
  final String service;
  final DateTime date;
  final TimeOfDay time;
  final String municipality;
  final String district;
  final bool sortByMunVDC;
  ProsStream({
    this.dateTime,
    this.category,
    this.service,
    this.date,
    this.time,
    this.municipality,
    this.district,
    this.sortByMunVDC,
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
              Text('Looking for professionals'),
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
              // print(profession);
              // print(category);
              if (profession != null &&
                  professionToCategory(profession) == category) {
                if (sortByMunVDC) {
                  if (data[index]['prosMunicipality'] == municipality &&
                      data[index]['prosDistrict'] == district) {
                    totalRequests++;
                    return _dispalyContainer(data[index]);
                  } else if (index == data.length - 1 && totalRequests == 0)
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: size.height * 0.25,
                        ),
                        child: Text(
                          'Look like there are no professionals registered in your municipality',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: kBlackColour.withOpacity(0.7),
                            fontSize: 15,
                          ),
                        ),
                      ),
                    );
                  else
                    return Container();
                } else {
                  if (data[index]['prosDistrict'] == district) {
                    totalRequests++;
                    return _dispalyContainer(data[index]);
                  } else if (index == data.length - 1 && totalRequests == 0)
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: size.height * 0.25,
                        ),
                        child: Text(
                          'Look like there are no professionals registered in your district',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: kBlackColour.withOpacity(0.7),
                            fontSize: 15,
                          ),
                        ),
                      ),
                    );
                  else
                    return Container();
                }
              } else
                Container();
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
