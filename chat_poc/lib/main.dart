import 'package:chat_poc/Pages/MainPage.dart';
import 'package:chat_poc/models/ChatModel.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  runApp(ScopedModel(
    model: ChatModel(),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    ),
  ));
}
