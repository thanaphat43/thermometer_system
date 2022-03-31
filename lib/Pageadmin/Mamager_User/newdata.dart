import 'dart:convert';

import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:day14/Pageadmin/Mamager_User/Search_user.dart';
import 'package:day14/Pageadmin/Mamager_User/Show_Drop_User.dart';
import 'package:day14/Pageadmin/Mamager_User/adminSetting_User.dart';
import 'package:day14/Pageadmin/ManageRoom/ShowUser.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_mysql_crud/pageAdmin/Mamager_User/Show_Drop_User.dart';
import 'package:http/http.dart' as http;
import 'package:sweetalert/sweetalert.dart';

import '../../connect/ip.dart';

class AddData extends StatefulWidget {
  @override
  _AddDataState createState() => new _AddDataState();
}

class _AddDataState extends State<AddData> {
  TextEditingController first_name = new TextEditingController();
  TextEditingController last_name = new TextEditingController();
  TextEditingController username = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController image_staff = new TextEditingController();
  TextEditingController name_position = new TextEditingController();
  // TextEditingController id_position = new TextEditingController();

  void confirm() {
    AlertDialog alertDialog = new AlertDialog(
      content:
          new Text("คุณต้องการเพิ่ม '${username.text}'เป็นสมาชิกใช่หรือไหม"),
      actions: <Widget>[
        new RaisedButton(
          child: new Text(
            "ใช่ต้องการเพิ่ม",
            style: new TextStyle(color: Colors.black),
          ),
          color: Colors.red,
          onPressed: () {
            check_user();
            Navigator.of(context).pop(new MaterialPageRoute(
              builder: (BuildContext context) => new Search_user(),
            ));
          },
        ),
        new RaisedButton(
          child: new Text("ไม่ต้องการเพิ่ม",
              style: new TextStyle(color: Colors.black)),
          color: Colors.green,
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );

    showDialog(builder: (context) => alertDialog, context: context);
  }

  void check_user() async {
    String apiurl = "${IP().connect}/check_username";

    print(username);

    var response = await http.post(Uri.parse(apiurl), body: {
      'username': username.text, //get the username text
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
              title: "Username นี้มีผู้ใช้งานไปแล้ว",
            ),
          );
        });
      } else if (first_name.text == null ||
          last_name.text == null ||
          username.text == null ||
          // image_staff.text == null ||
          name_position.text == null ||
          _mySelection == null) {
        SweetAlert.show(
          context,
          title: "กรุณาใส่ข้อมูลเพิ่ม",
        );
      } else {
        setState(() {
          addData();
          Navigator.of(context).pop(new MaterialPageRoute(
            builder: (BuildContext context) => new Search_user(),
          ));
          SweetAlert.show(
            context,
            title: "เพิ่ม ${first_name.text} สำเร็จ",
          );
        });
      }
    }
  }

  void addData() {
    var url = "${IP().connect}/adduser";

    http.post(Uri.parse(url), body: {
      "first_name": first_name.text,
      "last_name": last_name.text,
      "username": username.text,
      "password": password.text,
      // "image_staff": image_staff.text,
      "image_staff": "",
      "name_position": name_position.text,
      "id_position": _mySelection,
    });
  }

  String _mySelection;

  final String url = "${IP().connect}/staff_position_room";

  List data = List(); //edited line

  Future<String> getSWData() async {
    var res = await http.get(Uri.parse(url)
        // , headers: {"Accept": "application/json"}
        );
    var resBody = json.decode(res.body);

    setState(() {
      data = resBody;
    });

    print(resBody);

    return "Sucess";
  }

  @override
  void initState() {
    super.initState();
    this.getSWData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("เพิ่มสมาชิก"),
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
                          child: Text("เพิ่มสมาชิก"),
                        ),
                        TextField(
                          controller: first_name,
                          decoration: InputDecoration(
                            hintText: "ชื่อ",
                            labelText: "ชื่อ",
                          ),
                        ),
                        TextField(
                          controller: last_name,
                          decoration: new InputDecoration(
                              hintText: "นามสกุล", labelText: "นามสกุล"),
                        ),
                        new TextField(
                          controller: username,
                          decoration: new InputDecoration(
                              hintText: "username", labelText: "username"),
                        ),
                        new TextField(
                          controller: password,
                          obscureText: true,
                          decoration: new InputDecoration(
                              hintText: "password", labelText: "password"),
                        ),
                        // new TextField(
                        //   controller: image_staff,
                        //   decoration: new InputDecoration(
                        //       hintText: "รูปสมาชิก", labelText: "รูปสมาชิก"),
                        // ),
                        new TextField(
                          controller: name_position,
                          decoration: new InputDecoration(
                            hintText: "ตำแหน่งของสมาชิก",
                            labelText: "ตำแหน่งของสมาชิก",
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Text('หน่วยงาน'),
                        SizedBox(
                          height: 25,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 2,
                          color: Colors.grey[100],
                          padding: const EdgeInsets.all(2.0),
                          child: DropdownButton(
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
                  // Navigator.of(context).pop(
                  //   MaterialPageRoute(
                  //       builder: (BuildContext context) => Manage_User()),
                  // );
                },
                child: Text(
                  'เพิ่มสมาชิก',
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
