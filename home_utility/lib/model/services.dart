import 'package:firebase_storage/firebase_storage.dart';

class Services {
  String _service;
  String _imgPath;
  String _category;
  Services();

  Services.fromData(Map serviceData) {
    _service = serviceData['service'];
    _imgPath = serviceData['imgPath'];
    _category = serviceData['category'];
  }

  String getService() {
    return _service;
  }

  String getImagePath() {
    return _imgPath;
  }

  String getCategory() {
    return _category;
  }
}

class DatabaseStorage {
  Future<String> getImageUrl({String category, String serviceName}) async {
    return await FirebaseStorage.instance
        .ref()
        .child('service')
        .child(category)
        .child(serviceName)
        .getDownloadURL();
  }

  uploadImage(String uid) {
    // FirebaseStorage.instance.ref().child(uid).putFile('url');
  }
}
