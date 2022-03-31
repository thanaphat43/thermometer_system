// import 'package:fl_line_chart_example/page/home_page.dart';
// import 'package:fl_line_chart_example/page1/component/chart.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_mysql_crud/page1/component/chart.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../connect/ip.dart';

class PageRoom1 extends StatefulWidget {
  List list;
  int index;

  PageRoom1({this.list, this.index});

  @override
  _PageRoomState createState() => _PageRoomState();
}

class _PageRoomState extends State<PageRoom1> {
  Future<List> getData() async {
    // final responce = await http.get(

    final responce = await http.get(Uri.parse(
        "${IP().connect}/apistaff/${widget.list[widget.index].idStaff}"));
    // var id =${widget.list[widget.index]['id_staff']}
    //     final id = widget.list[widget.index]['id_staff'];
    print(responce);
    return jsonDecode(responce.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[900],
        automaticallyImplyLeading: true,
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text("ชื่อผู้ใช้"),
          ),
          Icon(Icons.more_vert),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: const <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: Color(0xffCA492D)),
              child: Text(
                'My logo',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'หน้าแรก',
                style: TextStyle(color: Colors.black, fontSize: 25),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'ออกระบบ',
                style: TextStyle(color: Colors.black, fontSize: 25),
              ),
            ),
          ],
        ),
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
          return Column(
            //สร้าง Child ซึ่งเป็นcloumn
            children: <Widget>[
              //สร้าง childen สำหรับ widget
              bulidTitel(list[i]['username']), // )
              bulidTextTemp(), // )
              buildDisplaychat(), //
            ],
          );
        });
  }
}

Row buildDisplaychat() {
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
              // child: SimpleTimeSeriesChart.withSampleData(),
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

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'อุณหภูมิ',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 32,
              ),
            ),
            Card(
                child: Text('48 องศา',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 25,
                    ))),
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

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_mysql_crud/details.dart';
// import 'package:flutter_mysql_crud/page1/login.dart';
// import 'package:flutter_mysql_crud/pageAdmin/newdata.dart';
// import 'dart:async';
// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class PageRoom extends StatefulWidget {
//   List list;
//   int index;

//   PageRoom({this.list, this.index});

//   @override
//   _DetailsState createState() => _DetailsState();
// }

// class _DetailsState extends State<PageRoom> {
//   Future<List> getData() async {
//     final responce = await http.get(
//         "http://192.168.1.10:3000/apiroom_id/${widget.list[widget.index]['room_id']}");
//     // var id =${widget.list[widget.index]['id_staff']}
//     //     final id = widget.list[widget.index]['id_staff'];
//     print(responce);
//     return jsonDecode(responce.body);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("My App Bar"),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => Navigator.of(context).push(
//           MaterialPageRoute(
//             builder: (BuildContext contex) => NewData(),
//           ),
//         ),
//         child: Icon(Icons.add),
//       ),
//       body: FutureBuilder<List>(
//         future: getData(),
//         builder: (ctx, ss) {
//           if (ss.hasError) {
//             print("error");
//           }
//           if (ss.hasData) {
//             return Items(list: ss.data);
//           } else {
//             return CircularProgressIndicator();
//           }
//         },
//       ),
//     );
//   }
// }

// class Items extends StatelessWidget {
//   List list;

//   Items({this.list});

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//         itemCount: list == null ? 0 : list.length,
//         itemBuilder: (ctx, i) {
//           return ListTile(
//             leading: Icon(Icons.person),
//             title: Text(list[i]['room_name']),

//             // subtitle: Text(list[i]['mobile']),
//             onTap: () => Navigator.of(context).push(MaterialPageRoute(
//               builder: (BuildContext context) => delete(list: list, index: i),
//               // builder: (BuildContext context) => delete(),
//             )),
//           );
//         });
//   }
// }

//  child: AgeCharts(
//                     Api: 'http://192.168.1.10:3000/getdegrees_roomit'),
//               ),