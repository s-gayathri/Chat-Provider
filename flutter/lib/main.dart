import 'package:flutter/material.dart';

import './chatPage.dart';

void main()=>runApp(MyChatApp());

class MyChatApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:ChatPage(),
    );
  }
}