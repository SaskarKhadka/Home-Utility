import 'package:firebase_storage/firebase_storage.dart';

class HomeServices {
  String _service;
  String _imagePath;
  HomeServices(this._service, this._imagePath);

  String getService() {
    return _service;
  }

  String getImagePath() {
    return _imagePath;
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
}
