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
        body: FutureBuilder(
          builder: (context, AsyncSnapshot snapshot) {
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return myBox(snapshot.data[index]['province'],
                    snapshot.data[index]['total_case_excludeabroad'], context);
              },
              itemCount: snapshot.data.length,
            );
          },
          future: getData(),
        ));
  }

  Widget myBox(String province, int total_case_excludeabroad, context) {
    var text_total_case;
    var text_province;

    text_province = province;
    text_total_case = total_case_excludeabroad.toString();

    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
          // child: ListView.builder(
          // itemCount: allrequestlist.length,
          // itemBuilder: (context, index) {
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            Card(
              color: Colors.grey[200],
              child: ListTile(
                leading: CircleAvatar(
                  //   backgroundImage: NetworkImage(
                  //       'https://a.allegroimg.com/s700/11b279/968714db40cbbd6ccd1b6ba4a028/Swieca-iskrowa-DENSO'),
                  // ),
                  backgroundImage: AssetImage('assets/images/bg_box2.jpg'),
                ),
                // title: Text(
                //   "จังหวัด ${allrequestlist[index]['text_province']}",
                //   style: TextStyle(fontSize: 20, color: Colors.black),
                // ),
                // subtitle: Text(
                //   "จำนวนผู้ติดเชื้อ ${allrequestlist[index]['text_total_case คน']}",
                //   style: TextStyle(fontSize: 16, color: Colors.red),
                // ),
                trailing: Icon(Icons.keyboard_arrow_right),
                contentPadding: EdgeInsets.symmetric(horizontal: 8.0),

                title: Text(
                  'จังหวัด $text_province',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                subtitle: Text(
                  'จำนวนผู้ติดเชื้อ $text_total_case คน',
                  style: TextStyle(fontSize: 16, color: Colors.red),
                ),
              ),
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
            )
          ])
          // } // itemBuilder
          ),
    );
    // );
  }

  // API
  // Future getData() async {
  //   List allrequestlist = [];
  //   var url = Uri.https(
  //       'covid19.ddc.moph.go.th', '/api/Cases/today-cases-by-provinces');
  //   var response = await http.get(url);
  //   var result = utf8.decode(response.bodyBytes);
  //   print(result);

  //   setState(() {
  //     allrequestlist = jsonDecode(result);
  //   });
  // }

  // JSON
  Future getData() async {
    var url = Uri.https(
        'covid19.ddc.moph.go.th', '/api/Cases/today-cases-by-provinces');
    var response = await http.get(url);
    var result = json.decode(response.body);
    return result;
  }
}
