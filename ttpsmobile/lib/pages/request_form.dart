import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class RequestForm extends StatefulWidget {
  //const FormHome({ Key? key }) : super(key: key);

  @override
  State<RequestForm> createState() => _RequestFormState();
}

class _RequestFormState extends State<RequestForm> {
  DateRangePickerController _datePickerController = DateRangePickerController();
  TextEditingController item = TextEditingController();
  TextEditingController Reson = TextEditingController();
  TextEditingController Tel = TextEditingController();
  String? _getText;
  String? _getText2;
  List<String> list = ['1', '2']; //ดึงข้อมูลจาก database มาใส่แทน
  List<String> list2 = ['3', '4']; //ดึงข้อมูลจาก database มาใส่แทน
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
              Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [Text('Date : ')],
                    ),
                    Row(
                      children: [
                        // Date()
                        ],
                    ),
                    SizedBox(height: 20,),
                    Row(
                      children: [Text('Item : ')],
                    ),
                    Row(
                      children: [buildItem()],
                    ),
                    SizedBox(height: 20,),
                    Row(
                      children: [Text('Reason : ')],
                    ),
                    Row(
                      children: [buildReason()],
                    ),
                    SizedBox(height: 20,),
                    Row(
                      children: [Text('Tel No. : ')],
                    ),
                    Row(
                      children: [buildTel()],
                    ),
                    SizedBox(height: 20,),
                    Row(
                      children: [
                        const Text('Supervisor : '),
                        buildSupervisor()
                      ],
                    ),
                    SizedBox(height: 20,),
                    Row(
                      children: [
                        const Text('Approve Plant : '),
                        buidApprovePlant()
                      ],
                    ),
                    //buildSubmitButton(),
                    // const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  @override
  Widget Date() {
    return SfDateRangePicker(
      view: DateRangePickerView.month,
      selectionMode: DateRangePickerSelectionMode.multiRange,
      controller: _datePickerController,
    );
  }

  Widget buildItem() {
    return SizedBox(
      width: 220,
      child: CupertinoTextField(controller: item),
    );
  }

  Widget buildReason() {
    return SizedBox(
      width: 220,
      child: CupertinoTextField(controller: Reson),
    );
  }

  Widget buildTel() {
    return SizedBox(
      width: 220,
      child: CupertinoTextField(controller: Tel),
    );
  }

  Widget buildSupervisor() {
    return DropdownButton<String>(
        hint: const Text(''),
        value: _getText,
        elevation: 16,
        style: const TextStyle(color: Colors.deepPurple),
        underline: Container(height: 2, color: Colors.deepPurpleAccent),
        onChanged: (String? newValue) {
          setState(() {
            _getText = newValue!;
          });
        },
        items: list.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(value: value, child: Text(value));
        }).toList()); //ดึงข้อมูลจากฐานข้อมูลมาใส่แทน
  }

  Widget buidApprovePlant() {
    return DropdownButton<String>(
        hint: const Text(''),
        value: _getText2,
        elevation: 16,
        style: const TextStyle(color: Colors.deepPurple),
        underline: Container(height: 2, color: Colors.deepPurpleAccent),
        onChanged: (String? newValue) {
          setState(() {
            _getText2 = newValue!;
          });
        },
        items: list2.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(value: value, child: Text(value));
        }).toList()); //ดึงข้อมูลจากฐานข้อมูลมาใส่แทน
  }
}
