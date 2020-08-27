import 'package:chat_poc/models/Group.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:chat_poc/models/User.dart';
import 'package:chat_poc/models/ChatModel.dart';

class ChatList extends StatefulWidget {
  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  @override
  void initState() {
    super.initState();
    ScopedModel.of<ChatModel>(context, rebuildOnChange: false).init();
  }

  @override
  Widget build(BuildContext context) {
    return buildChatList();
  }

  void onClickContact({User contact, Group group}) {
    // Navigator.of(context).push(MaterialPageRoute(
    //     builder: (BuildContext context) => ChatPage(contact: contact)));
  }

  Widget buildChatList() {
    return ScopedModelDescendant<ChatModel>(
      builder: (context, child, model) {
        return ListView.builder(
          itemCount: model.contacts.length,
          itemBuilder: (BuildContext context, int index) {
            User contact = model.contacts[index];
            return ListTile(
              leading: Container(
                height: MediaQuery.of(context).size.width / 8,
                width: MediaQuery.of(context).size.width / 8,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                  ),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage('https://robohash.org/${contact.name}'),
                  ),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              title: Text(contact.name),
              subtitle: Text('in "MIT Boston"'),
              onTap: () => onClickContact(contact: contact),
            );
          },
        );
      },
    );
  }
}
