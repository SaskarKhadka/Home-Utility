import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:home_utility_pro/model/chat.dart';

import '../main.dart';

class ChatController extends GetxController {
  String _chatID;
  final messageController = TextEditingController();
  ChatController(this._chatID);
  var _chatData = RxMap<String, Chat>({});

  Map<String, Chat> get chatData => _chatData;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    print('HI init');
    _chatData.bindStream(database.getChatData(chatID: _chatID));
  }

  @override
  void onClose() {
    // TODO: implement onClose
    print('Hi close');
    super.onClose();
    messageController.dispose();
  }
}