import 'package:flutter/material.dart';
import 'package:ttpsmobile/pages/all_request_list.dart';
import 'package:ttpsmobile/pages/login.dart';
import 'package:ttpsmobile/pages/logout.dart';
import 'package:ttpsmobile/pages/add_request_form.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  // const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  PageController pageController = PageController();
  List<Widget> pages = [RequestListPage(), RequestForm(), LogoutPage()];

  int selectIndex = 0;

  void onPageChanged(int index) {
    setState(() {
      selectIndex = index;
    });
  }

  void onItemTap(int selectedItems) {
    pageController.jumpToPage(selectedItems);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        body: PageView(
          controller: pageController,
          children: pages,
          onPageChanged: onPageChanged,
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: onItemTap,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.app_registration),
              label: 'Request Form',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.logout_outlined),
              label: 'Logout',
            ),
          ],
          currentIndex: selectIndex,
          selectedItemColor: Colors.red[800],
        ),
      ),
    );
  }
}
