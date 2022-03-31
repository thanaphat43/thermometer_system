// ignore_for_file: null_aware_before_operator

import 'dart:convert';
import 'package:circle_chart/circle_chart.dart';
import 'package:day14/homeuser.dart';
import 'package:day14/pageUser/SearchRoom.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../connect/ip.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class Last_Data_notify extends StatefulWidget {
  Last_Data_notify({this.list, this.index});
  List list;
  int index;

  @override
  _dept_emp_listState createState() => _dept_emp_listState();
}

class _dept_emp_listState extends State<Last_Data_notify> {
  delete_notify(data2) async {
    var url = "${IP().connect}/delete_tb_temp_notify/${data2[0]['notitfy_id']}";
    http.delete(Uri.parse(url));
  }

  add_peek_notify(data) async {
    var url =
        "${IP().connect}/set_tb_temp_notify_peek/${data['0']['room_id']}/${data['0']['0']}/${data['0']['temp_temperature']}/${data['0']['temp_humidity']}/${data['0']['temp_datetime']}";
    http.post(Uri.parse(url));
    print(data);
  }

  notify_app(data, data_name, String token) async {
    final responce = await http.get(Uri.parse(
        '${IP().connect}/fcm_node/${data_name[0]['room_name']}/${data[0]['temp_temperature'].toString()}/${token}'));
  }

  Future<void> _showNotification(data, data_name) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('Notify1', 'แจ้งเตือนทั่วไป',
            importance: Importance.max, //เลือกระดับกลุ่มchannel
            priority: Priority.high, //เลือกระดับกลุ่มchannel
            ticker: 'ticker' //
            ); //กำหนด กลุ่มchannelการแจ้งเตือน
    const NotificationDetails platformChannelDetails =
        NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
        0,
        '${data_name[0]['room_name']}',
        'อุณหภูมิ${data[0]['temp_temperature'].toString()}ซึ่งเกินกำหนด',
        platformChannelDetails);
  }

  Future<List> getData() async {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    String token = await firebaseMessaging.getToken();

    String apiurl =
        '${IP().connect}/tb_temp_latest/${widget.list[widget.index].roomId}/${widget.list[widget.index].sensor_id}';
    final responce = await http.get(Uri.parse(apiurl));
    var data = await json.decode(responce.body);
    print("sensor_id${widget.list[widget.index].sensor_id}");
    print("data_last+${data}+${token}");

    final gettemp = await http.get(Uri.parse(
        '${IP().connect}/get_tb_temp_notify_position/${data[0]['room_id']}'));
    var data2 = await json.decode(gettemp.body);

    final name_room = await http
        .get(Uri.parse('${IP().connect}/get_room/${data[0]['room_id']}'));
    var data_name = await json.decode(name_room.body);

    var temperature = data[0]['temp_temperature'];
    var prescribe = data2?.length > 0 ? data2[0]['prescribe_temp'] : '';
    if (prescribe == '') {
      print('No');
    } else if (prescribe == 1) {
      print('has data');
    } else if (temperature >= prescribe) {
      notify_app(data, data_name, token);
      _showNotification(data, data_name);
      showDialog(
          context: context,
          builder: (_) => BasicDialogAlert(
                title: Text(
                  " ${data_name[0]['room_name'].toString()}",
                  style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
                content: Text(
                  " ${data[0]['temp_temperature'].toString()} \n ซึ่งเป็นอุณหภูมิที่เกินกำหนด",
                  textAlign: TextAlign.center,
                  style: TextStyle(),
                ),
                actions: <Widget>[
                  BasicDialogAction(
                    title: Text("OK"),
                    onPressed: () {
                      delete_notify(data2);
                      // add_peek_notify(data);
                      Navigator.pop(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SearchRoom(),
                        ),
                      );
                    },
                  ),
                ],
              ));
    } else if (temperature <= prescribe) {
      print('ok data');
    } else {
      print('not data');
    }
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
                width: 20,
                height: 30,
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
                                        style: TextStyle(
                                          fontSize: 10,
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
