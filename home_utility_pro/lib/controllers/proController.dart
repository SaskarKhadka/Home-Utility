import 'package:get/get.dart';
import 'package:home_utility_pro/model/database.dart';
import 'package:home_utility_pro/model/prosData.dart';

class ProController extends GetxController {
  var prosData = RxList<ProsData>([]);

  List<ProsData> get pro => prosData;

  @override
  void onInit() {
    super.onInit();
    prosData.bindStream(Database().proDataStream());
  }

  @override
  void onClose() {
    super.onClose();
    // userData.close();
  }
}
