import 'package:chat_poc/models/ChatModel.dart';
import 'package:flutter/material.dart';

import 'package:chat_poc/components/CustomTabBar.dart';
import 'package:chat_poc/components/CustomBottomBar.dart';
import 'package:chat_poc/components/CustomAppBar.dart';
import 'package:chat_poc/models/Examples.dart';
import 'package:chat_poc/models/Group.dart';
import 'package:chat_poc/models/User.dart';
import 'package:chat_poc/pages/ChatPage.dart';
import 'package:chat_poc/pages/ChatList.dart';
import 'package:scoped_model/scoped_model.dart';

class MainPage extends StatefulWidget {
  final String category;

  MainPage({this.category});

  @override
  _MainPageState createState() => _MainPageState(category: category);
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  TabController _tabController;
  String category;

  _MainPageState({this.category});

  @override
  void initState() {
    print('Category $category');
    _tabController = TabController(length: Examples.myTabs.length, vsync: this);
    _tabController.addListener(() {
      print('Tab Controller index ${_tabController.index}');
    });
    // category = ModalRoute.of(context).settings.arguments;
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ChatModel>(builder: (context, child, model) {
      // print(model.currentUser);
      return Scaffold(
        bottomNavigationBar: CustomBottomBar(),
        appBar: PreferredSize(
          preferredSize:
              Size(double.infinity, MediaQuery.of(context).size.height / 6.7),
          child: AppBar(
            backgroundColor: const Color(0xff0f4d83),
            leading: Container(),
            elevation: 0,
            flexibleSpace: Column(
              children: [
                CustomAppBar(
                  title: Examples.directory[category]["title"],
                  subtitle: Examples.directory[category]["subtitle"],
                ),
                CustomTabBar(
                  tabs: Examples.myTabs,
                  controller: _tabController,
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            ChatList(category: category),
            ChatPage(
              // group: Group(name: 'Hostels', groupID: "999"),
              contact1: Examples.users[0],
              contact2: Examples.users[1],
            ),
            Center(child: Text('This is the Plugins tab')),
          ],
          controller: _tabController,
        ),
      );
    });
  }
}
