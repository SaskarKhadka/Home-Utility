import 'package:get/get.dart';
import 'package:home_utility_pro/main.dart';
import 'package:home_utility_pro/model/database.dart';
import 'package:home_utility_pro/model/userData.dart';

class UserController extends GetxController {
  final String userID;
  UserController(this.userID);
  var userData = RxList<UserData>([]);

  List<UserData> get user => userData;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    userData.bindStream(database.userDataStream(userID: userID));
  }
}
