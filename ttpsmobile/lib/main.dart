import 'package:flutter/material.dart';
import 'package:ttpsmobile/pages/all_request_list.dart';
import 'package:ttpsmobile/pages/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  late TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TTPS Moblie By Team 6',
      home: LoginPage(),
    );
  }
}
