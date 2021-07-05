class RequestData {
//   category:
// "repair"
// date:
// "2021/6/18"
// dateTime:
// "2021-06-18 16:58:00.000"
// jobDescription:
// ""
// requestKey:
// "066d0b90-cffc-11eb-939d-59c0a6e2723b"
// requestedBy
// requestedTo
// service:
// "Washing Machine Repair"
// state:
// "accepted"
// time:
// "04:58 pm"

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
