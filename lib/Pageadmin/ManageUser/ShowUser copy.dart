import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../connect/ip.dart';

class ShowUser extends StatelessWidget {
  ShowUser();
  Future<List> getData() async {
    final responce = await http.get(Uri.parse("${IP().connect}/apistaff"));
    print(responce);
    return jsonDecode(responce.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ห้องที่สามารถเข้าถึงได้',
            textAlign: TextAlign.center, style: TextStyle(fontSize: 20)),
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
              margin: EdgeInsets.all(8.0),
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text('${list[i]["id_staff"]}'),
                  Text('${list[i]['first_name']}'),
                  Text('${list[i]['last_name']}'),
                  Text('${list[i]['username']}'),
                  Text('${list[i]['image_staff']}'),
                  Text('${list[i]['id_position']}'),
                  Text('${list[i]['by_admin_id']}'),
                ],
              )));
        });
  }
}


                    //  Text('${list[i]["id_staff"]}'),
                    // Text('${list[i]['first_name']}'),
                    // Text('${list[i]['last_name']}'),
                    // Text('${list[i]['username']}'),
                    // Text('${list[i]['image_staff']}'),
                    // Text('${list[i]['id_position']}'),
                    // Text('${list[i]['by_admin_id']}'),


        //              child: Container(
        //   child: Column(
        //     children: <Widget>[
        //       Container(
        //         child: Container(
        //           padding:
        //               EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        //           height: MediaQuery.of(context).size.height,
        //           child: ListView.builder(
        //             itemCount: 10,
        //             itemBuilder: (context, index) {
        //               return Container(
        //                 height: MediaQuery.of(context).size.width * 0.5,
        //                 child: Card(
        //                   color: Colors.deepPurpleAccent,
        //                   shape: RoundedRectangleBorder(
        //                     borderRadius: BorderRadius.circular(12.0),
        //                   ),
        //                   elevation: 8,
        //                   child: Container(
        //                     child: Center(),
        //                   ),
        //                 ),
        //               );
        //             },
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),