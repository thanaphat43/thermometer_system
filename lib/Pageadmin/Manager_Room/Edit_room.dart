import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:day14/Pageadmin/Mamager_User/Show_Drop_User.dart';
import 'package:day14/Pageadmin/Manager_Room/ShowRoom_Edit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_mysql_crud/main.dart';
// import 'package:flutter_mysql_crud/pageAdmin/Mamager_User/Show_Drop_User.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sweetalert/sweetalert.dart';

import '../../connect/ip.dart';

class Edit_room extends StatefulWidget {
  final List list;
  final int index;

  Edit_room({this.list, this.index});

  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit_room> {
  TextEditingController room_name = new TextEditingController();
  TextEditingController image_room = new TextEditingController();
  TextEditingController api_degrees = new TextEditingController();

  void editData() {
    var url =
        "${IP().connect}/updeta_room/${widget.list[widget.index]['room_id']}";

    http.put(Uri.parse(url), body: {
      "room_name": room_name.text,
      "image_room": image_room.text,
      "sensor_id": _mySelection2,
      "id_position": _mySelection,
    });
  }

  void check_data() async {
    String apiurl = "${IP().connect}/check_room_name";

    print(api_degrees);

    var response = await http.post(Uri.parse(apiurl), body: {
      'room_name': room_name.text, //get the api_degrees text
    });

    if (response.statusCode == 200) {
      // var jsondata = json.decode(response.body);
      var jsondata = await json.decode(json.encode(response.body));

      print(jsondata);
      if (jsondata != 'ใช้งานได้') {
        setState(() {
          SweetAlert.show(
            context,
            title: "ใช้งานไปแล้ว",
          );
        });
      } else if (room_name.text == null ||
          image_room.text == null ||
          _mySelection2 == null ||
          _mySelection == null) {
        ArtSweetAlert.show(
          context: context,
          artDialogArgs: ArtDialogArgs(
            type: ArtSweetAlertType.danger,
            title: "กรุณาใส่เพิ่ม",
          ),
        );
        SweetAlert.show(
          context,
          title: "กรุณาใส่เพิ่ม",
        );
      } else {
        setState(() {
          editData();
        });
      }
    }
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
    room_name =
        TextEditingController(text: widget.list[widget.index]['room_name']);
    image_room =
        TextEditingController(text: widget.list[widget.index]['image_room']);

    super.initState();
    this.getSWData();
    this.getSWData2();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("แก้ไขสถานที่ ${widget.list[widget.index]['room_name']}"),
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
                        child: Text("แก้ไขสถานที่"),
                      ),
                      TextField(
                        controller: room_name,
                        decoration: InputDecoration(
                            hintText:
                                "${widget.list[widget.index]['room_name']}",
                            labelText: "ชื่อสถานที่"),
                      ),
                      TextField(
                        controller: image_room,
                        decoration: InputDecoration(
                            hintText:
                                "${widget.list[widget.index]['image_room']}",
                            labelText: "รูปสถานที่"),
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

                      // MaterialButton(
                      //   child: Text("Edit Data"),
                      //   onPressed: () {
                      //     check_data();
                      //     Navigator.of(context).pop(
                      //       MaterialPageRoute(
                      //           builder: (BuildContext context) => new Home2()),
                      //     );
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
                editData();
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (BuildContext context) => Home_room_Edit()),
                );
              },
              child: Text(
                'ตกลง',
                style: TextStyle(color: Colors.red, fontSize: 15),
              ),
            ),
          )
        ],
      ),
    );
  }
}
