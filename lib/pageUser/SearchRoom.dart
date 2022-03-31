//declare packages
import 'dart:async';
import 'dart:convert';
import 'package:day14/pageUser/PageLocation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../connect/ip.dart';
import 'chart/last_data.dart';
import 'chart/last_data_notify.dart';

class SearchRoom extends StatefulWidget {
  SearchRoom() : super();

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

class SearchRoomState extends State<SearchRoom> {
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
      print('getAllulistList id $id');
      print('getAllulistList $id_position');
      var API = "${IP().connect}/position_room/$id";
      final responce = await http.get(Uri.parse(API));
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
                              PageRoom(list: userLists, index: index),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8.0),
                              topRight: Radius.circular(8.0),
                            ),
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  userLists[index].imageRoom.toString()),
                              radius: 130.0,
                            ),
                          ),
                          ListTile(
                            title: Row(
                              children: [
                                Text(
                                  "${(userLists[index].roomName)}",
                                  // list[i]['room_name']
                                ),
                                Container(
                                    width: 20,
                                    height: 30,
                                    child: Last_Data_notify(
                                        list: userLists, index: index))
                              ],
                            ),
                          )

                          // subtitle: Container(
                          //     width: 300,
                          //     height: 50,
                          //     child: Last_Data_notify()),
                          // ),
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

  Future<List<dynamic>> getData() async {
    // String apiurl = '${IP().connect}/tb_temp_latest/${widget.Api}';
    String apiurl = 'http://192.168.1.6:3000/tb_temp_latest/1/1';
    final responce = await http.get(Uri.parse(apiurl));
    var data = await json.decode(responce.body);
    print("data_last+${data}");

    // setState(() {
    //   d = b;
    // });
    final gettemp = await http.get(Uri.parse(
        '${IP().connect}/get_tb_temp_notify_position/${data[0]['room_id']}'));
    var data2 = await json.decode(gettemp.body);
    // print("Notify+${data2[0]['prescribe_temp'] :''}");
    print(data2?.length > 0 ? data2[0]['prescribe_temp'] : '');
    var temperature = data[0]['temp_temperature'];
    var prescribe = data2?.length > 0 ? data2[0]['prescribe_temp'] : '';
    if (temperature >= prescribe) {
      // notify_app(data, data_name);
      showDialog(
          context: context,
          builder: (_) => BasicDialogAlert(
                // image: Image.network(
                //     "https://c.tenor.com/hF3lyPMSlU8AAAAC/termometro-caliente.gif"),
                title: Text(
                  " ${data[0]['temp_temperature'].toString()}",
                  // \n อุณหภูมิ ${data['0']['temp_temperature'].toString()} \n ความชื้น${data['0']['temp_humidity'].toString()}",
                  style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
                content: Text(
                  'ซึ่งเป็นอุณหภูมิที่เกินกำหนด',
                  textAlign: TextAlign.center,
                  style: TextStyle(),
                ),
                actions: <Widget>[
                  BasicDialogAction(
                    title: Text("OK"),
                    onPressed: () {},
                  ),
                ],
              ));
    } else {
      print('xxxxxxxxxxxxxxxxxNo');
    }
    // print(b);
    return jsonDecode(responce.body);
  }
}

class Subject {
  int roomId;
  String roomName;
  String imageRoom;
  int sensor_id;
  Subject({this.roomId, this.roomName, this.imageRoom, this.sensor_id});

  Subject.fromJson(Map<String, dynamic> json) {
    roomId = json['room_id'];
    roomName = json['room_name'];
    imageRoom = json['image_room'];
    sensor_id = json['sensor_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['room_id'] = this.roomId;
    data['room_name'] = this.roomName;
    data['image_room'] = this.imageRoom;
    data['sensor_id'] = this.sensor_id;
    return data;
  }
}
