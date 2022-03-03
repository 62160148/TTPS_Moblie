import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:async';

class EditPage extends StatefulWidget {
  //const EditPage({Key? key}) : super(key: key);

  @override
  _EditPageState createState() => _EditPageState();
  final v1, v2, v3;
  const EditPage(this.v1, this.v2, this.v3);
}

class _EditPageState extends State<EditPage> {
  TextEditingController todo_title = TextEditingController();
  TextEditingController todo_detail = TextEditingController();
  var _v1, _v2, _v3;
  @override
  void initState() {
    super.initState();
    _v1 = widget.v1;
    _v2 = widget.v2;
    _v3 = widget.v3;
    todo_title.text = _v2;
    todo_detail.text = _v3;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('แก้ไขข้อมูล',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            )),
        actions: [
          IconButton(
              onPressed: () {
                deleteTodo();
              },
              icon: Icon(
                Icons.delete,
                color: Colors.white,
              ))
        ],
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
                  // setState(() {
                  //   todo_title.clear(); //เคลียร์ข้อมูลหลังจากโพสต์
                  //   todo_detail.clear(); //เคลียร์ข้อมูลหลังจากโพสต์
                  // });
                  final snackBar =
                      SnackBar(content: const Text('delete complete'));
                },
                child: Text("แก้ไขรายการ"),
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
    var url =
        Uri.http('10.10.10.229:8000', '/api-62160148/update_todolist/$_v1');
    //ประเภทของ Data ที่เราจะส่งไปเป็นแบบ json
    Map<String, String> header = {"Content-type": "application/json"};
    //Data ที่จะส่ง
    String jsondata =
        '{"title":"${todo_title.text}", "detail":"${todo_detail.text}"}';
    // '{"title":"${todo_title.text}", "detail":"${todo_detail.text}"}';
    var response = await http.put(url, headers: header, body: jsondata);
    print('------result-------');
    print(response.body);
  }

  Future deleteTodo() async {
    var url =
        Uri.http('10.10.10.229:8000', '/api-62160148/delete_todolist/$_v1');
    //ประเภทของ Data ที่เราจะส่งไปเป็นแบบ json
    Map<String, String> header = {"Content-type": "application/json"};
    var response = await http.delete(url, headers: header);
    print('------result-------');
    print(response.body);
  }
}
