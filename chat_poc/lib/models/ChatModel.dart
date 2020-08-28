import 'dart:convert';

import './Examples.dart';
import './Group.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_socket_io/flutter_socket_io.dart';
import 'package:flutter_socket_io/socket_io_manager.dart';

import './User.dart';
import './Message.dart';

class ChatModel extends Model {
  // IO.Socket socket;
  SocketIO socketIO;
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

    socketIO = SocketIOManager().createSocketIO(
        '<ENTER_YOUR_SERVER_URL_HERE>', '/',
        query: 'roomID=${currentUser.userID}');
    socketIO.init();

    socketIO.subscribe('receive_message', (jsonData) {
      Map<String, dynamic> data = json.decode(jsonData);
      messages.add(Message(
        content: data["content"],
        senderID: data["senderChatID"],
        recipientID: data["receiverChatID"],
        time: DateFormat.jm().format(DateTime.now()),
      ));

      notifyListeners();
    });

    socketIO.connect();
  }

  void sendMessage(String text, String recipientID) {
    messages.add(Message(
      content: text,
      senderID: currentUser.userID,
      recipientID: recipientID,
      time: DateFormat.jm().format(DateTime.now()),
    ));
    socketIO.sendMessage(
      'send_message',
      json.encode({
        'receiverChatID': recipientID,
        'senderChatID': currentUser.userID,
        'content': text,
        'time': DateFormat.jm().format(DateTime.now()),
      }),
    );
    notifyListeners();

  }
  List<Message> getMessagesForID(String chatID) {
    return messages
        .where((msg) =>
            msg.isGroup == false && //individual
            (msg.senderID == chatID || msg.recipientID == chatID))
        .toList();
  }

  //       IO.io('https://calm-savannah-01592.herokuapp.com', <String, dynamic>{
  //     'transports': ['websocket'],
  //     'query': json.encode({"roomID": "1001"}),
  //   });

  //   socket.connect();

  //   socket.on('connect', (data) {
  //     print("Connection Initiated: $data");
  //     socket.emit("send_message",json.encode({
  //         'receiverChatID': "2009",
  //         'senderChatID': "8000",
  //         'content': "text",
  //         'time': "13-09-20",
  //       }));
  //   });

  //   socket.on("receive_message", (response) {
  //     Map<String, dynamic> data = json.decode(response);
  //     messages.add(Message(
  //       content: data["content"],
  //       senderID: data["senderChatID"],
  //       recipientID: data["receiverChatID"],
  //       time: DateFormat.jm().format(DateTime.now()),
  //     ));

  //   notifyListeners();
  //   });

  // }

  // void sendMessage(String text, String recipientID) {
  //   messages.add(Message(
  //     content: text,
  //     senderID: currentUser.userID,
  //     recipientID: recipientID,
  //     time: DateFormat.jm().format(DateTime.now()),
  //   ));

  //   socket.emit(
  //       "send_message",
  //       json.encode({
  //         'receiverChatID': recipientID,
  //         'senderChatID': currentUser.userID,
  //         'content': text,
  //         'time': DateFormat.jm().format(DateTime.now()),
  //       }));

  //   notifyListeners();
  // }

  // List<Message> getMessagesForID(String chatID) {
  //   return messages
  //       .where((msg) =>
  //           msg.isGroup == false && //individual
  //           (msg.senderID == chatID || msg.recipientID == chatID))
  //       .toList();
  // }
}
