import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../connect/ip.dart';

class Test_Table extends StatefulWidget {
  final String Api;

  const Test_Table({this.Api});
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Test_Table> {
  Future<List> getData() async {
    // final responce = await http
    //     .get(Uri.parse('http://192.168.1.6:3000/temp_table/${widget.Api}'));

    final responce =
        await http.get(Uri.parse('${IP().connect}/temp_table/${widget.Api}'));
    print("id+${widget.Api}");
    var data = await json.decode(responce.body);
    // print('data${data[0]['temp_temperature']}');
    // print('data${data[0]['temp'][0]['temp_temperature']}');
    return jsonDecode(responce.body);
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
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "องศา",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
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
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text("เวลา",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 10,
              child: Container(
                child: FutureBuilder(
                    future: getData(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return Card(
                              elevation: 0,
                              margin: EdgeInsets.all(0),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                        child: Text(
                                      "${snapshot.data[index]['temp_temperature'].toString()}",
                                      textAlign: TextAlign.center,
                                    )),
                                    Expanded(
                                        child: Text(
                                      "${snapshot.data[index]['temp_humidity'].toString()}",
                                      textAlign: TextAlign.center,
                                    )),
                                    Expanded(
                                      child: Text(
                                        "${snapshot.data[index]["temp_datetime"]}",
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//   Widget build(BuildContext context) {
//     return Scaffold(
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
//       itemCount: list == null ? 0 : list.length,
//       itemBuilder: (ctx, i) {
//         return Container(
//           child: DataTable(
//             columns: [
//               DataColumn(
//                   label: Text('',
//                       style:
//                           TextStyle(fontSize: 2, fontWeight: FontWeight.bold))),
//               DataColumn(
//                   label: Text('',
//                       style:
//                           TextStyle(fontSize: 2, fontWeight: FontWeight.bold))),
//             ],
//             rows: [
//               DataRow(cells: [
//                 // Column(children: [Text('${list[i]['degrees'].toString()}')]),
//                 // Column(children: [Text('${list[i]["datetime"]}')]),
//                 DataCell(Text('${list[i]['degrees'].toString()}')),
//                 DataCell(Text('${list[i]["datetime"]}')),
//               ]),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
