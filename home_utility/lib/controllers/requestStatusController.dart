import 'package:get/get.dart';
import 'package:home_utility/model/requestStatus.dart';

class RequestStatusController extends GetxController {
  var isAccepted = false;
  var isRatingPending = false;

  void changeAcceptedStatus(bool status) {
    isAccepted = status;
    update();
  }

  void changeRatingStatus(bool status) {
    isRatingPending = status;
    update();
  }
}
