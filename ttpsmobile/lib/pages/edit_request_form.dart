import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:ttpsmobile/pages/home.dart';

class EditForm extends StatefulWidget {
  // const EditForm({ Key? key }) : super(key: key);

  // declear variable
  final v_id, v_sdate, v_edate, v_item, v_reason, v_tel, v_super, v_plant;
  const EditForm(this.v_id, this.v_sdate, this.v_edate, this.v_item,
      this.v_reason, this.v_tel, this.v_super, this.v_plant);

  @override
  _EditFormState createState() => _EditFormState();
}

class _EditFormState extends State<EditForm> {
  // ประกาศตัวแปร
  var _v1, _v2, _v3, _v4, _v5, _v6, _v7, _v8;

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
  ]; //ดึงข้อมูลจาก database มาใส่แทน
  List<String> approveplant = [
    'Plant 1',
    'Plant 2',
    'All Area'
  ]; //ดึงข้อมูลจาก database มาใส่แทน

  // function run to open edit page
  @override
  initState() {
    _datePickerController.selectedRanges = <PickerDateRange>[
      PickerDateRange(DateTime.now().subtract(Duration(days: 4)),
          DateTime.now().add(Duration(days: 4))),
      PickerDateRange(DateTime.now().add(Duration(days: 11)),
          DateTime.now().add(Duration(days: 16)))
    ];

    super.initState();
    // กำหนดค่าตัวแปร
    _v1 = widget.v_id;
    _v2 = widget.v_sdate;
    _v3 = widget.v_edate;
    _v4 = widget.v_item;
    _v5 = widget.v_reason;
    _v6 = widget.v_tel;
    _v7 = widget.v_super;
    _v8 = widget.v_plant;

    // ข้อมูลที่สามารถแก้ไขได้
    startdate.text = widget.v_sdate;
    enddate.text = widget.v_edate;
    item.text = widget.v_item;
    reason.text = widget.v_reason;
    tel.text = widget.v_tel;
    _getSuper = widget.v_super;
    _getPlant = widget.v_plant;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Tag Form"), actions: [
        IconButton(
            onPressed: () {
              // Modal Confirm Delete
              showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      height: 200,
                      color: Colors.white,
                      // color: Colors.amber[200],
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    child: new Image.network(
                                      'https://icon-library.com/images/delete-icon-png/delete-icon-png-19.jpg',
                                      height: 50,
                                      width: 100,
                                    ),
                                  ),
                                ]),
                            SizedBox(height: 5),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'Are you sure you want to delete?',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 20),
                                    textAlign: TextAlign.center,
                                  ),
                                ]),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                // ปุ่มยืนยันการลบ
                                ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.green)),
                                  child: const Text('Yes'),
                                  onPressed: () {
                                    print("Delete ID:$_v1");
                                    deleteList().then((value) {
                                      Navigator.pop(context);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => HomePage())
                                      );
                                    });
                                  },
                                ),
                                const SizedBox(width: 10),
                                // ปุ่มยกเลิกการลบ
                                ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.red)),
                                  child: const Text('No'),
                                  onPressed: () => Navigator.pop(context),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            },
            icon: Icon(Icons.delete_forever_outlined))
      ]
          // ปุ่มลบ
          // actions: [
          //   IconButton(
          //       onPressed: () {
          //         print("Delete ID:$_v1");
          //         deleteList().then((value) {
          //           Navigator.pop(context);
          //         });
          //       },
          //       icon: Icon(Icons.delete_forever_outlined))
          // ],
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
                    labelText: 'Date', border: OutlineInputBorder()),
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
                    labelText: 'Date', border: OutlineInputBorder()),
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
                      items: supervisor
                          .map<DropdownMenuItem<String>>((String value) {
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
                      items: approveplant
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                            value: value, child: Text(value));
                      }).toList())
                ],
              ),
              Padding(
                  padding: const EdgeInsets.all(20),
                  child: ElevatedButton(
                      onPressed: () {
                        print('-----input------');
                        print('start date: ${startdate.text}');
                        print('end date: ${enddate.text}');
                        print('item: ${item.text}');
                        print('reason: ${reason.text}');
                        print('tel: ${tel.text}');
                        print('supervisor: ${_getSuper}');
                        print('approve plant: ${_getPlant}');

                        putList().then((value) {
                          Navigator.pop(context);
                        });

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
                      child: Text("Save"),
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

  Future putList() async {
    var url = Uri.http('10.0.2.2:8000', '/api-team6/update-requestlist/$_v1');
    Map<String, String> header = {"Content-type": "application/json"};
    // Data ที่จะส่ง
    String jsondata =
        '{"startdate":"${startdate.text}", "enddate":"${enddate.text}", "item":"${item.text}", "reason":"${reason.text}", "tel":"${tel.text}", "supervisor":"${_getSuper}", "approveplant":"${_getPlant}"}';
    // เป็นการ response ค่าจาก PUT
    var response = await http.put(url, headers: header, body: jsondata);
    print("--------- result --------");
    print(response.body);
  }
  // End future putTodo

  Future deleteList() async {
    var url = Uri.http('10.0.2.2:8000', '/api-team6/delete-requestlist/$_v1');
    Map<String, String> header = {"Content-type": "application/json"};
    // เป็นการ response ค่าจาก Delete
    var response = await http.delete(url, headers: header);
    print("--------- result --------");
    print(response.body);
  }
  // End future postTodo

  // Modal
  // Future<T?> showModalBottomSheet<T>({
  //   required BuildContext context,
  //   required WidgetBuilder builder,
  //   Color? backgroundColor,
  //   double? elevation,
  //   ShapeBorder? shape,
  //   Clip? clipBehavior,
  //   BoxConstraints? constraints,
  //   Color? barrierColor,
  //   bool isScrollControlled = false,
  //   bool useRootNavigator = false,
  //   bool isDismissible = true,
  //   bool enableDrag = true,
  //   RouteSettings? routeSettings,
  //   AnimationController? transitionAnimationController,
  // }) {
  //   assert(context != null);
  //   assert(builder != null);
  //   assert(isScrollControlled != null);
  //   assert(useRootNavigator != null);
  //   assert(isDismissible != null);
  //   assert(enableDrag != null);
  //   assert(debugCheckHasMediaQuery(context));
  //   assert(debugCheckHasMaterialLocalizations(context));

  //   final NavigatorState navigator =
  //       Navigator.of(context, rootNavigator: useRootNavigator);
  //   return navigator.push(_ModalBottomSheetRoute<T>(
  //     builder: builder,
  //     capturedThemes:
  //         InheritedTheme.capture(from: context, to: navigator.context),
  //     isScrollControlled: isScrollControlled,
  //     barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
  //     backgroundColor: backgroundColor,
  //     elevation: elevation,
  //     shape: shape,
  //     clipBehavior: clipBehavior,
  //     constraints: constraints,
  //     isDismissible: isDismissible,
  //     modalBarrierColor: barrierColor,
  //     enableDrag: enableDrag,
  //     settings: routeSettings,
  //     transitionAnimationController: transitionAnimationController,
  //   ));
  // }

}
