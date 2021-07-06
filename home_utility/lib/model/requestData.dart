class RequestData {
  String category;
  String date;
  String dateTime;
  String requestKey;
  String requestedTo;
  String requestedBy;
  String service;
  String time;
  String state;
  String jobDescription;
  bool isAccepted = false;
  bool isRatingPending = false;
  RequestData();

  RequestData.fromData(Map requestData) {
    print(requestData['requestKey']);
    category = requestData['category'];
    date = requestData['date'];
    dateTime = requestData['dateTime'];
    requestKey = requestData['requestKey'];
    requestedTo = requestData['requestedTo']['proID'];
    requestedBy = requestData['requestedBy']['userID'];
    service = requestData['service'];
    time = requestData['time'];
    state = requestData['state'];
    jobDescription = requestData['jobDescription'];
    isAccepted = requestData['isAccepted'];
    isRatingPending = requestData['isRatingPending'];
  }
}
