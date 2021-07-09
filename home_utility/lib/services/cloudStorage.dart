import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:home_utility/main.dart';

class CloudStorage {
  String userID = userAuthentication.userID;
  final instance = FirebaseStorage.instance;

  //uploads file in firebase storage
  Future<bool> uploadFile(File image) async {
    try {
      // ListResult listResult =
      //     await instance.ref('usersProfilePics/$userID').listAll();

      // String prevProfileName = listResult.items[0].name;
      String dateTime = DateTime.now()
          .toString()
          .replaceAll('.', '')
          .replaceAll(':', '')
          .replaceAll('-', '')
          .replaceAll(' ', '');

      await instance
          .ref('prosProfilePics/$userID')
          .child(userID + dateTime)
          .putFile(image);

      String url = await profileUrl(userID + dateTime);
      await usersRefrence.child(userID).update({'profileUrl': url});
      // deleteFile(prevProfileName);

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  deleteFile(String prevProfileName) {
    instance.ref('prosProfilePics/$userID/$prevProfileName').delete();
  }

  Future<String> profileUrl(String prevProfileName) async {
    return await instance
        .ref('prosProfilePics/$userID/$prevProfileName')
        .getDownloadURL();
  }
}
