import 'package:chat_poc/models/Examples.dart';
import 'package:chat_poc/models/Group.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
// import 'dart:convert';

import './User.dart';
import './Message.dart';

class ChatModel extends Model {
  List<User> users = Examples.users;

  User currentUser;
  List<User> contacts = List<User>();

  // List<Message> messages = List<Message>();
  List<Message> messages = Examples.messages;

  Group group = Examples.group;

  void init() {
    currentUser = users[0]; // run as 1 2 3 in different devices
    contacts =
        users.where((user) => user.userID != currentUser.userID).toList();

    IO.Socket socket = IO.io('http://localhost:3001', <String, dynamic>{
      'transports': ['websocket'],
      'query': 'chatID=${currentUser.userID}',
    });
  }

  void sendMessage(String text, String recipientID) {
    messages.add(Message(
      content: text,
      senderID: currentUser.userID,
      recipientID: recipientID,
    ));

    // socketIO.sendMessage(
    //   'send_message',
    //   json.encode({
    //     'recipientID': recipientID,
    //     'senderChatID': currentUser.chatID,
    //     'content': text,
    //   }),
    // );
    notifyListeners();
  }

  List<Message> getMessagesForUserID(String chatID) {
    return messages
        .where((msg) => msg.senderID == chatID || msg.recipientID == chatID)
        .toList();
  }
}
