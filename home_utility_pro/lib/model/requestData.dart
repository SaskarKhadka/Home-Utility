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
  bool isAccepted;
  bool isRatingPending;
  RequestData();

  RequestData.fromData(Map requestData) {
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

  Map<String, dynamic> get map {
    Map<String, dynamic> requestData = {};
    requestData['category'] = category;
    requestData['date'] = date;
    requestData['dateTime'] = dateTime;
    requestData['requestKey'] = requestKey;
    requestData['requestedTo'] = {'proID': requestedTo};
    requestData['requestedBy'] = {'userID': requestedBy};
    requestData['service'] = service;
    requestData['time'] = time;
    requestData['state'] = state;
    requestData['jobDescription'] = jobDescription;
    requestData['isAccepted'] = isAccepted;
    requestData['isRatingPending'] = isRatingPending;
    return requestData;
  }
}
