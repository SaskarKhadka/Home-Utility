import 'package:get/get.dart';
// import 'package:home_utility/controllers/requestKeysController.dart';
import 'package:home_utility_pro/main.dart';
import 'package:home_utility_pro/model/requestData.dart';

class AcceptedRequestsController extends GetxController {
  var requestsData = RxMap<String, RequestData>({});

  Map<String, RequestData> get data => requestsData;

  // List<String> get requestKeys => _requestKeys;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    requestsData.bindStream(database.jobDataStream());
  }
}
