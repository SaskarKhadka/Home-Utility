import 'package:get/get.dart';
import 'package:home_utility/model/requestStatus.dart';

class RequestStatusController extends GetxController {
  var requestStatus = RequestStatus();

  void changeAcceptedStatus(bool status) {
    requestStatus.setIsAccepted(status);
    update();
  }

  void changeRatingStatus(bool status) {
    requestStatus.setIsRequestPending(status);
    update();
  }
}
