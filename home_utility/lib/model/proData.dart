class ProsData {
  String prosName;
  String proID;
  String prosEmail;
  int prosPhoneNo;
  String prosMunicipality;
  String prosDistrict;

  ProsData.fromData(Map prosData) {
    prosName = prosData['prosName'];
    proID = prosData['proID'];
    prosPhoneNo = prosData['prosPhoneNo'];
    prosEmail = prosData['prosEmail'];
    prosDistrict = prosData['prosDistrict'];
    prosMunicipality = prosData['prosMunicipality'];
  }
}
