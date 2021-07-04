import 'package:get/get.dart';
import 'package:home_utility/model/database.dart';
import 'package:home_utility/model/userData.dart';

class UserController extends GetxController {
  var userData = RxList<UserData>([]);

  List<UserData> get user => userData;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    userData.bindStream(Database().userDataStream());
  }
}
