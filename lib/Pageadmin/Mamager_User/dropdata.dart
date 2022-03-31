import 'package:day14/Pageadmin/Mamager_User/Show_Drop_User.dart';
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
  TextEditingController first_name = new TextEditingController();
  TextEditingController last_name = new TextEditingController();
  TextEditingController username = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController image_staff = new TextEditingController();
  TextEditingController name_position = new TextEditingController();

  void dropdata() {
    var url = "${IP().connect}/dropuser";
    http.post(Uri.parse(url), body: {
      "first_name": first_name.text,
      "last_name": last_name.text,
      "username": username.text,
      "password": password.text,
      // "image_staff": image_staff.text,
      "image_staff": "",
      "name_position": name_position.text,
    });
  }

  void deleteData() {
    var url = "${IP().connect}/delete/${widget.list[widget.index]['id_staff']}";
    http.delete(Uri.parse(url));
    //  ,body: {'id': widget.list[widget.index]['id']}
  }

  void confirm() {
    AlertDialog alertDialog = new AlertDialog(
      content: new Text(
          "Are You sure want to drop '${widget.list[widget.index]['username']}'"),
      actions: <Widget>[
        new RaisedButton(
          child: new Text(
            "OK drop!",
            style: new TextStyle(color: Colors.black),
          ),
          color: Colors.red,
          onPressed: () {
            dropdata();
            deleteData();
            Navigator.of(context).push(new MaterialPageRoute(
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
    name_position = TextEditingController(
        text: widget.list[widget.index]['name_position'].toString());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ระงับผู้ใช้ ${widget.list[widget.index]['username']}"),
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
                confirm();
              },
              child: Text(
                'DropUser',
                style: TextStyle(color: Colors.red, fontSize: 15),
              ),
            ),
          )
        ],
      ),
    );
  }
}
