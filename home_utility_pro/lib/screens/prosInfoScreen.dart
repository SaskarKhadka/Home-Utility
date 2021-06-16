import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_utility_pro/components/customButton.dart';
import 'package:home_utility_pro/components/customTextField.dart';
import 'package:home_utility_pro/main.dart';
import 'package:home_utility_pro/model/districts.dart';
import 'package:home_utility_pro/model/municipalities.dart';
import 'package:home_utility_pro/model/services.dart';
import 'package:home_utility_pro/model/servicesHandler.dart';
import 'package:home_utility_pro/screens/mainScreen.dart';
import 'package:home_utility_pro/screens/registrationScreen.dart';
import 'package:search_choices/search_choices.dart';

import '../constants.dart';

class ProsInfoScreen extends StatefulWidget {
  static String id = '/prosInfoScreen';
  @override
  _ProsInfoScreenState createState() => _ProsInfoScreenState();
}

class _ProsInfoScreenState extends State<ProsInfoScreen> {
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _proController = TextEditingController();
  final TextEditingController _municipalityController = TextEditingController();
  String _professionValue;

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
  void initState() {
    // TODO: implement initState
    _professionValue = 'Electronics Technician';
    _districtValue = 'Achham';
    _municipalityValue = _municipalities.getMunicipalities(_districtValue)[0];
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _districtController.dispose();
    _municipalityController.dispose();
    _proController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 68,
          elevation: 2,
          shadowColor: Colors.white,
          actions: [
            Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
                left: 20.0,
                right: 15.0,
              ),
            ),
          ],
          title: Padding(
            padding: EdgeInsets.only(
              top: 8.0,
              left: 16.0,
            ),
            child: Text(
              'Fill up your info',
              style: GoogleFonts.montserrat(
                color: Colors.white,
                fontSize: 35,
                fontWeight: FontWeight.w400,
                letterSpacing: 2,
              ),
            ),
          ),
          centerTitle: true,
        ),
        // backgroundColor: kBlackColour,

        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 20.0,
                  horizontal: 20.0,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Text(
                      //   'This is pro\'s info scren',
                      // ),
                      // SizedBox(
                      //   height: size.height * 0.04,
                      // ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 20.0,
                          horizontal: 15.0,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: kBlackColour.withOpacity(0.5),
                            style: BorderStyle.solid,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "Select Your District",
                              textAlign: TextAlign.justify,
                              textDirection: TextDirection.ltr,
                              style: GoogleFonts.montserrat(
                                letterSpacing: 1.2,
                                wordSpacing: 1.5,
                              ),
                            ),
                            SearchChoices.single(
                              style: GoogleFonts.montserrat(
                                color: kBlackColour,
                                fontSize: 15.0,
                              ),
                              items: _getDistricts(),
                              value: _districtValue,
                              hint: "Select Your District",
                              searchHint: "Select Your District",
                              onChanged: (newValue) {
                                setState(() {
                                  _districtValue = newValue;
                                  _municipalityValue = _municipalities
                                      .getMunicipalities(_districtValue)[0];
                                });
                              },
                              isExpanded: true,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),

                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 20.0,
                          horizontal: 15.0,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: kBlackColour.withOpacity(0.5),
                            style: BorderStyle.solid,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "Select Your Municipality",
                              textAlign: TextAlign.justify,
                              textDirection: TextDirection.ltr,
                              style: GoogleFonts.montserrat(
                                letterSpacing: 1.2,
                                wordSpacing: 1.5,
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            SearchChoices.single(
                              style: GoogleFonts.montserrat(
                                color: kBlackColour,
                                fontSize: 15.0,
                              ),
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
                          ],
                        ),
                      ),

                      // CustomTextField(
                      //   textController: _municipalityController,
                      //   isPhoneNumber: false,
                      //   icon: EvaIcons.homeOutline,
                      //   labelText: 'Municipality/VDC',
                      //   hintText: 'Enter your Mulicipality/VDC',
                      // ),
                      // SizedBox(
                      //   height: size.height * 0.04,
                      // ),
                      // CustomTextField(
                      //   textController: _districtController,
                      //   isPhoneNumber: false,
                      //   icon: EvaIcons.compassOutline,
                      //   labelText: 'District',
                      //   hintText: 'Enter your District',
                      // ),

                      // SizedBox(
                      //   height: size.height * 0.04,
                      // ),
                      // CustomTextField(
                      //   textController: _proController,
                      //   isPhoneNumber: false,
                      //   icon: EvaIcons.briefcaseOutline,
                      //   labelText: 'Professional work',
                      //   hintText:
                      //       'Enter Your professional work. (eg. Plumber....)',
                      // ),
                      SizedBox(
                        height: size.height * 0.04,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 20.0,
                          horizontal: 15.0,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: kBlackColour.withOpacity(0.5),
                            style: BorderStyle.solid,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "Select Your Profession",
                              textAlign: TextAlign.justify,
                              textDirection: TextDirection.ltr,
                              style: GoogleFonts.montserrat(
                                letterSpacing: 1.2,
                                wordSpacing: 1.5,
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            SearchChoices.single(
                              style: GoogleFonts.montserrat(
                                color: kBlackColour,
                                fontSize: 15.0,
                              ),
                              items: _getDropDownMenuItems(),
                              value: _professionValue,
                              hint: "Select Your Profession",
                              searchHint: "Select Your Profession",
                              onChanged: (newValue) {
                                setState(() {
                                  _professionValue = newValue;
                                });
                              },
                              isExpanded: true,
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: size.height * 0.05,
                      ),
                      Container(
                        width: 180,
                        height: 60,
                        child: CustomButton(
                          onTap: () async {
                            if (_districtValue.trim() == null) {
                              Get.back();
                              getSnackBar(
                                title: 'ERROR!',
                                message: 'Please enter your district',
                              );
                              return;
                            }
                            if (_municipalityValue.trim() == null) {
                              Get.back();
                              getSnackBar(
                                title: 'ERROR!',
                                message: 'Please enter your municipality',
                              );
                              return;
                            }
                            if (_professionValue.trim() == null) {
                              Get.back();
                              getSnackBar(
                                title: 'ERROR!',
                                message: 'Please enter your municipality',
                              );
                              return;
                            }
                            prosProfessionValue = _professionValue.trim();
                            category =
                                professionToCategory(prosProfessionValue);

                            await database.updateProsInfo(
                              profession: prosProfessionValue,
                              district: _districtController.text.trim(),
                              municipality: _municipalityController.text.trim(),
                            );

                            Get.offAndToNamed(MainScreen.id);
                          },
                          text: 'Submit',
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

  List<DropdownMenuItem<String>> _getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = [];
    List<String> professions = [
      'Electronics Technician',
      'Beautician',
      'House Worker',
    ];

    for (String profession in professions) {
      items.add(
        DropdownMenuItem<String>(
          child: Text(profession),
          value: profession,
        ),
      );
    }
    return items;
  }
}
