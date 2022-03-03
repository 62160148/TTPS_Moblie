import 'package:flutter/material.dart';
import 'package:ttpsmobile/pages/request.dart';
import 'package:ttpsmobile/pages/edit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class HomePage extends StatefulWidget {
  //const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
//dummy ต้นแบบข้อมูล
  List HomePageitems = [];

  @override
  void initState() {
    super.initState();
    // getHomePages();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => RequestPage()));
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.green,
        ),
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    getHomePages();
                  });
                },
                icon: Icon(
                  Icons.refresh,
                  color: Colors.white,
                ))
          ],
          title: Text('All HomePage',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              )),
          backgroundColor: Colors.blue[900],
        ),
        body: HomePageCreate());
  }

  Widget HomePageCreate() {
    return ListView.builder(
        itemCount: HomePageitems.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: FlutterLogo(
                size: 30,
              ),
              title: Text("${HomePageitems[index]['title']}"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditPage(
                            HomePageitems[index]['id'],
                            HomePageitems[index]['title'],
                            HomePageitems[index]['detail']))).then((value) {
                  setState(() {
                    getHomePages();
                  });
                });
              },
              trailing: Icon(Icons.more_vert),
            ),
          );
        });
  } //HomePageCreate

  Future<void> getHomePages() async {
    List alltodo = [];
    var url = Uri.http('10.10.10.140:8000', '/api-62160148/all_HomePage/');
    var response = await http.get(url);
    var result = utf8.decode(response.bodyBytes);
    print(result);
    setState(() {
      HomePageitems = jsonDecode(result);
    });
  } //getHomePages
}//_HomePageState
