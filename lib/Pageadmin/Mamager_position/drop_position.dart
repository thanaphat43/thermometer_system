import 'package:day14/Pageadmin/Mamager_User/Show_Drop_User.dart';
import 'package:day14/Pageadmin/Mamager_position/adminSetting_Position.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../connect/ip.dart';

class dropdata extends StatefulWidget {
  final List list;
  final int index;

  dropdata({this.list, this.index});

  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<dropdata> {
  TextEditingController name_position = new TextEditingController();

  void deleteData() {
    var url =
        "${IP().connect}/delete_staff_position/${widget.list[widget.index]['id_position']}";
    http.delete(Uri.parse(url));
    //  ,body: {'id': widget.list[widget.index]['id']}
  }

  void confirm() {
    AlertDialog alertDialog = new AlertDialog(
      content: new Text(
          "คุณต้องการลบหน่วยงานนี้ออกจากระบบใช่หรือไม่'${widget.list[widget.index]['name_position']}'"),
      actions: <Widget>[
        new RaisedButton(
          child: new Text(
            "OK drop!",
            style: new TextStyle(color: Colors.black),
          ),
          color: Colors.red,
          onPressed: () {
            deleteData();
            Navigator.of(context).pop(new MaterialPageRoute(
              builder: (BuildContext context) => new DropUser(),
            ));
          },
        ),
        new RaisedButton(
          child: new Text("CANCEL", style: new TextStyle(color: Colors.black)),
          color: Colors.green,
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );

    showDialog(builder: (context) => alertDialog, context: context);
  }

  @override
  void initState() {
    name_position = TextEditingController(
        text: widget.list[widget.index]['name_position'].toString());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text("ระงับผู้ใช้ ${widget.list[widget.index]['name_position']}"),
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
                        child: Text("ระงับผู้ใช้"),
                      ),
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
                // confirm();
                deleteData();
                Navigator.of(context).pop(
                  MaterialPageRoute(
                      builder: (BuildContext context) => new Manage_Position()),
                );
              },
              child: Text(
                'ลบหน่วยงาน',
                style: TextStyle(color: Colors.red, fontSize: 15),
              ),
            ),
          )
        ],
      ),
    );
  }
}
