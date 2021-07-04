import 'package:get/get.dart';

class RequestStatus {
  RxBool _isAccepted = RxBool(false);
  RxBool _isRatingPending = RxBool(false);

  void setIsAccepted(bool value) => _isAccepted.value = value;
  void setIsRequestPending(bool value) => _isRatingPending.value = value;

  bool getIsAccepted() => _isAccepted.value;
  bool getIsRatingPending() => _isRatingPending.value;

  // RequestStatus({this.isAccepted = false, this.isRatingPending = false});
}
