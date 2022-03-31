import 'package:day14/Pageadmin/Mamager_User/editdata.dart';
import 'package:day14/Pageadmin/Mamager_User/newdata.dart';
import 'package:day14/Pageadmin/Mamager_position/edit_position.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_mysql_crud/details.dart';
// import 'package:flutter_mysql_crud/page1/login.dart';
// import 'package:flutter_mysql_crud/pageAdmin/Mamager_User/editdata.dart';
// import 'package:flutter_mysql_crud/pageAdmin/Mamager_User/newdata.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../connect/ip.dart';

// void main() => runApp(MaterialApp(
//       title: "Api Test",
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.red,
//       ),
//       home: LoginPage(),
//     ));

class Show_Edit_position extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Show_Edit_position> {
  Future<List> getData() async {
    final responce =
        await http.get(Uri.parse("${IP().connect}/staff_position_room"));
    print(responce);
    return jsonDecode(responce.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("แสดงข้อมูลของสมาชิกและแก้ไข"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext contex) => AddData(),
          ),
        ),
        child: Icon(Icons.add),
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
          title: Text(list[i]['name_position']),
          // subtitle: Text(list[i]['mobile']),

          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              // builder: (BuildContext context) => Detail(list: list, index: i),
              // builder: (BuildContext context) => delete(),
              builder: (BuildContext context) => Edit(list: list, index: i),
            ),
          ),

          subtitle: FlatButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Edit_position(list: list, index: i),
                ),
              );
            },
            child: Text(
              'แก้ไขหน่วยงาน',
              style: TextStyle(color: Colors.blue, fontSize: 15),
            ),
          ),
        );
      },
    );
  }
}
