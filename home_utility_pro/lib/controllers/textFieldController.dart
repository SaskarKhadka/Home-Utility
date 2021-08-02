import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextFieldController extends GetxController {
  var _eyeIcon = Icons.visibility_off.obs;
  var _focusColour = Color(0xffaaabac).obs;
  var _isObscureText = true.obs;

  IconData get eyeIcon => _eyeIcon.value;
  Color get focusColour => _focusColour.value;
  bool get isObscureText => _isObscureText.value;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void changeEyeIcon(IconData iconData) {
    _eyeIcon.value = iconData;
    // update();
  }

  void changeFocusColour(Color colour) {
    _focusColour.value = colour;
    // update();
  }

  void changeObscurity(bool state) {
    _isObscureText.value = state;
    // update();
  }
}
