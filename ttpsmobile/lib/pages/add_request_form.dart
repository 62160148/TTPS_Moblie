import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class RequestForm extends StatefulWidget {
  const RequestForm({ Key? key }) : super(key: key);

  @override
  State<RequestForm> createState() => _RequestFormState();
}

class _RequestFormState extends State<RequestForm> {
  final format = DateFormat("yyyy-MM-dd");
  DateRangePickerController _datePickerController = DateRangePickerController();
  TextEditingController item = TextEditingController();
  TextEditingController reason = TextEditingController();
  TextEditingController tel = TextEditingController();
  TextEditingController startdate = TextEditingController();
  TextEditingController enddate = TextEditingController();

  String? _getSuper;
  String? _getPlant;
  List<String> supervisor = [
    'Chakrit Boonprasert',
    'Niphat Kuhoksiw ',
    'Ponprapai Atsawanurak ',
    'Apinya Phadungkit',
    'Thitima Popila',
    'Phatchara Khongthandee',
    'Natthanic Ploempool',
    'Nattakorn Noikerd',
    'Jaraspon Seallo',
    'Pontakon Munjit',
    'Jirayut Saifah'
  ]; 
  List<String> approveplant = [
    'Plant 1',
    'Plant 2',
    'All Area'
  ]; 

  @override
  initState() {
    _datePickerController.selectedRanges = <PickerDateRange>[
      PickerDateRange(DateTime.now().subtract(Duration(days: 4)),
          DateTime.now().add(Duration(days: 4))),
      PickerDateRange(DateTime.now().add(Duration(days: 11)),
          DateTime.now().add(Duration(days: 16)))
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Request Tag Form"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Column(children: <Widget>[
              Image.asset(
                'assets/images/bg_box1.jpg',
                width: 200,
              ),
              SizedBox(height: 10),
              DateTimeField(
                // cursorWidth: 50,
                format: format,
                controller: startdate,
                decoration: InputDecoration(
                    labelText: 'Start Date', border: OutlineInputBorder()),
                onShowPicker: (context, currentValue) {
                  return showDatePicker(
                      context: context,
                      firstDate: DateTime(1900),
                      initialDate: currentValue ?? DateTime.now(),
                      lastDate: DateTime(2100));
                },
              ),
              SizedBox(
                height: 15,
              ),
              DateTimeField(
                // cursorWidth: 50,
                format: format,
                controller: enddate,
                decoration: InputDecoration(
                    labelText: 'End Date', border: OutlineInputBorder()),
                onShowPicker: (context, currentValue) {
                  return showDatePicker(
                      context: context,
                      firstDate: DateTime(1900),
                      initialDate: currentValue ?? DateTime.now(),
                      lastDate: DateTime(2100));
                },
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                controller: item,
                decoration: InputDecoration(
                  labelText: 'Item',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                controller: reason,
                decoration: InputDecoration(
                  labelText: 'Reason',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                controller: tel,
                decoration: InputDecoration(
                  labelText: 'Tel No',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Text('Supervisor : '),
                  DropdownButton<String>(
                      hint: const Text(''),
                      value: _getSuper,
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      underline:
                          Container(height: 2, color: Colors.deepPurpleAccent),
                      onChanged: (String? newValue) {
                        setState(() {
                          _getSuper = newValue!;
                        });
                      },
                      items: supervisor.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                            value: value, child: Text(value));
                      }).toList())
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Text('Approve Plant : '),
                  DropdownButton<String>(
                      hint: const Text(''),
                      value: _getPlant,
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      underline:
                          Container(height: 2, color: Colors.deepPurpleAccent),
                      onChanged: (String? newValue) {
                        setState(() {
                          _getPlant = newValue!;
                        });
                      },
                      items:
                          approveplant.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                            value: value, child: Text(value));
                      }).toList())
                ],
              ),
              Padding(
                  padding: const EdgeInsets.all(20),
                  child: ElevatedButton(
                      onPressed: () {

                        print('----- input -----');
                        print('start date: ${startdate.text}');
                        print('end date: ${enddate.text}');
                        print('item: ${item.text}');
                        print('reason: ${reason.text}');
                        print('tel: ${tel.text}');
                        print('supervisor: ${_getSuper}');
                        print('approveplant: ${_getPlant}');

                        postList();

                        setState(() {
                          //เคลีบร์ข้อมูลหลังจากโพสต์
                          startdate.clear(); 
                          enddate.clear();
                          item.clear(); 
                          reason.clear();
                          tel.clear();
                          supervisor.clear();
                          approveplant.clear();
                        });
                      },
                      child: Text("Submit"),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green),
                          padding: MaterialStateProperty.all(
                              EdgeInsets.fromLTRB(50, 10, 50, 10)),
                          textStyle: MaterialStateProperty.all(
                              TextStyle(fontSize: 20))))),
            ])
          ],
        ),
      ),
    );
  }

  Future postList() async {
    var url = Uri.http('10.0.2.2:8000', '/api-team6/post-requestlist/');
    Map<String, String> header = {"Content-type": "application/json"};
    String jsondata =
        '{"startdate":"${startdate.text}", "enddate":"${enddate.text}", "item":"${item.text}"}, "reason":"${reason.text}"}, "tel":"${tel.text}"}, "supervisor":"${_getSuper}"}, "approveplant":"${_getPlant}"}';
    var response = await http.post(url, headers: header, body: jsondata);
    print("--------- result --------");
    print(response.body);
  }

}
