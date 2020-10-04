import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat_poc/models/User.dart';
import 'package:chat_poc/models/Message.dart';
import 'package:chat_poc/models/Group.dart';
import 'package:chat_poc/models/ChatModel.dart';

class ChatPage extends StatefulWidget {
  final User contact1;
  final User contact2;
  final Group group;

  ChatPage({this.contact1, this.contact2, this.group});

  @override
  _ChatPageState createState() => _ChatPageState(
      contact1: this.contact1, contact2: this.contact2, group: this.group);
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController myController = TextEditingController();
  final User contact1;
  final User contact2;
  final Group group;
  String content;
  String roomID;

  _ChatPageState({this.contact1, this.contact2, this.group});

  void onTextChange() {
    setState(() {
      content = myController.text;
    });
  }

  @override
  void initState() {
    // print('${contact1.name} ${contact2.name}');
    roomID = (group == null) ? contact2.userID : group.groupID;
    Provider.of<ChatModel>(context, listen: false).init();
    print(
        'LENGTH in initState ${Provider.of<ChatModel>(context, listen: false).getMessages()}');
    myController.addListener(onTextChange);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    Provider.of<ChatModel>(context, listen: true).init();
    myController.addListener(onTextChange);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(
        'LENGTH in build ${Provider.of<ChatModel>(context, listen: false).getMessages()}');

    return SafeArea(
      child: Column(
        children: [
          Flexible(
            fit: FlexFit.tight,
            child: getMessagesInChat(),
          ),
          buildChatArea(),
        ],
      ),
    );
  }

  Widget generateMessage(Message message) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 10.0,
          ),
          child: Icon(
            Icons.account_circle,
            size: 40,
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.7,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
            color: message.senderID == contact1.userID
                ? const Color(0x0f1f6b9c)
                : const Color(0xee0a6da8),
          ),
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(10),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    message.senderID == contact1.userID
                        ? Text(
                            'You',
                            style: TextStyle(color: const Color(0xee0a6da8)),
                          )
                        : Text(
                            message.senderID,
                            style: TextStyle(color: Colors.amber[800]),
                          ),
                    Text(message.time),
                  ],
                ),
                SizedBox(
                  height: 6,
                ),
                Text(message.content)
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget getMessagesInChat() {
    return Consumer<ChatModel>(
      builder: (context, model, child) {
        List<Message> messages = model.getMessagesForID(roomID);

        return Container(
          height: MediaQuery.of(context).size.height * 0.75,
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) =>
                generateMessage(messages[index]),
            itemCount: messages.length,
          ),
        );
      },
    );
  }

  Widget buildChatArea() {
    return Consumer<ChatModel>(
      builder: (context, model, child) {
        return Container(
          color: Colors.white,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.attach_file),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 10.0, right: 10.0),
                  child: TextField(
                    controller: myController,
                  ),
                ),
              ),
              Icon(Icons.mic_none),
              IconButton(
                // iconSize: 0,
                icon: Icon(Icons.send),
                onPressed: () {
                  model.sendMessage(content, roomID);
                   setState(() {
                    myController.text = '';
                  });
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
