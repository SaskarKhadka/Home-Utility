import 'package:get/get.dart';
import 'package:home_utility/controllers/requestKeysController.dart';
import 'package:home_utility/main.dart';
import 'package:home_utility/model/requestData.dart';

class RequestDataController extends GetxController {
  List<String> requestKeys;
  // String requestKey;
  RequestDataController(this.requestKeys);
  // Rx<RequestData> requestData = RequestData().obs;

  var requestsData = RxList<Rx<RequestData>>([]);

  RequestData data(int index) => requestsData[index].value;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    for (String requestKey in requestKeys) {
      Rx<RequestData> requestData = RequestData().obs;
      requestData
          .bindStream(database.requestDataStream(requestKey: requestKey));
      requestsData.add(requestData);
    }
  }
}
