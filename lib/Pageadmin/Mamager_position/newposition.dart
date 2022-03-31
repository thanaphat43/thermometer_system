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

class AddPosition extends StatefulWidget {
  @override
  _AddDataState createState() => new _AddDataState();
}

class _AddDataState extends State<AddPosition> {
  TextEditingController name_position = new TextEditingController();
  // TextEditingController id_position = new TextEditingController();

  void confirm() {
    AlertDialog alertDialog = new AlertDialog(
      content:
          new Text("คุณต้องการเพิ่มหน่วยงาน'${name_position.text}'ใช่หรือไหม"),
      actions: <Widget>[
        new RaisedButton(
          child: new Text(
            "เพิ่มหน่วย",
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
    var url = "${IP().connect}/add_staff_position";

    http.post(Uri.parse(url), body: {
      "name_position": name_position.text,
    });
  }

  void check_position() async {
    String apiurl = "${IP().connect}/check_staff_position";

    print(name_position);

    var response = await http.post(Uri.parse(apiurl), body: {
      'name_position': name_position.text, //get the username text
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
              title: "ชื่อหน่วยงานใช้งานไปแล้ว",
            ),
          );
        });
      } else if (name_position.text == null) {
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
              title: "คุณได้เพิ่มหน่วยงาน${name_position.text}สำเร็จ",
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
        title: new Text("เพิ่มหน่วยงาน"),
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
                          child: Text("เพิ่มหน่วยงาน"),
                        ),
                        new TextField(
                          controller: name_position,
                          decoration: new InputDecoration(
                            hintText: "เพิ่มหน่วยงาน",
                            labelText: "เพิ่มหน่วยงาน",
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
                  'เพิ่มหน่วยงาน',
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
