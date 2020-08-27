import 'package:chat_poc/models/User.dart';
import 'package:chat_poc/models/Message.dart';
import 'package:chat_poc/models/Group.dart';
import 'package:intl/intl.dart';

class Examples {
  static List<User> users = [
    User(name: "Mac", userID: "1001"),
    User(name: "Kira", userID: "2002"),
    User(name: "Jason", userID: "3003"),
    User(name: "Selene", userID: "4004"),
    User(name: "Shawn", userID: "5005"),
    User(name: "Burton", userID: "6006"),
    User(name: "Alexis", userID: "7007"),
  ];

  static List<Message> messages = [
    Message(
      content: 'Hello',
      senderID: '1001',
      recipientID: '2002',
      time: DateFormat.jm().format(DateTime.now()),
    ),
    Message(
      content: 'Hello',
      senderID: '1001',
      recipientID: '2002',
      time: DateFormat.jm().format(DateTime.now()),
    ),
    Message(
      content: 'World',
      senderID: '2002',
      recipientID: '1001',
      time: DateFormat.jm().format(DateTime.now()),
    ),
    Message(
      content: 'Hello',
      senderID: '1001',
      recipientID: '2002',
      time: DateFormat.jm().format(DateTime.now()),
    ),
    Message(
      content: 'World',
      senderID: '2002',
      recipientID: '1001',
      time: DateFormat.jm().format(DateTime.now()),
    ),
    Message(
      content: 'Hello',
      senderID: '1001',
      recipientID: '2002',
      time: DateFormat.jm().format(DateTime.now()),
    ),
    Message(
      content: 'World',
      senderID: '2002',
      recipientID: '1001',
      time: DateFormat.jm().format(DateTime.now()),
    ),
    Message(
      content: 'Hello',
      senderID: '1001',
      recipientID: '2002',
      time: DateFormat.jm().format(DateTime.now()),
    ),
    Message(
      content: 'World',
      senderID: '2002',
      recipientID: '1001',
      time: DateFormat.jm().format(DateTime.now()),
    ),
    Message(
      content: 'Hello',
      senderID: '1001',
      recipientID: '999',
      time: DateFormat.jm().format(DateTime.now()),
    ),
    Message(
      content: 'World',
      senderID: '2002',
      recipientID: '999',
      time: DateFormat.jm().format(DateTime.now()),
    ),
    Message(
      content: 'Hello',
      senderID: '3003',
      recipientID: '999',
      time: DateFormat.jm().format(DateTime.now()),
    ),
    Message(
      content: 'World',
      senderID: '7007',
      recipientID: '999',
      time: DateFormat.jm().format(DateTime.now()),
    ),
  ];

  static Group group = Group(name: 'Hostels', groupID: '999', members: [
    User(name: "Mac", userID: "1001"),
    User(name: "Kira", userID: "2002"),
    User(name: "Jason", userID: "3003"),
    User(name: "Selene", userID: "4004"),
    User(name: "Shawn", userID: "5005"),
    User(name: "Burton", userID: "6006"),
    User(name: "Alexis", userID: "7007"),
  ]);
}
