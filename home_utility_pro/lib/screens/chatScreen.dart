import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_utility_pro/constants.dart';
import 'package:home_utility_pro/controllers/chatController.dart';
import 'package:home_utility_pro/main.dart';
import 'package:home_utility_pro/model/chat.dart';

class ChatScreen extends StatelessWidget {
  final String userID;
  ChatScreen({this.userID});
  final proID = userAuthentication.userID;

  @override
  Widget build(BuildContext context) {
    final chatController = Get.put(ChatController('$proID$userID'));
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
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
              userID: userID,
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
              padding: EdgeInsets.only(
                left: 20.0,
                right: 10.0,
              ),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Row(
                // crossAxisAlignment: CrossAxisAlignment.baseline,
                // textBaseline: TextBaseline.alphabetic,
                children: [
                  Expanded(
                    child: TextField(
                      controller: chatController.messageController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 5.0),

                        // labelText: 'Your Message..',
                        hintText: 'Your message...',
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
                        // print(now);
                        FirebaseDatabase.instance
                            .reference()
                            .child('messages')
                            .child(proID + userID)
                            .child(dateTime + proID)
                            .set({
                          'sentBy': userAuthentication.currentUser.email,
                          'message':
                              chatController.messageController.text.trim(),
                        });
                        chatController.messageController.clear();
                      }
                    },
                    child: Container(
                      child: Icon(Icons.send),
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
  final String userID;
  // final String _proID = userAuthentication.userID;
  final String _userEmail = userAuthentication.currentUser.email;
  MessagesStream({this.userID});
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
            return MessageContainer(
              message: message,
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
  // final String email = userAuthentication.currentUser.email;
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
            top: 15.0,
            right: 15.0,
            left: 15.0,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 15.0,
            vertical: 10.0,
          ),
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.only(
              bottomLeft: isMe ? Radius.circular(40.0) : Radius.circular(0.0),
              topLeft: Radius.circular(40.0),
              topRight: Radius.circular(40.0),
              bottomRight: isMe ? Radius.circular(0.0) : Radius.circular(40.0),
            ),
          ),
          child: Text(message),
        ),
      ],
    );
  }
}
