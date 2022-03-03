import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class RequestPage extends StatefulWidget {
  const RequestPage({Key? key}) : super(key: key);

  @override
  _RequestPageState createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  TextEditingController todo_title = TextEditingController();
  TextEditingController todo_detail = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('เพิ่มรายการใหม่',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            )),
        backgroundColor: Colors.blue[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            //ข้อความ
            //Text("Todo List",
            //    style: TextStyle(
            //        fontSize: 30,
            //        fontFamily: 'Sarabun',
            //        color: Colors.green[900])),
            //SizedBox(height: 20),
            //รูปภาพ
            //Image.asset(
            //  'assets/images/logo2.png',
            //  width: 350,
            //),
            SizedBox(height: 20),
            // ช่องกรอกข้อมูล title
            TextField(
                controller: todo_title,
                decoration: InputDecoration(
                    labelText: 'รายการที่ต้องทำ',
                    border: OutlineInputBorder())),
            SizedBox(
              height: 30,
            ),
            TextField(
                minLines: 4,
                maxLines: 8,
                controller: todo_detail,
                decoration: InputDecoration(
                    labelText: 'รายละเอียด', border: OutlineInputBorder())),
            SizedBox(
              height: 30,
            ),
            // ปุ่มเพิ่มข้อมูล
            Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                onPressed: () {
                  print('-----------');
                  print('title: ${todo_title.text}');
                  print('detail: ${todo_detail.text}');
                  postTodo();
                  setState(() {
                    todo_title.clear(); //เคลียร์ข้อมูลหลังจากโพสต์
                    todo_detail.clear(); //เคลียร์ข้อมูลหลังจากโพสต์
                  });
                },
                child: Text("เพิ่มรายการ"),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                    padding: MaterialStateProperty.all(
                        EdgeInsets.fromLTRB(50, 20, 50, 20)),
                    textStyle:
                        MaterialStateProperty.all(TextStyle(fontSize: 30))),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future postTodo() async {
    var url = Uri.http('10.10.10.140:8000', '/api-62160148/post_todolist/');
    //ประเภทของ Data ที่เราจะส่งไปเป็นแบบ json
    Map<String, String> header = {"Content-type": "application/json"};
    //Data ที่จะส่ง
    String jsondata =
        '{"title":"${todo_title.text}", "detail":"${todo_detail.text}"}';
    // '{"title":"${todo_title.text}", "detail":"${todo_detail.text}"}';
    var response = await http.post(url, headers: header, body: jsondata);
    print('------result-------');
    print(response.body);
  }
}
