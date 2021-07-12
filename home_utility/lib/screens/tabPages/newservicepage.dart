import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:get/get.dart';
import 'package:home_utility/components/detailsDialog.dart';
import '../../constants.dart';
import '../../main.dart';
import 'package:google_fonts/google_fonts.dart';
//0xffd17842

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{
  // TabController tabController;
  // int _selectedIndex = 0;

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }

  @override
  void initState() {
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Container(
             width: MediaQuery.of(context).size.width,
                height : double.infinity ,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0,right: 15, top: 15, bottom: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Color(0xff1b2027),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              Icons.menu,
                              color: Color(0xff4d4f52),
                            )),
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
                onSelected: (item) => {},
                offset: Offset(0, 70),
              ),)
                        
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Find the best\nservice for you",
                      style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 30,
                          ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 6.0),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Color(0xff141921),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: "Find your service...",
                            hintStyle: TextStyle(color: Color(0xff3c4046)),
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.grey[600],
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text("Repair Devices",style: GoogleFonts.montserrat(color: Color(0xffd17842),fontSize: 20),),
                    Divider(color: Color(0xffd17842),endIndent: 300,indent: 30,thickness: 1,),
                    ServiceCard(category: 'repair'),
                    SizedBox(height: 10,),
                     Text("House Work",style: GoogleFonts.montserrat(color: Color(0xffd17842),fontSize: 20),),
                     Divider(color: Color(0xffd17842),endIndent: 300,indent: 30,thickness: 1,),
                      ServiceCard(category: 'householdChores',),
                       SizedBox(height: 10,),
                      Text("Beauty",style: GoogleFonts.montserrat(color: Color(0xffd17842),fontSize: 20),),
                     Divider(color: Color(0xffd17842),endIndent: 330,indent: 10,thickness: 1,),
                      ServiceCard(category: 'beauty',),
                  ],
                ),
              ),
            ),
          )),
    
    );
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
        // ref.update(messages);
        // print(snapshot.data.snapshot.value);
        // print(messages);
        if (services != null) {
          List<Map> data = [];
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
                    onTap: (){
                      //  Get.to(
                      //       DetailsPage(
                      //         service: data[index]['service'],
                      //         category: category,
                      //       ));
                                                showModalBottomSheet(
                              elevation: 4.0,
                              barrierColor: kBlackColour.withOpacity(0.6),
                              isDismissible: true,
                              enableDrag: true,
                              isScrollControlled: true,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(26.0),
                                  topRight: Radius.circular(26.0),
                                ),
                              ),
                              // backgroundColor: Color(0xFF0E0E0F),
                              backgroundColor: Color(0xFFFDFDFF),
                              context: context,
                              builder: (context) => DetailsPage(
                                    service: data[index]['service'],
                                    category: category,
                                  ));
                    },
                    child: Container(
                      height: 230,
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
                                    image: NetworkImage(data[index]['imgUrl']),
                                    fit: BoxFit.cover)),
                          ),
                          Padding(
                            padding: EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data[index]['service'],
                                  style: TextStyle(color: Colors.white),
                                ),
                               
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    RatingStars(
                                          value: 4,
                                          starCount: 5,
                                          starSize: 12,
                                          starColor: Color(0xffd17842),
                                          starSpacing: 2,
                                          starOffColor: const Color(0xffe7e8ea),
                                          valueLabelColor: Colors.red,
                                          valueLabelVisibility: false,
                                        ),
                                    Container(
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(
                                            color: Color(0xffd17842),
                                            borderRadius:
                                                BorderRadius.circular(10)),
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
      );}
      return Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.lightBlue,
          ),
        );
      }
    );
  }
}
