import 'package:flutter/material.dart';
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
      body: myBox(),
    );
  }

  Widget myBox() {
    return ListView.builder(
        itemCount: allrequestlist.length,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.grey[300],
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://a.allegroimg.com/s700/11b279/968714db40cbbd6ccd1b6ba4a028/Swieca-iskrowa-DENSO'),
              ),
              title: Text(
                "จังหวัด ${allrequestlist[index]['text_province']}",
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              subtitle: Text(
                "จำนวนผู้ติดเชื้อ ${allrequestlist[index]['text_total_case คน']}",
                style: TextStyle(fontSize: 16, color: Colors.red),
              ),
              trailing: Icon(Icons.keyboard_arrow_right),
              contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
              // onTap: () {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => UpdatePage(
              //         allrequestlist[index]['id'],
              //         allrequestlist[index]['title'],
              //         allrequestlist[index]['detail']))).then((value) {
              //           setState() {
              //             print(value);
              //             getData();
              //           }
              //         });
              //   },
            ),
          );
        } // itemBuilder
        );
  }

  Future getData() async {
    // https://covid19.ddc.moph.go.th/api/Cases/today-cases-by-provinces
    List allrequestlist = [];
    var url = Uri.https(
        'covid19.ddc.moph.go.th', '/api/Cases/today-cases-by-provinces');
    var response = await http.get(url);
    var result = utf8.decode(response.bodyBytes);
    print(result);

    setState(() {
      allrequestlist = jsonDecode(result);
    });
  }
}
