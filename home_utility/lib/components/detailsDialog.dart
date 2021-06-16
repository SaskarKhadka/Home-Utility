import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_utility/location/userLocation.dart';
import 'package:home_utility/model/districts.dart';
import 'package:home_utility/model/municipalities.dart';
import 'package:home_utility/screens/professionalNearMe.dart';
import 'package:home_utility/screens/registrationScreen.dart';
import 'package:search_choices/search_choices.dart';
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
  final _municipalityController = TextEditingController();
  final _districtController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime _pickedDate;
  TimeOfDay _selectedTime;
  String _districtValue;
  String _municipalityValue;

  Municipalities _municipalities = Municipalities();
  Districts _districts = Districts();

  List<DropdownMenuItem<String>> _getDistricts() {
    List<DropdownMenuItem<String>> items = [];

    List<String> districts = _districts.getDistricts();
    // _districtValue = districts[0];

    for (String district in districts) {
      items.add(
        DropdownMenuItem<String>(
          child: Text(district),
          value: district,
        ),
      );
    }
    return items;
  }

  List<DropdownMenuItem<String>> _getMunicipalities() {
    List<DropdownMenuItem<String>> items = [];

    List<String> municipalities =
        _municipalities.getMunicipalities(_districtValue);
    // _municipalityValue = municipalities[0];

    for (String municipality in municipalities) {
      items.add(
        DropdownMenuItem<String>(
          child: Text(municipality),
          value: municipality,
        ),
      );
    }
    return items;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _municipalityController.dispose();
    _districtController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    print(widget.category);
    _districtValue = 'Achham';
    _municipalityValue = _municipalities.getMunicipalities(_districtValue)[0];
    _pickedDate = DateTime.now();
    TimeOfDay now = TimeOfDay.now();
    _selectedTime = now.replacing(hour: now.hour, minute: now.minute + 2);
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
                  height: size.height * 0.005,
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
                  height: size.height * 0.02,
                ),
                SearchChoices.single(
                  items: _getDistricts(),
                  value: _districtValue,
                  hint: "Select Your District",
                  searchHint: "Select Your District",
                  onChanged: (newValue) {
                    setState(() {
                      _districtValue = newValue;
                      _municipalityValue =
                          _municipalities.getMunicipalities(_districtValue)[0];
                    });
                  },
                  isExpanded: true,
                ),
                SearchChoices.single(
                  items: _getMunicipalities(),
                  value: _municipalityValue,
                  hint: "Select Your Municiplality",
                  searchHint: "Select Your Municipality",
                  onChanged: (newValue) {
                    setState(() {
                      _municipalityValue = newValue;
                    });
                  },
                  isExpanded: true,
                ),
                SizedBox(
                  height: size.height * 0.01,
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
                      hintText: 'Write something about the job',
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
                        if (_districtValue.trim() == null)
                          getSnackBar(
                              title: 'ERROR!',
                              message: 'Please select your district');

                        if (_municipalityValue.trim() == null)
                          getSnackBar(
                              title: 'ERROR!',
                              message: 'Please select your municipality');

                        Position userLocation = await Location().getLocation();

                        print(widget.category);
                        Get.to(
                          ProfessionalsNearMe(
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
                            municipality: _municipalityValue,
                            district: _districtValue,
                            date: _pickedDate,
                            time: _selectedTime,
                            latitude: userLocation.latitude,
                            longitude: userLocation.longitude,
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

  // void _getDialog() {
  //   Get.defaultDialog(
  //     title: 'Request Placed!',
  //     titleStyle: TextStyle(
  //       fontSize: 25.0,
  //       fontWeight: FontWeight.w600,
  //     ),
  //     barrierDismissible: false,
  //     middleText: 'Your request has been placed',
  //     confirm: ElevatedButton(
  //       onPressed: () async {
  //         // CircularProgressIndicator();
  //         await database.totalUsersRequests();
  //         // Get.back();
  //         // Get.back();
  //         newRequestKey = Uuid().v1();

  //         await database.saveRequest(
  //             dateTime: DateTime(
  //               _pickedDate.year,
  //               _pickedDate.month,
  //               _pickedDate.day,
  //               _selectedTime.hour,
  //               _selectedTime.minute,
  //             ),
  //             requestKey: newRequestKey,
  //             category: widget.category,
  //             service: widget.service,
  //             municipality: _municipalityController.text.trim(),
  //             district: _districtController.text.trim(),
  //             date: _pickedDate,
  //             time: _selectedTime);
  //         Get.back();
  //         Get.back();
  //         print(userRequestCounter);
  //       },
  //       child: Text(
  //         'Ok',
  //         style: TextStyle(
  //           color: kWhiteColour,
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
