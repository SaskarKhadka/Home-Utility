import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void onClose() {
    super.onClose();
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
  }
}
