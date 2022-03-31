import 'package:day14/Pageadmin/Manager_Room/Edit_room.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_mysql_crud/details.dart';
// import 'package:flutter_mysql_crud/page1/login.dart';
// import 'package:flutter_mysql_crud/pageAdmin/Mamager_User/dropdata.dart';
// import 'package:flutter_mysql_crud/pageAdmin/Mamager_User/editdata.dart';
// import 'package:flutter_mysql_crud/pageAdmin/Mamager_User/newdata.dart';
// import 'package:flutter_mysql_crud/pageAdmin/Manager_Room/Edit_room.dart';
// import 'package:flutter_mysql_crud/pageAdmin/Manager_Room/addRoom.dart';
// import 'package:flutter_mysql_crud/pageAdmin/Manager_Room/drop_room.dart';
// import 'package:flutter_mysql_crud/pageAdmin/Manager_Room/new_room.dart';
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

class Home_room_Edit extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home_room_Edit> {
  Future<List> getData() async {
    final responce = await http.get(Uri.parse("${IP().connect}/apistaff_room"));
    print(responce);
    return jsonDecode(responce.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ShowRoom_Edit"),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => Navigator.of(context).push(
      //     MaterialPageRoute(
      //       builder: (BuildContext contex) => Add_Room2(),
      //     ),
      //   ),
      //   child: Icon(Icons.add),
      // ),
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
          title: Text(list[i]['room_name']),
          // subtitle: Text(list[i]['mobile']),

          // onTap: () => Navigator.of(context).push(
          //   MaterialPageRoute(
          //     // builder: (BuildContext context) => Detail(list: list, index: i),
          //     // builder: (BuildContext context) => delete(),
          //     builder: (BuildContext context) =>
          //         Edit_room(list: list, index: i),
          //   ),
          // ),

          subtitle: FlatButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Edit_room(list: list, index: i),
                ),
              );
            },
            child: Text(
              'Edit_room',
              style: TextStyle(color: Colors.blue, fontSize: 15),
            ),
          ),
        );
      },
    );
  }
}
