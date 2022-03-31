import 'dart:convert';

import 'package:art_sweetalert/art_sweetalert.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;

import '../../connect/ip.dart';
//import http package manually

class Datetime_one_day extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _datetime_one_day();
  }
}

class _datetime_one_day extends State<Datetime_one_day> {
  String errormsg;
  bool error, showprogress;
  String datetime1, password;

  var _datetime1 = TextEditingController();
  var _password = TextEditingController();

  startLogin() async {
    String apiurl = "${IP().connect}/get_tb_temp_datetime_one_day";

    var response = await http.post(Uri.parse(apiurl), body: {
      'datetime1': datetime1, //get the username text
    });
    var data = await json.decode(response.body);
    print(data);

    if (data != "No") {
      ArtSweetAlert.show(
          context: context,
          artDialogArgs: ArtDialogArgs(
              title: "Sweet!",
              text: "Modal with a custom image.",
              customColumns: [
                Container(
                  margin: EdgeInsets.only(bottom: 12.0),
                  child: Expanded(
                    child: Text(
                      "อุณหภูมิ " + data[0]['temp_temperature'].toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 12.0),
                  child: Expanded(
                    child: Text(
                      "ความชื้น " + data[0]['temp_humidity'].toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ]));
    } else {
      ArtSweetAlert.show(
          context: context,
          artDialogArgs: ArtDialogArgs(
              title: "Sweet!",
              text: "อาจมีข้อผิดพลาดในการใส่ข้อมูล",
              customColumns: [
                Container(
                  margin: EdgeInsets.only(bottom: 12.0),
                  child: Expanded(
                    child: Text(
                      "อุณหภูมิ ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ]));
      print('No');
    }
  }

  @override
  void initState() {
    datetime1 = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent
            //color set to transperent or set your own color
            ));

    return Scaffold(
      body: Container(
        width: 300,
        child: Column(
          //สร้าง Child ซึ่งเป็นcloumn
          children: <Widget>[
            //สร้าง childen สำหรับ widget
            Padding(
              //สร้างpadding
              padding: const EdgeInsets.only(top: 0.0),
              child: Text('กรุณากรอกตามตัวอย่าง' + '"2021-12-13 12:42:37"',
                  style: TextStyle(color: Colors.black, fontSize: 15)),
            ),
            SizedBox(height: 15),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: _datetime1,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'วัน-เวลาที่ต้องการดูอุณหภูมิและความชื้น',
                    hintText: 'วัน-เวลา '),
                onChanged: (value) {
                  datetime1 = value;
                },
              ),
            ),
            SizedBox(height: 15),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: FlatButton(
                onPressed: () {
                  if (datetime1 == null || datetime1.isEmpty) {
                    ArtSweetAlert.show(
                        context: context,
                        artDialogArgs: ArtDialogArgs(
                          type: ArtSweetAlertType.danger,
                          title: "กรุณาใส่วัน/เดือน/ปีให้ครบ",
                        ));
                  } else {
                    startLogin();
                  }
                },
                child: Text(
                  'ตกลง',
                  style: TextStyle(color: Colors.blue, fontSize: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
