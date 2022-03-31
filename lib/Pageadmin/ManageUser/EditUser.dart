import 'package:flutter/material.dart';

class EditUser extends StatefulWidget {
  @override
  _EditUser createState() => _EditUser();
}

class _EditUser extends State<EditUser> {
  double iconSize = 40;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text(
              "ShowUser Page",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            backgroundColor: Colors.blue[900],
            elevation: 0,
          ),
          body: Center(
              child: Column(children: <Widget>[
            Container(
              margin: EdgeInsets.all(10),
              child: Table(
                border: TableBorder.all(),
                columnWidths: {
                  0: FractionColumnWidth(.4),
                  1: FractionColumnWidth(.4),
                },
                children: [
                  TableRow(children: [
                    Column(children: [
                      Icon(
                        Icons.account_box,
                        size: iconSize,
                      ),
                      Text('My Account')
                    ]),
                    Column(children: [
                      Icon(
                        Icons.settings,
                        size: iconSize,
                      ),
                      Text('Settings')
                    ]),
                  ]),
                  // TableRow(children: [
                  //   Icon(
                  //     Icons.cake,
                  //     size: iconSize,
                  //   ),
                  //   Icon(
                  //     Icons.voice_chat,
                  //     size: iconSize,
                  //   ),
                  //   Icon(
                  //     Icons.add_location,
                  //     size: iconSize,
                  //   ),
                  // ]),
                ],
              ),
            ),
          ]))),
    );
  }
}
