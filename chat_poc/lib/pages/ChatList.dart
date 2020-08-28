import '../models/Examples.dart';
// import './models/Group.dart';
import '../pages/MainPage.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

// import './models/User.dart';
import '../models/ChatModel.dart';

class ChatList extends StatefulWidget {
  final String category;

  ChatList({this.category});

  @override
  _ChatListState createState() => _ChatListState(category: category);
}

class _ChatListState extends State<ChatList> {
  final String category;

  _ChatListState({this.category});

  @override
  void initState() {
    super.initState();
    ScopedModel.of<ChatModel>(context, rebuildOnChange: false).init();
  }

  @override
  Widget build(BuildContext context) {
    return buildChatList();
  }

  void onClickSubCollab(String subcollab) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => MainPage(category: subcollab)));
  }

  Widget buildChatList() {
    return ScopedModelDescendant<ChatModel>(
      builder: (context, child, model) {
        return ListView.builder(
          // itemCount: model.contacts.length,
          itemCount: Examples.subcollabs[category].length,
          itemBuilder: (BuildContext context, int index) {
            // User contact = model.contacts[index];
            var subcollab = Examples.subcollabs[category][index];
            // print(subcollab);
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
                    image: NetworkImage(
                        'https://robohash.org/${Examples.directory[subcollab]["title"]}'),
                  ),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              title: Text(Examples.directory[subcollab]["title"]),
              subtitle: Text(Examples.directory[subcollab]["title"]),
              onTap: () {
                onClickSubCollab(subcollab);
              },
            );
          },
        );
      },
    );
  }
}