// import 'package:flutter/material.dart';
// import 'package:chat_poc/components/CustomAppBar.dart';
// import 'package:chat_poc/components/CustomTabBar.dart';

// class ExtendedAppBar extends StatelessWidget {
//   List<Tab> tabs;
//   TabController controller;

//   ExtendedAppBar({this.tabs, this.controller});

//   @override
//   Widget build(BuildContext context) {
//     return PreferredSize(
//       preferredSize: Size(double.infinity, 150),
//       child: AppBar(
//         backgroundColor: const Color(0xff0f4d83),
//         leading: Container(),
//         elevation: 0,
//         flexibleSpace: Column(
//           children: [
//             CustomAppBar(),
//             CustomTabBar(
//               tabs: myTabs,
//               controller: _tabController,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
