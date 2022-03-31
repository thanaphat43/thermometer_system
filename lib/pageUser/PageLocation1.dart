// import 'package:fl_line_chart_example/page/home_page.dart';
// import 'package:fl_line_chart_example/page1/component/chart.dart';
import 'package:day14/pageUser/Table%20copy.dart';
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

import '../connect/ip.dart';

class PageLocation extends StatefulWidget {
  List list;
  int index;

  PageLocation({this.list, this.index});

  @override
  _PageLocationState createState() => _PageLocationState();
}

class _PageLocationState extends State<PageLocation> {
  Future<List> getData() async {
    // final responce = await http.get(

    final responce = await http
        .get(Uri.parse("${IP().connect}/${widget.list[widget.index].roomId}"));
    // "http://192.168.1.6:3000/apiroom_id/${widget.list[widget.index].roomId}"));
    // "http://192.168.1.6:3000/apiroom_id/24"));
    // var id =${widget.list[widget.index]['id_staff']}
    //     final id = widget.list[widget.index]['id_staff'];
    var data = await json.decode(responce.body);
    print(widget.list[widget.index].roomId);
    // print(data);
    var a = data[0]['temp'];
    for (var item in a) {
      print(a);
    }
    // for (var item in data) {
    //   print(item['temp']);

    // var date = data[0]['temp'];
    // print(data);
    return jsonDecode(responce.body);
  }

  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        // itemCount: list == null ? 0 : list.length,
        itemCount: list == null ? 0 : list.length,
        itemBuilder: (ctx, i) {
          return Column(
            //สร้าง Child ซึ่งเป็นcloumn

            children: <Widget>[
              //สร้าง childen สำหรับ widget
              // )
              bulidTitel(list[i]['sensor_name']), // )

              bulidTitel(list[i]['temp'][0]['temp_temperature'].toString()),

              bulidCalendar(),
              // buildDisplaychat(list[i]['api_degrees']), //
              buildDisplayTable(list: list, index: i),
              // bulidTextTemp(), // ) //
            ],
          );
        });
  }
}

Row buildDisplayTable({int index, List list}) {
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
                'ตารางอุณภูมิ',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 25),
              ),
            ),
            Container(
              width: 300,
              height: 300,
              child: Test_Table2(list, index),
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
              height: 300,
              // child: AgeCharts(Api: textApi),
              child: DateTimeComboLinePointChart.withSampleData(),
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

Row bulidCalendar() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Padding(
        //สร้างpadding
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Center(
              child: Container(
                width: 300,
                height: 180,
                child: Last_Data(),
              ),
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
