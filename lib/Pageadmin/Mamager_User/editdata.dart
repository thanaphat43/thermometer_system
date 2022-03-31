import 'package:day14/Pageadmin/Mamager_User/Show_Drop_User.dart';
import 'package:day14/Pageadmin/Mamager_User/Show_Edit_User.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_mysql_crud/main.dart';
// import 'package:flutter_mysql_crud/pageAdmin/Mamager_User/Show_Drop_User.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../connect/ip.dart';

class Edit extends StatefulWidget {
  final List list;
  final int index;

  Edit({this.list, this.index});

  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  TextEditingController first_name = new TextEditingController();
  TextEditingController last_name = new TextEditingController();
  TextEditingController username = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController image_staff = new TextEditingController();
  TextEditingController id_position = new TextEditingController();
  TextEditingController name_position = new TextEditingController();

  void editData() {
    var url =
        "${IP().connect}/updeta_user/${widget.list[widget.index]['id_staff']}";
    http.put(Uri.parse(url), body: {
      "first_name": first_name.text,
      "last_name": last_name.text,
      "username": username.text,
      "password": password.text,
      "image_staff": image_staff.text,
      "id_position": id_position.text,
      "name_position": name_position.text,
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
    first_name =
        TextEditingController(text: widget.list[widget.index]['first_name']);
    last_name =
        TextEditingController(text: widget.list[widget.index]['last_name']);
    username =
        TextEditingController(text: widget.list[widget.index]['username']);
    password =
        TextEditingController(text: widget.list[widget.index]['password']);
    // image_staff =
    //     TextEditingController(text: widget.list[widget.index]['image_staff']);
    id_position = TextEditingController(
        text: widget.list[widget.index]['id_position'].toString());
    name_position = TextEditingController(
        text: widget.list[widget.index]['name_position'].toString());
    super.initState();
    this.getSWData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "แก้ไขของข้อมูลของ ${widget.list[widget.index]['first_name']},${widget.list[widget.index]['last_name']}"),
      ),
      body: ListView(
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
                        child: Text("แก้ไขของข้อมูลสมาชิก"),
                      ),
                      TextField(
                        controller: first_name,
                        decoration: InputDecoration(
                            hintText:
                                "${widget.list[widget.index]['first_name']}",
                            labelText: "ชื่อ"),
                      ),
                      TextField(
                        controller: last_name,
                        decoration: InputDecoration(
                            hintText:
                                "${widget.list[widget.index]['last_name']}",
                            labelText: "นามสกุล"),
                      ),
                      TextField(
                        controller: username,
                        decoration: InputDecoration(
                            hintText:
                                "${widget.list[widget.index]['username']}",
                            labelText: "Username"),
                      ),
                      TextField(
                        controller: password,
                        obscureText: true,
                        decoration: InputDecoration(
                            hintText:
                                "${widget.list[widget.index]['password']}",
                            labelText: "Password"),
                      ),
                      // Image.network(
                      //     // (list[i]['imageStaff'])
                      //     ('${widget.list[widget.index]['image_staff']}'),

                      //     // width: 300,
                      //     height: 150,
                      //     fit: BoxFit.fill),
                      // TextField(
                      //   controller: image_staff,
                      //   decoration: InputDecoration(
                      //       hintText:
                      //           "${widget.list[widget.index]['image_staff']}",
                      //       labelText: "รูปของสมาชิก"),
                      // ),
                      TextField(
                        controller: name_position,
                        decoration: InputDecoration(
                            hintText:
                                "${widget.list[widget.index]['name_position']}",
                            labelText: "ตำแหน่ง"),
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
                editData();
                Navigator.of(context).pop(
                  MaterialPageRoute(
                      builder: (BuildContext context) => new Show_Edit_User()),
                );
              },
              child: Text(
                'แก้ไขของข้อมูลสมาชิก',
                style: TextStyle(color: Colors.red, fontSize: 15),
              ),
            ),
          )
        ],
      ),
    );
  }
}
