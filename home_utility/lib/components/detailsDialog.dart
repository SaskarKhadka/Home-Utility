import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_utility/screens/googleMapsScreen.dart';
import 'package:home_utility/location/userLocation.dart';
import '../constants.dart';
import '../main.dart';
import 'customButton.dart';

class DetailsPage extends StatefulWidget {
  static const id = '/detailsPage';
  final String service;
  final String category;
  DetailsPage({this.service, this.category});

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final _descriptionController = TextEditingController();
  DateTime _pickedDate;
  TimeOfDay _selectedTime;

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    print(widget.category);
    _pickedDate = DateTime.now();
    _selectedTime = TimeOfDay.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        // backgroundColor: kBlackColour,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              left: 20.0,
              right: 20.0,
              top: 15.0,
              bottom: 25.0,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.service,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.bebasNeue(
                    fontSize: 30.0,
                    fontWeight: FontWeight.w500,
                    color: kBlackColour,
                    letterSpacing: 2,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Text(
                  'When would you like us to come?',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.cairo(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w700,
                    color: kBlackColour.withOpacity(0.5),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.004,
                ),
                ListTile(
                  // tileColor: Colors.blue,
                  title: Text(
                    "Date: ${_pickedDate.year}/${_pickedDate.month}/${_pickedDate.day}",
                    style: GoogleFonts.juliusSansOne(
                      fontSize: 17.0,
                      letterSpacing: 1.3,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  trailing: Icon(Icons.keyboard_arrow_down),
                  onTap: _pickDate,
                ),
                ListTile(
                  minVerticalPadding: 5,
                  // tileColor: Colors.red,
                  title: Text(
                    "Time: ${formatTime(unformattedTime: _selectedTime)}",
                    style: GoogleFonts.juliusSansOne(
                      fontSize: 17.0,
                      letterSpacing: 1.3,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  trailing: Icon(Icons.keyboard_arrow_down),
                  onTap: _selectTime,
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Text(
                  'Any information about the job?',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.cairo(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w700,
                    color: kBlackColour.withOpacity(0.5),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        blurRadius: 10,
                        offset: Offset(2, 7),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _descriptionController,
                    maxLines: 3,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      fillColor: kWhiteColour,
                      filled: true,
                      hintText: 'Write information about the work (optional)',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(
                          color: kBlackColour,
                          style: BorderStyle.solid,
                          width: 1.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(
                          color: kBlackColour,
                          style: BorderStyle.solid,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.04,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomButton(
                      // color: Colors.white,
                      text: 'Confirm',
                      // onTap: _getDialog,

                      onTap: () async {
                        Position userLocation = await Location().getLocation();

                        DataSnapshot snapshot = await usersRefrence
                            .child(userAuthentication.userID)
                            .child('location')
                            .once();
                        Map userLocation2 = snapshot.value;
                        print(userLocation2);
                        // userLocation['lat'] = snapshot.value['lat'];
                        // userLocation['lng'] = snapshot.value['lng'];

                        print(widget.category);
                        Get.to(
                          GoogleMapScreen(
                            dateTime: DateTime(
                              _pickedDate.year,
                              _pickedDate.month,
                              _pickedDate.day,
                              _selectedTime.hour,
                              _selectedTime.minute,
                            ),
                            description: _descriptionController.text.trim(),
                            // requestKey: newRequestKey,
                            category: widget.category,
                            service: widget.service,
                            date: _pickedDate,
                            time: _selectedTime,
                            latitude: userLocation.latitude,
                            longitude: userLocation.longitude,
                            userLocation2: userLocation2,
                          ),
                        );
                      },
                      // color: Colors.red,
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    CustomButton(
                      // color: Colors.white,
                      text: 'Cancel',
                      onTap: () => Get.back(),
                      // color: Colors.red,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _pickDate() async {
    DateTime date = await showDatePicker(
      context: context,
      initialDate: _pickedDate,
      firstDate: DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
      ),
      lastDate: DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day + 29,
      ),
      // lastDate: DateTime(DateTime.now().month + 5),
    );
    if (date != null)
      setState(() {
        _pickedDate = date;
      });
  }

  _selectTime() async {
    final TimeOfDay pickedTime = await showTimePicker(
        context: context,
        initialTime: _selectedTime,
        builder: (BuildContext context, Widget child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child,
          );
        });

    if (pickedTime != null && pickedTime != _selectedTime)
      setState(() {
        _selectedTime = pickedTime;
      });
  }
}
