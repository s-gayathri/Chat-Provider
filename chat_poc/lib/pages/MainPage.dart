import 'package:chat_poc/components/CustomBottomBar.dart';
import 'package:chat_poc/models/Group.dart';
import 'package:chat_poc/pages/ChatList.dart';
import 'package:flutter/material.dart';

import 'package:chat_poc/components/CustomAppBar.dart';
import 'package:chat_poc/components/CustomTabBar.dart';
import 'package:chat_poc/models/User.dart';
import 'package:chat_poc/pages/ChatPage.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  List<Tab> myTabs = [
    Tab(text: 'Sub-Collabs'),
    Tab(text: 'Messages'),
    Tab(text: 'Plugins'),
  ];
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: myTabs.length, vsync: this);
    _tabController.addListener(() {
      print(_tabController.index);
    });
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              CustomAppBar(),
              CustomTabBar(
                tabs: myTabs,
                controller: _tabController,
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(
        children: [
          ChatList(),
          ChatPage(
            // group: Group(name: 'Hostels', groupID: "999"),
            contact: User(name: "Mac", userID: "1001"),
          ),
          Center(child: Text('This is the Plugins tab')),
        ],
        controller: _tabController,
      ),
    );
  }
}
