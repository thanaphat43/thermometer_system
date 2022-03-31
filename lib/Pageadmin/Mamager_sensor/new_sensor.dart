import 'dart:convert';
import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:day14/Pageadmin/Mamager_User/Search_user.dart';
import 'package:day14/Pageadmin/Mamager_User/Show_Drop_User.dart';
import 'package:day14/Pageadmin/Mamager_User/adminSetting_User.dart';
import 'package:day14/Pageadmin/Mamager_position/adminSetting_Position.dart';
import 'package:day14/Pageadmin/ManageRoom/ShowUser.dart';
import 'package:flutter/material.dart';
import 'package:sweetalert/sweetalert.dart';
// import 'package:flutter_mysql_crud/pageAdmin/Mamager_User/Show_Drop_User.dart';
import 'package:http/http.dart' as http;

import '../../connect/ip.dart';

class AddSensor extends StatefulWidget {
  @override
  _AddDataState createState() => new _AddDataState();
}

class _AddDataState extends State<AddSensor> {
  TextEditingController sensor_id = new TextEditingController();
  TextEditingController sensor_name = new TextEditingController();

  void confirm() {
    AlertDialog alertDialog = new AlertDialog(
      content: new Text("คุณต้องการเพิ่มsensor'${sensor_name.text}'ใช่หรือไหม"),
      actions: <Widget>[
        new RaisedButton(
          child: new Text(
            "เครื่องวัดอุณหภูมิ(sensor)",
            style: new TextStyle(color: Colors.black),
          ),
          color: Colors.green,
          onPressed: () {
            check_position();
          },
        ),
        new RaisedButton(
          child: new Text("CANCEL", style: new TextStyle(color: Colors.black)),
          color: Colors.white,
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );

    showDialog(builder: (context) => alertDialog, context: context);
  }

  void addData() {
    var url = "${IP().connect}/add_sensor";

    http.post(Uri.parse(url), body: {
      "sensor_id": sensor_id.text,
      "sensor_name": sensor_name.text,
    });
  }

  void check_position() async {
    String apiurl = "${IP().connect}/check_sensor";

    print(sensor_name);

    var response = await http.post(Uri.parse(apiurl), body: {
      'sensor_name': sensor_name.text, //get the username text
    });

    if (response.statusCode == 200) {
      // var jsondata = json.decode(response.body);
      var jsondata = await json.decode(json.encode(response.body));

      print(jsondata);
      if (jsondata != 'ใช้งานได้') {
        setState(() {
          ArtSweetAlert.show(
            context: context,
            artDialogArgs: ArtDialogArgs(
              type: ArtSweetAlertType.danger,
              title: "ชื่อวัดอุณหภูมินี้ใช้งานไปแล้ว",
            ),
          );
        });
      } else if (sensor_name.text == null) {
        ArtSweetAlert.show(
          context: context,
          artDialogArgs: ArtDialogArgs(
            type: ArtSweetAlertType.danger,
            title: "กรุณาใส่เพิ่ม",
          ),
        );
      } else {
        setState(() {
          addData();
          SweetAlert.show(context,
              title:
                  "คุณได้เครื่องวัดอุณหภูมิ(sensor)${sensor_name.text}สำเร็จ",
              style: SweetAlertStyle.success);
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("เพิ่มSensor"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            SizedBox(
              height: 30,
            ),
            Center(
              child: Card(
                child: InkWell(
                  splashColor: Colors.blue.withAlpha(30),
                  child: Container(
                    margin: const EdgeInsets.all(10.0),
                    // color: Colors.amber[600],
                    width: 350.0,
                    child: Column(
                      children: [
                        Container(
                          child: Text("เพิ่มSensor"),
                        ),
                        new TextField(
                          controller: sensor_id,
                          decoration: new InputDecoration(
                            hintText: "id_sensor",
                            labelText: "id_sensor",
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                        new TextField(
                          controller: sensor_name,
                          decoration: new InputDecoration(
                            hintText: "ชื่อsensor",
                            labelText: "ชื่อsensor",
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                        new Padding(
                          padding: const EdgeInsets.all(10.0),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: 20,
              height: 60,
              child: FlatButton(
                onPressed: () {
                  confirm();
                },
                child: Text(
                  'เพิ่มเครื่องวัดอุณหภูมิ(sensor)',
                  style: TextStyle(color: Colors.red, fontSize: 15),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
