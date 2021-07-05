import 'package:get/get.dart';

class RequestStatus {
  bool _isAccepted;
  bool _isRatingPending;

  RequestStatus(this._isAccepted, this._isRatingPending);

  void setIsAccepted(bool value) => _isAccepted = value;
  void setIsRequestPending(bool value) => _isRatingPending = value;

  bool getIsAccepted() => _isAccepted;
  bool getIsRatingPending() => _isRatingPending;

  // RequestStatus({this.isAccepted = false, this.isRatingPending = false});
}
