import 'package:flutter/material.dart';
import 'package:ttpsmobile/pages/edit.dart';
import 'package:ttpsmobile/pages/login.dart';
import 'package:ttpsmobile/pages/request.dart';
import 'package:ttpsmobile/pages/home.dart';
import 'package:ttpsmobile/pages/request_form.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TTPS Moblie By Team 6',
      home: LoginPage(),
    );
  }
}
