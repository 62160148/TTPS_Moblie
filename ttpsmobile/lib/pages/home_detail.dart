import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class FormHome extends StatefulWidget {
  //const FormHome({ Key? key }) : super(key: key);

  @override
  State<FormHome> createState() => _FormHomeState();
}

class _FormHomeState extends State<FormHome> {
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
        title: Text("แบบฟอร์มขออนุญาตวางของ"),
      ),
      body: Form(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [const Text('Date : '), Date()],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [const Text('Item : '), buildItem()],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [const Text('Reason : '), buildReason()],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [const Text('Tel No. : '), buildTel()],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [const Text('Supervisor : '), buildSupervisor()],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [const Text('Approve Plant : '), buidApprovePlant()],
            ),
            //buildSubmitButton(),
            // const SizedBox(height: 20),
          ],
        ),
      ),
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
