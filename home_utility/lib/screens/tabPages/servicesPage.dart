import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_utility/components/detailsDialog.dart';
import 'package:home_utility/constants.dart';
import '../../main.dart';
import '../../model/servicesHandler.dart';

class ServicesPage extends StatefulWidget {
  @override
  _ServicesPageState createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  final ServiceHandler serviceHandler = ServiceHandler();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    print(requestKeysForThisSession);

    requestKeysForThisSession.clear();

    usersRefrence
        .child(userAuthentication.userID)
        .child('requests')
        .once()
        .then((value) {
      if (value.value != null) {
        Map.from(value.value).forEach((key, value) {
          requestKeysForThisSession.add(key);
        });
      }
    });

    print(requestKeysForThisSession);
    database.totalUsersRequests();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Color(0xff131313),
        body: Container(
          width: double.infinity,
          height: size.height * 10,
          decoration: BoxDecoration(
              // color: Color(0xff131313),
              ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  color: Color(0xff131313),
                  padding: EdgeInsets.only(
                    left: 30.0,
                    right: 15.0,
                    top: 8.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Container(
                      //   height: 50,
                      //   width: 50,
                      //   decoration: BoxDecoration(
                      //     shape: BoxShape.circle,
                      //     color: Colors.white,
                      //   ),
                      //   child: Icon(
                      //     Icons.menu,
                      //     color: Color(0xff131313),
                      //     size: 30,
                      //   ),
                      // ),
                      // SizedBox(
                      //   width: size.width * 0.08,
                      // ),
                      Text(
                        'Our Services',
                        style: GoogleFonts.montserrat(
                          // color: Color(0xff131313),
                          color: Colors.white,
                          fontSize: 37,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 2,
                          // decoration: TextDecoration.underline,
                        ),
                      ),
                      // Container(
                      //   height: 45,
                      //   width: 45,
                      //   margin: EdgeInsets.only(right: 10.0),
                      //   decoration: BoxDecoration(
                      //     shape: BoxShape.circle,
                      //     color: Color(0xff131313),
                      //   ),
                      //   child:
                      Icon(
                        Icons.more_vert,
                        // color: Color(0xff131313),
                        color: Colors.white,
                        size: 30,
                      ),
                      // ),
                    ],
                  ),
                ),
              ),
              Divider(
                height: 1,
              ),
              Expanded(
                flex: 17,
                child: Scrollbar(
                  controller: _scrollController,
                  child: Container(
                    color: Color(0xff131313),
                    padding: EdgeInsets.only(
                        // left: 30.0,
                        ),
                    child: ListView.builder(
                      controller: _scrollController,
                      shrinkWrap: true,
                      itemCount: serviceHandler.totalServicesCount(),
                      itemBuilder: (context, index) {
                        var imgPath =
                            serviceHandler.getServices()[index].getImagePath();
                        var service =
                            serviceHandler.getServices()[index].getService();
                        return Container(
                          height: 170,
                          width: double.infinity,
                          margin: EdgeInsets.only(
                            top: 20.0,
                            bottom: 20.0,
                            right: 25.0,
                            left: 30.0,
                            // horizontal: 25.0,
                          ),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white30,
                                offset: Offset(2, 5),
                                blurRadius: 10,
                              ),
                            ],
                            color: Color(0xff131313),
                            borderRadius: BorderRadius.circular(30.0),
                            border: Border.all(
                              color: Colors.white,
                              width: 1.5,
                              style: BorderStyle.solid,
                            ),
                          ),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                      backgroundColor: kBlackColour,
                                      barrierColor:
                                          kBlackColour.withOpacity(0.6),
                                      isDismissible: true,
                                      enableDrag: true,
                                      isScrollControlled: true,
                                      context: context,
                                      builder: (context) => DetailsDialog(
                                            service: service,
                                          ));
                                  // showDialog(
                                  //   context: context,
                                  //   builder: (context) => DetailsDialog(
                                  //     service: service,
                                  //   ),
                                  // );
                                },
                                // onTap: () => Get.toNamed(
                                //   DetailsScreen.id,
                                //   parameters: {
                                //     'imgPath': imgPath,
                                //     'service': service,
                                //   },
                                // ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30.0),
                                    bottomLeft: Radius.circular(30.0),
                                  ),
                                  child: AspectRatio(
                                    aspectRatio: 1.05,
                                    child: Image.asset(
                                      imgPath,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: Text(
                                        service,
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.mateSc(
                                            color: Colors.white,
                                            fontSize: 24.0,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Center(
                                      child: Text(
                                        'Ratings',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 15.0,
                                          color: Colors.white60,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: Colors.yellow,
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: Colors.yellow,
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: Colors.yellow,
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: Colors.yellow,
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: Colors.yellow,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
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
