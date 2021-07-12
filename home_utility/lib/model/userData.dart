class UserData {
  String userName;
  String userID;
  String userEmail;
  int userPhoneNo;
  String profileUrl;
  String password;

  UserData.fromData(Map userData) {
    userName = userData['userName'];
    userID = userData['userID'];
    userPhoneNo = userData['userPhoneNo'];
    userEmail = userData['userEmail'];
    profileUrl = userData['profileUrl'];
  }
}
