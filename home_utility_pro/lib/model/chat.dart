class Chat {
  String _message;
  String _sentBy;

  Chat();

  String get message => _message;
  String get sentBy => _sentBy;

  Chat.fromData(Map chatData) {
    _message = chatData['message'];
    _sentBy = chatData['sentBy'];
  }
}
