import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ColourController extends GetxController {
  var colour = Rx<Color>(Colors.white54);

  Color get color => colour.value;

  changeColour(Color newColour) {
    colour.value = newColour;
  }
}
