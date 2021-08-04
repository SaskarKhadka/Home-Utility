import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_utility/constants.dart';
import 'package:home_utility/controllers/chatController.dart';
import 'package:home_utility/main.dart';
import 'package:home_utility/model/chat.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class ChatScreen extends StatelessWidget {
  final String proID;
  ChatScreen({this.proID});

  final String userID = userAuthentication.userID;
  @override
  Widget build(BuildContext context) {
    final chatController = Get.put(ChatController('$proID$userID'));
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBlackColour,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          centerTitle: true,
          title: Text(
            'Chat Screen',
            style: GoogleFonts.montserrat(
              color: kWhiteColour,
              fontSize: 30,
              letterSpacing: 1.2,
              wordSpacing: 1.5,
            ),
          ),
          // centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MessagesStream(
              proID: proID,
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(
                        top: 15.0,
                        bottom: 15.0,
                        // right: 5.0,
                        left: 10.0,
                      ),
                      padding: EdgeInsets.only(
                        left: 20.0,
                        right: 10.0,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xff8c9292),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: TextField(
                        controller: chatController.messageController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 5.0),

                          // labelText: 'Your Message..',
                          hintText: 'Your message...',
                          hintStyle: TextStyle(color: Colors.black),
                          enabledBorder: OutlineInputBorder(
                            // borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(style: BorderStyle.none),
                          ),
                          focusedBorder: OutlineInputBorder(
                            // borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(style: BorderStyle.none),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (chatController.messageController.text.isNotEmpty) {
                        DateTime now = DateTime.now();
                        String dateTime = now.toString().replaceAll('-', '');
                        dateTime = dateTime.replaceAll(':', '');
                        dateTime = dateTime.replaceAll('.', '');
                        print(now);
                        final key = encrypt.Key.fromUtf8(
                            'my 32 length key is very coooool');
                        final iv = encrypt.IV.fromLength(16);

                        final encrypter = encrypt.Encrypter(encrypt.AES(key));

                        final encrypted = encrypter.encrypt(
                            chatController.messageController.text.trim(),
                            iv: iv);

                        FirebaseDatabase.instance
                            .reference()
                            .child('messages')
                            .child(proID + userID)
                            .child(dateTime + userID)
                            .set({
                          'sentBy': userAuthentication.currentUser.email,
                          'message': encrypted.base64,
                        });
                        chatController.messageController.clear();
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                        right: 15.0,
                      ),
                      child: Icon(
                        Icons.send,
                        color: Color(0xff2464e3),
                      ),
                      // padding: EdgeInsets.only(right: 20.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        // color: kBlackColour,
                      ),
                    ),
                  ),
                  // TextButton(onPressed: () {}, child: Icon(Icons.send))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  final String proID;
  // final String _userID = userAuthentication.userID;
  final String _userEmail = userAuthentication.currentUser.email;
  MessagesStream({this.proID});
  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return GetX<ChatController>(
      init: Get.find<ChatController>(),
      builder: (chatController) {
        if (chatController == null ||
            chatController.chatData == null ||
            chatController.chatData.isEmpty)
          return Expanded(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        Map<String, Chat> messages = chatController.chatData;
        List<String> messageID = [];
        List<Chat> messagesInfo = [];
        messages.forEach((key, value) {
          messageID.add(key);
          messagesInfo.add(value);
        });
        messageID.sort();
        messageID = messageID.reversed.toList();
        return Expanded(
            child: ListView.builder(
          reverse: true,
          itemCount: messageID.length,
          itemBuilder: (context, index) {
            final message = messages[messageID[index]].message;
            final sentBy = messages[messageID[index]].sentBy;
            final key =
                encrypt.Key.fromUtf8('my 32 length key is very coooool');
            final iv = encrypt.IV.fromLength(16);

            final encrypter = encrypt.Encrypter(encrypt.AES(key));

            String decryptedMessage = encrypter.decrypt64(message, iv: iv);

            return MessageContainer(
              message: decryptedMessage,
              sentBy: sentBy,
              isMe: _userEmail == sentBy,
            );
          },
        ));
      },
    );
  }
}

class MessageContainer extends StatelessWidget {
  final String email = userAuthentication.currentUser.email;
  final String message;
  final String sentBy;
  final bool isMe;
  MessageContainer({this.message, this.isMe, this.sentBy});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(
            top: 17.5,
            right: isMe ? 15.0 : MediaQuery.of(context).size.width * 0.3,
            left: isMe ? MediaQuery.of(context).size.width * 0.3 : 15.0,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 12.0,
          ),
          decoration: BoxDecoration(
            color: isMe ? Color(0xff2464e3) : Color(0xff28272C),
            borderRadius: BorderRadius.only(
              bottomLeft: isMe ? Radius.circular(20.0) : Radius.circular(0.0),
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
              bottomRight: isMe ? Radius.circular(0.0) : Radius.circular(20.0),
            ),
          ),
          child: Text(message,
              style: TextStyle(
                color: Color(0xfff1f3f4),
              )),
        ),
      ],
    );
  }
}
