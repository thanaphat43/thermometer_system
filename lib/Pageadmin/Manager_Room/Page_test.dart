// import 'package:fl_line_chart_example/page/home_page.dart';
// import 'package:fl_line_chart_example/page1/component/chart.dart';
import 'package:day14/pageUser/Table.dart';
import 'package:day14/pageUser/chart.dart';
import 'package:day14/pageUser/chart/Calendar.dart';
import 'package:day14/pageUser/chart/chaeck_datetime.dart';
import 'package:day14/pageUser/chart/chart.dart';
import 'package:day14/pageUser/chart/last_data.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_mysql_crud/page1/component/chart.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../connect/ip.dart';

class Page_test extends StatefulWidget {
  List list;
  int index;

  Page_test({this.list, this.index});

  @override
  _PageRoomState createState() => _PageRoomState();
}

dynamic dateChart;

class _PageRoomState extends State<Page_test> {
  Future<List> getData() async {
    // final responce = await http.get(

    final responce = await http.get(Uri.parse(
        "${IP().connect}/get_tb_temp/${widget.list[widget.index].roomId}"));
    // "http://192.168.1.6:3000/apiroom_id/${widget.list[widget.index].roomId}"));
    // "http://192.168.1.6:3000/apiroom_id/24"));
    // var id =${widget.list[widget.index]['id_staff']}
    //     final id = widget.list[widget.index]['id_staff'];
    var data = await json.decode(responce.body);
    setState(() {
      dateChart = data;
      // getdataChart();
      // print(dateChart);
    });
    print(widget.list[widget.index].roomId);
    // print(data);
    // var a = data[0]['temp'];
    // for (var item in a) {
    //   print(a);
    // }
    // for (var item in data) {
    //   print(item['temp']);

    var date1 = data[0]['temp_temperature'];
    print(date1);
    return jsonDecode(responce.body);
  }

  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                width: 300,
                color: Colors.white,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "อุณหภูมิ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "ความชื้น",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                width: 200,
                color: Colors.white,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        (dateChart[0]['temp_temperature']).toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        (dateChart[0]['temp_humidity']).toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                width: 300,
                color: Colors.white,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "อุณหภูมิ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "ความชื้น",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                width: 200,
                color: Colors.white,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        (dateChart[1]['temp_temperature']).toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        (dateChart[1]['temp_humidity']).toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
