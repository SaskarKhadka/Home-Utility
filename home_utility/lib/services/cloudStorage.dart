import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:home_utility/reusableTypes.dart';

class CloudStorage {
  String userID = userAuthentication.userID;
  final instance = FirebaseStorage.instance;

  //uploads file in firebase storage
  Future<bool> uploadFile(File image) async {
    final ref = instance.ref('usersProfilePics/$userID');
    try {
      ListResult listResult;
      String prevProfileName;
      try {
        listResult = await ref.listAll();
        if (!listResult.items.isEmpty || listResult != null) {
          prevProfileName = listResult.items[0].name;
          deleteFile(prevProfileName);
        }
      } catch (e) {
        print(e);
      }

      String dateTime = DateTime.now()
          .toString()
          .replaceAll('.', '')
          .replaceAll(':', '')
          .replaceAll('-', '')
          .replaceAll(' ', '');

      await ref.child(userID + dateTime).putFile(image);

      String url = await profileUrl(userID + dateTime);
      if (url != 'error')
        await usersRefrence.child(userID).update({'profileUrl': url});
      else
        return false;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  deleteFile(String prevProfileName) {
    try {
      instance.ref('usersProfilePics/$userID/$prevProfileName').delete();
    } catch (e) {
      // deleteFile(prevProfileName);
    }
  }

  Future<String> profileUrl(String prevProfileName) async {
    try {
      return await instance
          .ref('usersProfilePics/$userID/$prevProfileName')
          .getDownloadURL();
    } catch (e) {
      print(e);
      return 'error';
    }
  }
}
