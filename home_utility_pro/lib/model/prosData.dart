class ProsData {
  String prosName;
  String proID;
  String prosEmail;
  int prosPhoneNo;
  String prosMunicipality;
  String prosDistrict;
  String profession;
  Map location;
  double avgRating;
  Map review;

  ProsData.fromData(Map prosData) {
    prosName = prosData['prosName'];
    proID = prosData['proID'];
    prosPhoneNo = prosData['prosPhoneNo'];
    prosEmail = prosData['prosEmail'];
    prosDistrict = prosData['prosDistrict'];
    prosMunicipality = prosData['prosMunicipality'];
    profession = prosData['profession'];
    location = prosData['location'];
    avgRating = double.parse(prosData['avgRating'].toString());
    review = prosData['review'];
  }
}
