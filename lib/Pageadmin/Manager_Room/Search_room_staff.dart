//declare packages
import 'dart:async';
import 'dart:convert';
import 'package:day14/Pageadmin/Manager_Room/Page_test.dart';

import 'package:day14/pageUser/PageLocation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../connect/ip.dart';

class Search_room_staff extends StatefulWidget {
  Search_room_staff() : super();

  @override
  SearchRoomState createState() => SearchRoomState();
}

class Debouncer {
  int milliseconds;
  VoidCallback action;
  Timer timer;

  run(VoidCallback action) {
    if (null != timer) {
      timer.cancel();
    }
    timer = Timer(
      Duration(milliseconds: Duration.millisecondsPerSecond),
      action,
    );
  }
}

class SearchRoomState extends State<Search_room_staff> {
  final _debouncer = Debouncer();
  int id_position;

  String first_name;

  List<Subject> ulist = [];
  List<Subject> userLists = [];

  @override
  void initState() {
    getUser();
    super.initState();
  }

  Future getUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(
      () {
        id_position = preferences.getInt('id_position');
        first_name = preferences.getString('first_name');

        print('id_position $id_position');
      },
    );

    getAllulistList().then((subjectFromServer) {
      setState(() {
        ulist = subjectFromServer;
        userLists = ulist;
      });
    });
  }

  Future<List<Subject>> getAllulistList() async {
    try {
      var id = id_position.toString();
      // print('getAllulistList id $id');
      // print('getAllulistList $id_position');
      // var API = "http://192.168.1.6:3000/position_room/$id";
      var API = "${IP().connect}/position_room/";
      final responce = await http.get(Uri.parse(API));
      // var API = "http://192.168.1.6:3000/position_room/";
      // final responce = await http.get(Uri.parse(API));

      if (responce.statusCode == 200) {
        print(responce.body);
        List<Subject> list = parseAgents(responce.body);
        return list;
      } else {
        throw Exception('Error');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static List<Subject> parseAgents(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Subject>((json) => Subject.fromJson(json)).toList();
  }

  //Main Widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("สถานที่ทั้งหมด"),
      ),
      body: Column(
        children: <Widget>[
          //Search Bar to List of typed Subject
          Container(
            height: 50,
            padding: EdgeInsets.all(5),
            child: TextField(
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(
                    color: Colors.blue,
                  ),
                ),
                suffixIcon: InkWell(
                  child: Icon(Icons.search),
                ),
                contentPadding: EdgeInsets.all(15.0),
                hintText: 'ค้นหาสถานที่',
              ),
              onChanged: (string) {
                _debouncer.run(() {
                  setState(() {
                    userLists = ulist
                        .where(
                          (u) => (u.roomName.toLowerCase().contains(
                                string.toLowerCase(),
                              )),
                        )
                        .toList();
                  });
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              padding: EdgeInsets.all(5),
              itemCount: userLists.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.all(8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0))),
                    child: InkWell(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              Page_test(list: userLists, index: index),
                        ),
                      ),
                      // onTap: () => Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: (context) =>
                      //         // PageRoom(list: userLists, index: index),
                      //         PageLocation(list: userLists, index: index),
                      //     // Test_Data(),
                      //   ),
                      // ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8.0),
                              topRight: Radius.circular(8.0),
                            ),
                            child: Image.network(
                                // (list[i]['image_room'])
                                (userLists[index].imageRoom),

                                // width: 300,
                                height: 150,
                                fit: BoxFit.fill),
                          ),
                          ListTile(
                            title: Text(
                              (userLists[index].roomName),
                              // list[i]['room_name']
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

//Declare Subject class for json data or parameters of json string/data
//Class For Subject
// class Subject {
//   String roomName;
//   String imageRoom;

//   Subject({this.roomName, this.imageRoom});

//   Subject.fromJson(Map<String, dynamic> json) {
//     roomName = json['room_name'];
//     imageRoom = json['image_room'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['room_name'] = this.roomName;
//     data['image_room'] = this.imageRoom;
//     return data;
//   }
// }

class Subject {
  int roomId;
  String roomName;
  String imageRoom;

  Subject({this.roomId, this.roomName, this.imageRoom});

  Subject.fromJson(Map<String, dynamic> json) {
    roomId = json['room_id'];
    roomName = json['room_name'];
    imageRoom = json['image_room'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['room_id'] = this.roomId;
    data['room_name'] = this.roomName;
    data['image_room'] = this.imageRoom;
    return data;
  }
}

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// import 'package:shared_preferences/shared_preferences.dart'; // for using json.decode()

// class Mytest extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// int id_position;
// String y = id_position.toString();
// String first_name;

// class _HomePageState extends State<Mytest> {
//   // The list that contains information about photos
//   List _loadedPhotos = [];

//   void initState() {
//     getUser();
//     super.initState();
//   }

//   Future getUser() async {
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     setState(
//       () {
//         id_position = preferences.getInt('id_position');
//         first_name = preferences.getString('first_name');

//         print(id_position);
//       },
//     );
//   }

//   Future<void> _fetchData() async {
//     const API_URL = 'http://192.168.1.6:3000/position_room/';

//     final response = await http.get(Uri.parse(API_URL + y));
//     final data1 = json.decode(response.body);
//     print(data1);
//     setState(() {
//       _loadedPhotos = data1;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Kindacode.com'),
//       ),
//       body: SafeArea(
//         child: _loadedPhotos.length == 0
//             ? Center(
//                 child: ElevatedButton(
//                   child: Text(first_name.toString()),
//                   onPressed: _fetchData,
//                 ),
//               )
//             // The ListView that displays photos
//             : ListView.builder(
//                 itemCount: _loadedPhotos.length,
//                 itemBuilder: (BuildContext ctx, index) {
//                   return Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: <Widget>[
//                         Text(
//                           _loadedPhotos[index]["username"],
//                           textAlign: TextAlign.start,
//                           style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                         Text(_loadedPhotos[index]['image_staff']),
//                         Text('Photo ID: ${_loadedPhotos[index]["id_staff"]}'),
//                         Text('Photo ID: ${_loadedPhotos[index]["staff_room"]}'),
//                         Text('Photo ID: ${_loadedPhotos[index]["password"]}'),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//       ),
//     );
//   }
// }


//  return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: <Widget>[
//                   Text(
//                       _loadedPhotos[index]["username"],
//                     textAlign: TextAlign.start,
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                  Text(_loadedPhotos[index]['image_staff']),
//               
//                    Text('Photo ID: ${_loadedPhotos[index]["id_staff"]}'),
//                    Text('Photo ID: ${_loadedPhotos[index]["staff_room"]}'),
//                         Text('Photo ID: ${_loadedPhotos[index]["password"]}'),
//                 ],
//               ),
//             );