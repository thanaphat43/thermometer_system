import 'package:day14/Pageadmin/Mamager_User/Show_Drop_User.dart';
import 'package:day14/Pageadmin/Manager_Room/ShowRoom_Drop.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_mysql_crud/main.dart';
// import 'package:flutter_mysql_crud/pageAdmin/Mamager_User/Show_Drop_User.dart';
// import 'package:flutter_mysql_crud/pageAdmin/Manager_Room/ShowRoom_Drop.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../connect/ip.dart';

// import '../../details copy.dart';

class dropdata_room extends StatefulWidget {
  final List list;
  final int index;

  dropdata_room({this.list, this.index});

  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<dropdata_room> {
  TextEditingController drop_room_name = new TextEditingController();
  TextEditingController drop_image_room = new TextEditingController();
  TextEditingController drop_api_degrees = new TextEditingController();
  TextEditingController drop_id_position = new TextEditingController();

  void dropdata() {
    var url = "${IP().connect}/drop_room";
    http.post(Uri.parse(url), body: {
      "drop_room_name": drop_room_name.text,
      "drop_image_room": drop_image_room.text,
      "drop_api_degrees": drop_api_degrees.text,
      "drop_id_position": drop_id_position.text,
    });
  }

  void deleteData() {
    var url =
        "${IP().connect}/delete_room/${widget.list[widget.index]['room_id']}";
    http.delete(Uri.parse(url));
    //  ,body: {'id': widget.list[widget.index]['id']}
  }

  void confirm() {
    AlertDialog alertDialog = new AlertDialog(
      content: new Text(
          "Are You sure want to delete '${widget.list[widget.index]['room_id']}'"),
      actions: <Widget>[
        new RaisedButton(
          child: new Text(
            "OK DELETE!",
            style: new TextStyle(color: Colors.black),
          ),
          color: Colors.red,
          onPressed: () {
            dropdata();
            deleteData();
            Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) => new Home_room_Drop(),
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

  String _mySelection;

  List data = List(); //edited line

  Future<String> getSWData() async {
    final String url = "${IP().connect}/staff_position_room/";
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
    drop_room_name =
        TextEditingController(text: widget.list[widget.index]['room_name']);
    drop_image_room =
        TextEditingController(text: widget.list[widget.index]['image_room']);
    drop_api_degrees =
        TextEditingController(text: widget.list[widget.index]['api_degrees']);
    drop_id_position = TextEditingController(
        text: widget.list[widget.index]['id_position'].toString());

    super.initState();
    this.getSWData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ระงับสถานที่ ${widget.list[widget.index]['room_name']}"),
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
                        child: Text("ระงับสถานที่"),
                      ),
                      TextField(
                        controller: drop_room_name,
                        decoration: InputDecoration(
                            hintText:
                                "${widget.list[widget.index]['room_name']}",
                            labelText: "ชื่อสถานที่"),
                      ),
                      TextField(
                        controller: drop_image_room,
                        decoration: InputDecoration(
                            hintText:
                                "${widget.list[widget.index]['image_room']}",
                            labelText: "รูปสถานที่"),
                      ),
                      TextField(
                        controller: drop_api_degrees,
                        decoration: InputDecoration(
                            hintText:
                                "${widget.list[widget.index]['api_degrees']}",
                            labelText: "Apiที่รับข้อมูล"),
                      ),
                      Text('หน่วยงานที่เป็นเจ้าของสถานที่'),
                      TextField(
                        controller: drop_id_position,
                        decoration: InputDecoration(
                            hintText:
                                "${widget.list[widget.index]['id_position']}",
                            labelText: "id_position"),
                      ),
                      // MaterialButton(
                      //   child: Text("Drop Room"),
                      //   onPressed: () {
                      //     confirm();
                      //   },
                      // )
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
                'ระงับสถานที่',
                style: TextStyle(color: Colors.red, fontSize: 15),
              ),
            ),
          )
        ],
      ),
    );
  }
}
