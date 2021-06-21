import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';


class RatingCard extends StatelessWidget {
  final String username;
  final String address;
  final String profession;
  final double rating;

  const RatingCard(this.username, this.address, this.profession, this.rating);

  @override
  Widget build(BuildContext context) {
     double screenWidth = MediaQuery.of(context).size.width;
  //    double screenHeight = MediaQuery.of(context).size.height;
   Size size= MediaQuery.of(context).size;
    return    Container(
      width: screenWidth,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25))
      ),
     child: Padding(
       padding: const EdgeInsets.all(16.0),
       child: Column(
         children: [
           Row(
             
             children:<Widget> [
              SizedBox(width: 10),
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                        shape: BoxShape.circle,
                          color: Color(0xff27272A),
                        
                      boxShadow: [
                                BoxShadow(
                                  color: Color(0xff27272A).withOpacity(0.3),
                                  spreadRadius: 3,
                                  blurRadius: 10,
                                  offset: Offset(2, 4), // changes position of shadow
                                ),]
                    ),
              child: Image.asset('images/user.png'),
              
            ),
            SizedBox(width: 50),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                  Text(username,style: GoogleFonts.montserrat(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold)),
                  SizedBox(height: 5),
                  Text(address,style: GoogleFonts.roboto(fontSize: 16,color: Colors.white70)),
                  SizedBox(height: 6),
                  RatingStars(
                    value: rating,
                    starCount: 5 ,
                    starSize: 15,
                    starColor: Color(0xffF3CF31),
                    starSpacing: 2,
                    starOffColor: const Color(0xffe7e8ea),
                    
                    valueLabelColor: Colors.red ,
                    
                  ),
                  SizedBox(height: 10),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: (){},
                                              child: Container(
                                    
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Color(0xff1A1A1A),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Container(
                              child: Row(children: [
                                Icon(Icons.person,size: 20,color: Colors.white60,),
                                Text('See Profile',style: TextStyle(color: Colors.white60,fontSize: 16))

                              ],),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(width: 20),

                      GestureDetector(
                        onTap: (){},
                                              child: Container(         
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color(0xff1A1A1A),
                    ),
                    child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Container(
                          child: Row(children: [
                            Icon(Icons.phone,size: 20,color: Colors.white60,),
                            Text('Contact',style: TextStyle(color: Colors.white60,fontSize: 16),)

                          ],),
                        ),
                    ),
                  ),
                      )
                    ],
                  ),
                  SizedBox(height: 8),
                  
              
              ]
            ),
           ],),
          SizedBox(height: 10),
          GestureDetector(
                child: Container(
                  width: screenWidth*0.8,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                          ),
                  child: Center(
                    child: Text(
                      'SEND REQUEST FOR WORK ',
                      style: GoogleFonts.roboto(fontSize: 15.0,fontWeight: FontWeight.bold)
                    ),
                  ),
                ),
              
               onTap: (){},
              ), 
              SizedBox(height: 8),
         ],
       ),
     ),
    );
  }
}