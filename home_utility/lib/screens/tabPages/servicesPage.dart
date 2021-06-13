import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_utility/components/detailsDialog.dart';
import 'package:home_utility/constants.dart';
import '../../main.dart';

class ServicesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff131313),
        appBar: AppBar(
          toolbarHeight: 67,
          elevation: 2,
          shadowColor: Colors.white,
          actions: [
            Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
                left: 20.0,
                right: 15.0,
              ),
              child: Icon(
                Icons.more_vert,
                // color: Color(0xff131313),
                color: Colors.white,
                size: 30,
              ),
            ),
          ],
          title: Padding(
            padding: EdgeInsets.only(
              top: 8.0,
              left: 16.0,
            ),
            child: Text(
              'Our Services',
              style: GoogleFonts.montserrat(
                // color: Color(0xff131313),
                color: Colors.white,
                fontSize: 35,
                fontWeight: FontWeight.w400,
                letterSpacing: 1.5,
                // decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          // controller: _scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  'Repair',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              ServicesStream(
                category: 'repair',
                // scrollController: _scrollController,
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                'Beauty',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              ServicesStream(
                category: 'beauty',
                // scrollController: _scrollController,
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                'House Work',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              ServicesStream(
                category: 'householdChores',
                // scrollController: _scrollController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ServicesStream extends StatelessWidget {
  final String category;
  // final ScrollController scrollController;
  // ServicesStream({this.category, this.scrollController});
  ServicesStream({this.category});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
        Map messages = snapshot.data.snapshot.value;
        // ref.update(messages);
        // print(snapshot.data.snapshot.value);
        // print(messages);
        if (messages != null) {
          List<Map> data = [];
          messages.forEach((key, value) {
            data.add(value as Map);
          });

          // for(Map data in data) {
          //   ref.child(path)
          // }
          return Container(
            height: 330, //TODO: manage
            child: ListView.builder(
              // controller: scrollController,
              shrinkWrap: true,
              itemCount: data.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                  // height: 170,
                  width: 250,
                  margin: EdgeInsets.only(
                    top: 10.0,
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
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(
                            DetailsPage(
                              service: data[index]['service'],
                              category: category,
                            ),
                          );
                          // showModalBottomSheet(
                          //     backgroundColor: kBlackColour,
                          //     barrierColor: kBlackColour.withOpacity(0.6),
                          //     isDismissible: true,
                          //     enableDrag: true,
                          //     isScrollControlled: true,
                          //     context: context,
                          //     builder: (context) => DetailsDialog(
                          //           service: data[index]['service'],
                          //           category: category,
                          //         ));
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
                            // bottomLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0),
                          ),
                          child: AspectRatio(
                            aspectRatio: 1.5,
                            child: Image.network(
                              data[index]['imgUrl'],
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Text(
                          data[index]['service'],
                          textAlign: TextAlign.center,
                          style: GoogleFonts.mateSc(
                              color: Colors.white,
                              fontSize: 20.0,
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
                        mainAxisAlignment: MainAxisAlignment.center,
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
                      SizedBox(
                        height: size.height * 0.008,
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        }

        return Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.lightBlue,
          ),
        );
      },
    );
  }
}

// Container(
//                     color: Color(0xff131313),
//                     padding: EdgeInsets.only(
//                         // left: 30.0,
//                         ),
//                     child: ListView.builder(
//                       controller: _scrollController,
//                       shrinkWrap: true,
//                       itemCount: serviceHandler.totalServicesCount(),
//                       itemBuilder: (context, index) {
//                         var imgPath =
//                             serviceHandler.getServices()[index].getImagePath();
//                         var service =
//                             serviceHandler.getServices()[index].getService();
// return Container(
//   height: 170,
//   width: double.infinity,
//   margin: EdgeInsets.only(
//     top: 20.0,
//     bottom: 20.0,
//     right: 25.0,
//     left: 30.0,
//     // horizontal: 25.0,
//   ),
//   decoration: BoxDecoration(
//     boxShadow: [
//       BoxShadow(
//         color: Colors.white30,
//         offset: Offset(2, 5),
//         blurRadius: 10,
//       ),
//     ],
//     color: Color(0xff131313),
//     borderRadius: BorderRadius.circular(30.0),
//     border: Border.all(
//       color: Colors.white,
//       width: 1.5,
//       style: BorderStyle.solid,
//     ),
//   ),
//   child: Row(
//     children: [
//       GestureDetector(
//         onTap: () {
//           showModalBottomSheet(
//               backgroundColor: kBlackColour,
//               barrierColor:
//                   kBlackColour.withOpacity(0.6),
//               isDismissible: true,
//               enableDrag: true,
//               isScrollControlled: true,
//               context: context,
//               builder: (context) => DetailsDialog(
//                     service: service,
//                   ));
//           // showDialog(
//           //   context: context,
//           //   builder: (context) => DetailsDialog(
//           //     service: service,
//           //   ),
//           // );
//         },
//         // onTap: () => Get.toNamed(
//         //   DetailsScreen.id,
//         //   parameters: {
//         //     'imgPath': imgPath,
//         //     'service': service,
//         //   },
//         // ),
//         child: ClipRRect(
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(30.0),
//             bottomLeft: Radius.circular(30.0),
//           ),
//           child: AspectRatio(
//             aspectRatio: 1.05,
//             child: Image.asset(
//               imgPath,
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),
//       ),
//       Expanded(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Center(
//               child: Text(
//                 service,
//                 textAlign: TextAlign.center,
//                 style: GoogleFonts.mateSc(
//                     color: Colors.white,
//                     fontSize: 24.0,
//                     fontWeight: FontWeight.w500),
//               ),
//             ),
//             SizedBox(
//               height: 10.0,
//             ),
//             Center(
//               child: Text(
//                 'Ratings',
//                 style: GoogleFonts.montserrat(
//                   fontSize: 15.0,
//                   color: Colors.white60,
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 5.0,
//             ),
//             Row(
//               mainAxisAlignment:
//                   MainAxisAlignment.center,
//               children: [
//                 Icon(
//                   Icons.star,
//                   color: Colors.yellow,
//                 ),
//                 Icon(
//                   Icons.star,
//                   color: Colors.yellow,
//                 ),
//                 Icon(
//                   Icons.star,
//                   color: Colors.yellow,
//                 ),
//                 Icon(
//                   Icons.star,
//                   color: Colors.yellow,
//                 ),
//                 Icon(
//                   Icons.star,
//                   color: Colors.yellow,
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     ],
//   ),
// );
//                       },
//                     ),
//                   ),
