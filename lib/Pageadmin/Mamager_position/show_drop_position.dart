import 'package:day14/Pageadmin/Mamager_position/drop_position.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_mysql_crud/details.dart';
// import 'package:flutter_mysql_crud/page1/login.dart';
// import 'package:flutter_mysql_crud/pageAdmin/Mamager_User/dropdata.dart';
// import 'package:flutter_mysql_crud/pageAdmin/Mamager_User/editdata.dart';
// import 'package:flutter_mysql_crud/pageAdmin/Mamager_User/newdata.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../connect/ip.dart';

class Drop_position extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Drop_position> {
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
        title: Text("ระงับการใช้งานของสมาชิก"),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => Navigator.of(context).push(
      //     MaterialPageRoute(
      //       builder: (BuildContext contex) => AddData(),
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
          title: Text(list[i]['name_position']),
          // subtitle: Text(list[i]['mobile']),

          // onTap: () => Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (BuildContext context) => Edit(list: list, index: i),
          //   ),
          // ),

          subtitle: FlatButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => dropdata(list: list, index: i),
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

// import 'package:flutter/material.dart';

// class Home2 extends StatelessWidget {
//   static const String _title = 'Flutter Code Sample';

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: _title,
//       home: Scaffold(
//         appBar: AppBar(title: const Text(_title)),
//         body: MyStatelessWidget(),
//       ),
//     );
//   }
// }

// class MyStatelessWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return DataTable(
//       columns: const <DataColumn>[
//         DataColumn(
//           label: Text(
//             'Name',
//             style: TextStyle(fontStyle: FontStyle.italic),
//           ),
//         ),
//         DataColumn(
//           label: Text(
//             'Age',
//             style: TextStyle(fontStyle: FontStyle.italic),
//           ),
//         ),
//         DataColumn(
//           label: Text(
//             'Role',
//             style: TextStyle(fontStyle: FontStyle.italic),
//           ),
//         ),
//       ],
//       rows: const <DataRow>[
//         DataRow(
//           cells: <DataCell>[
//             DataCell(Text('Sarah')),
//             DataCell(Text('19')),
//             DataCell(Text('Student')),
//           ],
//         ),
//         DataRow(
//           cells: <DataCell>[
//             DataCell(Text('Janine')),
//             DataCell(Text('43')),
//             DataCell(Text('Professor')),
//           ],
//         ),
//         DataRow(
//           cells: <DataCell>[
//             DataCell(Text('William')),
//             DataCell(Text('27')),
//             DataCell(Text('Associate Professor')),
//           ],
//         ),
//       ],
//     );
//   }
// }

