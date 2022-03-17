import 'package:flutter/material.dart';
import 'package:ttpsmobile/pages/edit_request_form.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';


class RequestListPage extends StatefulWidget {
  // const DetailPage({ Key? key }) : super(key: key);

  @override
  _RequestListPageState createState() => _RequestListPageState();
}

class _RequestListPageState extends State<RequestListPage> {
  //dummy สำหรับทดสอบ Integration
  List allrequestlist = [];
  @override
  void initState() {
    // implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                getData();
              });
            },
            icon: Icon(
              Icons.refresh,
              color: Colors.white,
            ),
          )
        ],
        title: Text('All Request list'),
      ),
      body: requesttaglistShow(),
    );
  }

  Widget requesttaglistShow() {
    return Padding(
        padding: const EdgeInsets.all(3.0),
        child: Container(
          child: ListView.builder(
              itemCount: allrequestlist.length,
              itemBuilder: (context, index) {
                return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        color: Colors.grey[200],
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/images/bg_box2.jpg'),
                          ),
                          trailing: Icon(Icons.keyboard_arrow_right),
                          contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                          title: Text(
                            'Item: ${allrequestlist[index]['item']}',
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                          subtitle: Text(
                            'Date ${allrequestlist[index]['startdate']} - ${allrequestlist[index]['enddate']}',
                            style: TextStyle(fontSize: 16, color: Colors.red),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditForm(
                                  allrequestlist[index]['id'],
                                  allrequestlist[index]['startdate'],
                                  allrequestlist[index]['enddate'],
                                  allrequestlist[index]['item'],
                                  allrequestlist[index]['reason'],
                                  allrequestlist[index]['tel'],
                                  allrequestlist[index]['supervisor'],
                                  allrequestlist[index]['approveplant'],
                                )
                              )
                            ).then((value) {
                              setState() {
                                print(value);
                                getData();
                              }
                            });
                          },
                        ),
                      ),
                    ] // children
                    );
              } // itemBuilder
              ),
        ));
  }

  // API
  Future getData() async {
    List allrequestlist = [];
    var url = Uri.http('10.0.2.2:8000', '/api-team6/all-requestlist/');
    var response = await http.get(url);
    var result = utf8.decode(response.bodyBytes);
    print(result);
    setState(() {
      allrequestlist = jsonDecode(result);
    });
  }
}
