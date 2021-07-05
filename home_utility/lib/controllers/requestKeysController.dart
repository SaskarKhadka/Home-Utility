import 'package:get/get.dart';
import 'package:home_utility/main.dart';

//TODO: Wrap this and data controller in same

class RequestKeysController extends GetxController {
  RxList<String> userRequests = RxList<String>([]);

  List<String> get requests => userRequests;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    userRequests.bindStream(database.userRequestsStream());
  }
}
