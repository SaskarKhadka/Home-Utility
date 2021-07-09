import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:home_utility_pro/main.dart';

class CloudStorage {
  String proID = userAuthentication.userID;
  final instance = FirebaseStorage.instance;

  //uploads file in firebase storage
  Future<bool> uploadFile(File image) async {
    try {
      ListResult listResult =
          await instance.ref('prosProfilePics/$proID').listAll();

      String prevProfileName = listResult.items[0].name;
      String dateTime = DateTime.now()
          .toString()
          .replaceAll('.', '')
          .replaceAll(':', '')
          .replaceAll('-', '')
          .replaceAll(' ', '');

      await instance
          .ref('prosProfilePics/$proID')
          .child(proID + dateTime)
          .putFile(image);

      String url = await profileUrl(proID + dateTime);
      await prosRefrence.child(proID).update({'profileUrl': url});
      deleteFile(prevProfileName);

      return true;
    } on FirebaseException catch (e) {
      print(e.code);
      return false;
    }
  }

  deleteFile(String prevProfileName) {
    instance.ref('prosProfilePics/$proID/$prevProfileName').delete();
  }

  Future<String> profileUrl(String prevProfileName) async {
    return await instance
        .ref('prosProfilePics/$proID/$prevProfileName')
        .getDownloadURL();
  }
}
