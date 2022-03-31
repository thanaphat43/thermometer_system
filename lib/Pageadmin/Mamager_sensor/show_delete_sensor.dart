import 'package:day14/Pageadmin/Mamager_position/drop_position.dart';
import 'package:day14/Pageadmin/Mamager_sensor/drop_position.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../connect/ip.dart';

class Show_Drop_position extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Show_Drop_position> {
  Future<List> getData() async {
    final responce = await http.get(Uri.parse("${IP().connect}/sensor"));
    print(responce);
    return jsonDecode(responce.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ระงับการใช้งานของเครื่องวัดอุณหภูมิ(sensor)"),
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
        return ListTile(
          leading: Icon(Icons.person),
          title: Text(list[i]['sensor_name']),
          subtitle: FlatButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Drop_sensor(list: list, index: i),
                ),
              );
            },
            child: Text(
              'ระงับการใช้งาน',
              style: TextStyle(color: Colors.red, fontSize: 15),
            ),
          ),
        );
      },
    );
  }
}
