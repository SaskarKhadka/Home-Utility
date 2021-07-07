import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
// import 'package:home_utility/controllers/requestKeysController.dart';
import 'package:home_utility/main.dart';
import 'package:home_utility/model/requestData.dart';

class RequestsDataController extends GetxController {
  final reviewController = TextEditingController();
  var requestsData = RxMap<String, RequestData>({});

  Map<String, RequestData> get data => requestsData;

  // List<String> get requestKeys => _requestKeys;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    requestsData.bindStream(database.userRequestsStream());
  }

  @override
  void onClose() {
    // TODO: implement onClose
    reviewController.dispose();
    super.onClose();
  }
}
