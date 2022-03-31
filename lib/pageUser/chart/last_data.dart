import 'dart:convert';
import 'package:circle_chart/circle_chart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../connect/ip.dart';

class Last_Data extends StatefulWidget {
  final String Api;

  const Last_Data({this.Api});
  @override
  _dept_emp_listState createState() => _dept_emp_listState();
}

class _dept_emp_listState extends State<Last_Data> {
  Future<List> getData() async {
    String apiurl = '${IP().connect}/tb_temp_latest/${widget.Api}';
    // String apiurl = '${IP().connect}/tb_temp_latest/1/1';
    final responce = await http.get(Uri.parse(apiurl));

    var data = await json.decode(responce.body);
    print("data_last+${data}");
    return jsonDecode(responce.body);
  }

  @override
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
              flex: 10,
              child: Container(
                // width: 300,
                // height: 150,
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
                                    // Container(
                                    //   width: 350,
                                    //   height: 350,
                                    //   child: CircleChart(
                                    //       progressNumber: 25.3,
                                    //       maxNumber: 50,
                                    //       children: [
                                    //         Text(
                                    //           "This is kind of description",
                                    //           style: Theme.of(context)
                                    //               .textTheme
                                    //               .headline4,
                                    //         ),
                                    //       ]),
                                    // ),
                                    Expanded(
                                      child: Text(
                                        "${snapshot.data[index]['temp_temperature'].toString()} ํC",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        "${snapshot.data[index]['temp_humidity'].toString()}%",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
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
