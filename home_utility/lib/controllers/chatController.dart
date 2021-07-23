import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:home_utility/model/chat.dart';

import '../main.dart';

class ChatController extends GetxController {
  final messageController = TextEditingController();
  String _chatID;
  ChatController(this._chatID);
  var _chatData = RxMap<String, Chat>({});

  Map<String, Chat> get chatData => _chatData;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _chatData.bindStream(database.getChatData(chatID: _chatID));
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    messageController.dispose();
  }
}
