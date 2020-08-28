import './pages/MainPage.dart';
import './models/ChatModel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  runApp(ScopedModel(
    model: ChatModel(),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(
        category: "hostels",
      ),
    ),
  ));
}
