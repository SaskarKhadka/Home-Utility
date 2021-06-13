import 'dart:collection';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_utility_pro/components/customButton.dart';
import 'package:home_utility_pro/components/customTextField.dart';
import 'package:home_utility_pro/main.dart';
import 'package:home_utility_pro/model/services.dart';
import 'package:home_utility_pro/model/servicesHandler.dart';
import 'package:home_utility_pro/screens/mainScreen.dart';
import 'package:home_utility_pro/screens/registrationScreen.dart';

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
  // ServiceHandler _serviceHandler = ServiceHandler();
  String value;

  @override
  void initState() {
    // TODO: implement initState
    value = 'Electronics Technician';
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
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Text(
                      //   'This is pro\'s info scren',
                      // ),
                      SizedBox(
                        height: size.height * 0.04,
                      ),
                      CustomTextField(
                        textController: _municipalityController,
                        isPhoneNumber: false,
                        icon: EvaIcons.homeOutline,
                        labelText: 'Municipality/VDC',
                        hintText: 'Enter your Mulicipality/VDC',
                      ),
                      SizedBox(
                        height: size.height * 0.04,
                      ),
                      CustomTextField(
                        textController: _districtController,
                        isPhoneNumber: false,
                        icon: EvaIcons.compassOutline,
                        labelText: 'District',
                        hintText: 'Enter your District',
                      ),

                      SizedBox(
                        height: size.height * 0.04,
                      ),
                      CustomTextField(
                        textController: _proController,
                        isPhoneNumber: false,
                        icon: EvaIcons.briefcaseOutline,
                        labelText: 'Professional work',
                        hintText:
                            'Enter Your professional work. (eg. Plumber....)',
                      ),
                      SizedBox(
                        height: size.height * 0.04,
                      ),
                      Text(
                        "Choose your Profession category",
                        textAlign: TextAlign.justify,
                        textDirection: TextDirection.ltr,
                        style: GoogleFonts.montserrat(
                          letterSpacing: 2.8,
                          wordSpacing: 2.8,
                        ),
                      ),
                      DropdownButton<String>(
                        style: GoogleFonts.robotoMono(
                          color: kBlackColour,
                        ),
                        elevation: 20,
                        // focusColor: kBlackColour,
                        items: _getDropDownMenuItems(),
                        value: value,
                        onChanged: (newvalue) {
                          setState(() {
                            value = newvalue;
                          });
                        },
                        // dropdownColor: Colors.black,
                      ),
                      SizedBox(
                        height: size.height * 0.05,
                      ),
                      Container(
                        width: 180,
                        height: 60,
                        child: CustomButton(
                          onTap: () async {
                            prosProfessionValue = value.trim();
                            category =
                                professionToCategory(prosProfessionValue);

                            await database.updateProsInfo(
                              profession: prosProfessionValue,
                              district: _districtController.text.trim(),
                              municipality: _municipalityController.text.trim(),
                            );

                            if (_proController.text.isEmpty) {
                              Get.back();
                              getSnackBar(
                                title: 'ERROR!',
                                message: 'Please enter your Province',
                              );
                              return;
                            }
                            if (_districtController.text.isEmpty) {
                              Get.back();
                              getSnackBar(
                                title: 'ERROR!',
                                message: 'Please enter your district',
                              );
                              return;
                            }
                            if (_municipalityController.text.isEmpty) {
                              Get.back();
                              getSnackBar(
                                title: 'ERROR!',
                                message: 'Please enter your municipality',
                              );
                              return;
                            } else {
                              Get.offAndToNamed(MainScreen.id);
                            }
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
