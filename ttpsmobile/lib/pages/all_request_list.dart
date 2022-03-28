import 'package:flutter/material.dart';
import 'package:ttpsmobile/pages/edit_request_form.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

// class RequestListPage extends StatefulWidget {
//   // const DetailPage({ Key? key }) : super(key: key);

//   @override
//   _RequestListPageState createState() => _RequestListPageState();
// }

// class _RequestListPageState extends State<RequestListPage> {
//   //dummy สำหรับทดสอบ Integration
//   List allrequestlist = [];
//   @override
//   void initState() {
//     // implement initState
//     super.initState();
//     getItemlist();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         actions: [
//           IconButton(
//             onPressed: () {
//               setState(() {
//                 getItemlist();
//               });
//             },
//             icon: Icon(
//               Icons.refresh,
//               color: Colors.white,
//             ),
//           )
//         ],
//         title: Text('All Request list'),
//       ),
//       body: requesttaglistShow(),
//     );
//   }

//   Widget requesttaglistShow() {
//     return ListView.builder(
//         itemCount: allrequestlist.length,
//         itemBuilder: (context, index) {
//           return Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Card(
//                   color: Colors.grey[200],
//                   child: ListTile(
//                     leading: CircleAvatar(
//                       backgroundImage: AssetImage('assets/images/bg_box2.jpg'),
//                     ),
//                     title: Text(
//                       'Item: ${allrequestlist[index]['item']}',
//                       style: TextStyle(fontSize: 20, color: Colors.black),
//                     ),
//                     trailing: Icon(Icons.keyboard_arrow_right),
//                     contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
//                     subtitle: Text(
//                       'Date ${allrequestlist[index]['startdate']} - ${allrequestlist[index]['enddate']}',
//                       style: TextStyle(fontSize: 16, color: Colors.red),
//                     ),
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => EditForm(
//                             allrequestlist[index]['id'],
//                             allrequestlist[index]['startdate'],
//                             allrequestlist[index]['enddate'],
//                             allrequestlist[index]['item'],
//                             allrequestlist[index]['reason'],
//                             allrequestlist[index]['tel'],
//                             allrequestlist[index]['supervisor'],
//                             allrequestlist[index]['approveplant']))).then((value) {
//                               setState() {
//                                 print(value);
//                                 getItemlist();
//                             }
//                           });
//                     },
//                   ),
//                 ),
//               ] // children
//               );
//         });
//   }

//   // API
//   Future getItemlist() async {
//     List allList = [];
//     var url = Uri.http('localhost:8000', '/api-team6/all-requestlist/');
//     var response = await http.get(url);
//     var result = utf8.decode(response.bodyBytes);
//     print(result);
//     setState(() {
//       allrequestlist = jsonDecode(result);
//     });
//   }
// }

class RequestListPage extends StatefulWidget {
  // const DetailPage({ Key? key }) : super(key: key);

  @override
  _RequestListPageState createState() => _RequestListPageState();
}

class _RequestListPageState extends State<RequestListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                // getItemlist();
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
              return myBox(
                  snapshot.data[index]['startdate'],
                  snapshot.data[index]['enddate'],
                  snapshot.data[index]['item'],
                  snapshot.data[index]['reason'],
                  snapshot.data[index]['tel'],
                  snapshot.data[index]['supervisor'],
                  snapshot.data[index]['approveplant'],
                  context
              );
            },
            itemCount: snapshot.data.length,
          );
        },
        future: getData(),
      ),
    );
  }
}

Widget myBox(String startdate, String enddate, String item, String reason, String tel, String supervisor, String approveplant, context) {
  var v_sdate;
  var v_edate;
  var v_item;
  var v_reason;
  var v_tel;
  var v_super;
  var v_plant;

  v_sdate = startdate;
  v_edate = enddate;
  v_item = item;
  v_reason = reason;
  v_tel = tel;
  v_super = supervisor;
  v_plant = approveplant;

  
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            color: Colors.grey[200],
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage('assets/images/bg_box2.jpg'),
              ),
              title: Text(
                'Item: ${item}',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              subtitle: Text(
                'Date: ${startdate} - ${enddate}',
                style: TextStyle(fontSize: 16, color: Colors.red),
              ),
              onTap: () {
                
              },
              trailing: Icon(Icons.keyboard_arrow_right),
              contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
            ),
          ),
        ] // children
        ),
  );
}

Future getData() async {
  var url = Uri.https(
      'raw.githubusercontent.com', '/Thitima03/Mobile/main/dataitem.json');
  var response = await http.get(url);
  var result = json.decode(response.body);
  return result;
}
