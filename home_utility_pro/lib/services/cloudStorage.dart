import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:home_utility_pro/reusableTypes.dart';

class CloudStorage {
  String proID = userAuthentication.userID;
  final instance = FirebaseStorage.instance;

  //uploads file in firebase storage
  Future<bool> uploadFile(File image) async {
    final ref = instance.ref('prosProfilePics/$proID');
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

      await ref.child(proID + dateTime).putFile(image);

      String url = await profileUrl(proID + dateTime);
      if (url != 'error')
        await prosRefrence.child(proID).update({'profileUrl': url});
      else
        return false;
      return true;
    } on FirebaseException catch (e) {
      print(e.code);
      return false;
    }
  }

  deleteFile(String prevProfileName) {
    try {
      instance.ref('prosProfilePics/$proID/$prevProfileName').delete();
    } catch (e) {
      print(e);
    }
  }

  Future<String> profileUrl(String prevProfileName) async {
    try {
      return await instance
          .ref('prosProfilePics/$proID/$prevProfileName')
          .getDownloadURL();
    } catch (e) {
      print(e);
      return 'error';
    }
  }
}
