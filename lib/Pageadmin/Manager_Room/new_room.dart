import 'dart:convert';

import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:day14/Pageadmin/Manager_Room/Showuser2.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_mysql_crud/pageAdmin/Mamager_User/Show_Drop_User.dart';
import 'package:http/http.dart' as http;
import 'package:sweetalert/sweetalert.dart';

import '../../connect/ip.dart';
import 'adminSetting_Room.dart';

class Add_Room2 extends StatefulWidget {
  @override
  _AddDataState createState() => new _AddDataState();
}

class _AddDataState extends State<Add_Room2> {
  TextEditingController room_name = new TextEditingController();
  TextEditingController image_room = new TextEditingController();
  TextEditingController name_position = new TextEditingController();
  void check_room() async {
    String apiurl = "${IP().connect}/check_room_name";
    var response = await http.post(Uri.parse(apiurl), body: {
      'room_name': room_name.text, //get the api_degrees text
    });
    if (response.statusCode == 200) {
      var jsondata = await json.decode(json.encode(response.body));
      print(jsondata);
      if (jsondata != 'ใช้งานได้') {
        setState(() {
          SweetAlert.show(
            context,
            title: "สถานที่นี้ใช้งานไปแล้ว",
          );
        });
      } else if (room_name.text == null ||
          name_position.text == null ||
          _mySelection == null ||
          _mySelection2 == null) {
        SweetAlert.show(
          context,
          title: "กรุณาใส่ข้อมูลเพิ่ม",
        );
      } else {
        setState(() {
          addData();
          Navigator.of(context).pop(new MaterialPageRoute(
            builder: (BuildContext context) => new Manage_Room(),
          ));
          SweetAlert.show(
            context,
            title: "เพิ่มสถานที่ ${room_name.text} สำเร็จ",
          );
        });
      }
    }
  }

  void addData() {
    var url = "${IP().connect}/addroom";
    http.post(Uri.parse(url), body: {
      "room_name": room_name.text,
      "image_room": image_room.text,
      "sensor_id": _mySelection2,
      "id_position": _mySelection,
    });
  }

  String _mySelection;
  final String url = "${IP().connect}/staff_position_room";
  List data = List(); //edited line
  Future<String> getSWData() async {
    var res = await http.get(Uri.parse(url));
    var resBody = json.decode(res.body);
    setState(() {
      data = resBody;
    });
    return "Sucess";
  }

  String _mySelection2;
  final String url2 = "${IP().connect}/sensor";
  List data2 = List(); //edited line
  Future<String> getSWData2() async {
    var res2 = await http.get(Uri.parse(url2));
    var resBody2 = json.decode(res2.body);
    setState(() {
      data2 = resBody2;
    });
    print(resBody2);
    return "Sucess";
  }

  @override
  void initState() {
    super.initState();
    this.getSWData();
    this.getSWData2();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("เพื่มสถานที่ที่ใช้งาน"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            new Column(
              children: <Widget>[
                new TextField(
                  controller: room_name,
                  decoration: new InputDecoration(
                      hintText: "ชื่อสถานที่", labelText: "ชื่อสถานที่"),
                ),
                // new TextField(
                //   controller: image_room,
                //   decoration: new InputDecoration(
                //       hintText: "รูปสถานที่", labelText: "รูปสถานที่"),
                // ),
                SizedBox(
                  height: 15,
                ),
                Text('หน่วยงานที่เป็นเจ้าของสถานที่'),
                new DropdownButton(
                  items: data.map((item) {
                    return new DropdownMenuItem(
                      child: new Text(item['name_position']),
                      value: item['id_position'].toString(),
                    );
                  }).toList(),
                  onChanged: (newVal) {
                    setState(() {
                      _mySelection = newVal;
                    });
                  },
                  value: _mySelection,
                ),
                SizedBox(
                  height: 15,
                ),
                Text('Sersorสถานที่'),
                new DropdownButton(
                  items: data2.map((item) {
                    return new DropdownMenuItem(
                      child: new Text(item['sensor_name']),
                      value: item['sensor_id'].toString(),
                    );
                  }).toList(),
                  onChanged: (newVal) {
                    setState(() {
                      _mySelection2 = newVal;
                    });
                  },
                  value: _mySelection2,
                ),
                new Padding(
                  padding: const EdgeInsets.all(10.0),
                ),
                new RaisedButton(
                  child: new Text("เพิ่มสถานที่ที่ใช้งาน"),
                  color: Colors.blueAccent,
                  onPressed: () {
                    check_room();
                    // addData();
                    Navigator.of(context).pop(new MaterialPageRoute(
                      builder: (BuildContext context) => new Home3(),
                    ));
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
