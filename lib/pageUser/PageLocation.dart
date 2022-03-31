import 'package:day14/pageUser/Table.dart';
import 'package:day14/pageUser/chart.dart';
import 'package:day14/pageUser/chart/Calendar.dart';
import 'package:day14/pageUser/chart/chaeck_datetime.dart';
import 'package:day14/pageUser/chart/chart.dart';
import 'package:day14/pageUser/chart/last_data.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../connect/ip.dart';

class PageRoom extends StatefulWidget {
  PageRoom({this.list, this.index});
  List list;
  int index;

  @override
  _PageRoomState createState() => _PageRoomState();
}

class _PageRoomState extends State<PageRoom> {
  TextEditingController room_id = new TextEditingController();
  TextEditingController id_staff = new TextEditingController();
  TextEditingController sensor_id = new TextEditingController();
  TextEditingController prescribe_temp = new TextEditingController();
  TextEditingController id_position = new TextEditingController();
  // int id_position;
  // int id_staff;
  String name_position;
  dynamic dataRoom;
  dynamic dataNotify;
  Future<List> getData() async {
    final responce = await http.get(Uri.parse(
        "${IP().connect}/apiroom_id/${widget.list[widget.index].roomId}"));
    var data = await json.decode(responce.body);
    final gettemp = await http.get(Uri.parse(
        '${IP().connect}/get_tb_temp_notify_position/${widget.list[widget.index].roomId}'));
    var data2 = await json.decode(gettemp.body);
    if (this.mounted) {
      setState(() {
        dataRoom = data;
        dataNotify = data2;
      });
    }
    return jsonDecode(responce.body);
  }

  void add_notify() {
    var url = "${IP().connect}/set_tb_temp_notify";

    http.post(Uri.parse(url), body: {
      "room_id": "${dataRoom[0]['room_id']}",
      "sensor_id": "${dataRoom[0]['sensor_id']}",
      "prescribe_temp": prescribe_temp.text,
      "id_position": "${dataRoom[0]['id_position']}",
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.orange,
      appBar: AppBar(
        title: Text('ตรวจวัดอุณหภูมิห้อง'),
        // backgroundColor: Colors.orange[900],
        automaticallyImplyLeading: true,
        actions: [
          Container(
            // color: Colors.black,
            child: FlatButton(
              child: Text(
                "ตั้งค่าแจ้งเตือนอุณหภูมิ",
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        scrollable: true,
                        title: Text('ตั้งค่าแจ้งเตือนอุณหภูมิ'),
                        content: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Form(
                            child: Column(
                              children: <Widget>[
                                new TextField(
                                  controller: prescribe_temp,
                                  decoration: new InputDecoration(
                                    hintText: "กำหนดองศา",
                                    labelText:
                                        "${dataNotify?.length > 0 ? dataNotify[0]['prescribe_temp'] : ''}",
                                    hintStyle: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        actions: [
                          FlatButton(
                              child: Text("Submit"),
                              onPressed: () {
                                // your code
                                add_notify();
                                Navigator.pop(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PageRoom(),
                                  ),
                                );
                              })
                        ],
                      );
                    });
              },
            ),
          ),
        ],
      ),

      body: FutureBuilder<List>(
        future: getData(),
        builder: (ctx, ss) {
          if (ss.hasError) {
            print("error");
          }
          if (ss.hasData) {
            return Items(list: ss.data);
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}

class Items extends StatelessWidget {
  List list;

  Items({this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list == null ? 0 : list.length,
        itemBuilder: (ctx, i) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            width: 500,
            child: Column(
              children: <Widget>[
                bulidTitel("${list[i]['room_name']}"), // )
                bulid_last("${list[i]['sensor_id']}/${list[i]['room_id']}"),
                buildDisplaychat(
                    "${list[i]['sensor_id']}/${list[i]['room_id']}"), //
                buildDisplayTable(
                    "${list[i]['sensor_id']}/${list[i]['room_id']}"),
                // bulidTextTemp(),
                // ) //
              ],
            ),
          );
        });
  }
}

Row buildDisplayTable(String textApi) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Padding(
        //สร้างpadding
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Container(
              width: 320,
              height: 50,
              child: Text(
                'ตารางอุณหภูมิ',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 25),
              ),
            ),
            Container(
              width: 350,
              height: 300,
              color: Colors.white,
              child: Test_Table(Api: textApi),
            ),
          ],
        ),
      ),
    ],
  );
}

Row buildDisplaychat(String textApi) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Padding(
        //สร้างpadding
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Container(
              width: 250,
              height: 50,
              child: Text(
                'กราฟอุณหภูมิห้อง',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 25),
              ),
            ),
            Container(
              width: 300,
              height: 350,
              child: AgeCharts(Api: textApi),
              // child: DateTimeComboLinePointChart.withSampleData(),
            ),
          ],
        ),
      ),
    ],
  );
}

Row bulidTextTemp() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Padding(
        //สร้างpadding
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Container(
              width: 300,
              height: 185,
              // child: AgeCharts(Api: textApi),
              child: Align(
                  alignment: Alignment.topRight, child: Datetime_one_day()),
            ),
          ],
        ),
      ),
    ],
  );
}

Column bulid_last(String textApi) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Center(
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            width: 120,
            height: 25,
            child: Text(
              'อุณหภูมิ',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
          ),
          Container(
            width: 150,
            height: 25,
            child: Text(
              'ความชื้นสัมพันธ์',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
          ),
        ]),
      ),
      SizedBox(
        height: 15,
      ),
      Padding(
        //สร้างpadding
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Center(
              child: Container(
                  width: 300, height: 70, child: Last_Data(Api: textApi)),
            ),
          ],
        ),
      ),
    ],
  );
}

Row bulidTitel(String textTiTel) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Padding(
        //สร้างpadding
        padding: const EdgeInsets.only(top: 16.0),
        child: Row(
          children: [
            Container(
              width: 300,
              height: 80,
              child: Center(
                child: Text(
                  textTiTel,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Row bulid_button_setting_notify(String textTiTel) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    textDirection: TextDirection.rtl,
    children: [
      Padding(
        //สร้างpadding
        padding: const EdgeInsets.only(top: 30.0),
        child: Row(
          children: [
            Container(
              width: 300,
              height: 20,
              child: Center(
                child: Text(
                  textTiTel,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 10,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
