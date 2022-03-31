import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:day14/Animation/FadeAnimation.dart';
import 'package:day14/Weather/utils/weather.dart';
import 'package:day14/pageUser/LoginUser.dart';
import 'package:day14/pageUser/home.dart';
import 'package:day14/pageUser/screens/launcher.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './Weather/constants.dart';
import './Weather/utils/weather.dart';
import 'connect/ip.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';

class HomeUser extends StatefulWidget {
  HomeUser({@required this.weatherData});

  final WeatherData weatherData;

  @override
  _HomeAppState createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeUser> {
  int temperature;
  Icon weatherDisplayIcon;
  AssetImage backgroundImage;
  int id_position;
  int id_staff;
  String first_name;
  dynamic token2;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getUser();
  }

  Future getUser() async {
    // ignore: unused_local_variable
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    String token = await firebaseMessaging.getToken();
    print("Token==${token}");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(
      () {
        id_staff = preferences.getInt('id_staff');
        id_position = preferences.getInt('id_position');
        first_name = preferences.getString('first_name');
        token2 = token;
        print('id_position $id_position');
      },
    );
    if (id_staff != null) {
      String apiurl = "${IP().connect}/updeta_token_staff/${id_staff}/${token}";
      await http.put(Uri.parse(apiurl));
      print('id_staff $id_staff');
      print('id_staff $token');
    }
    updateDisplayInfo(widget.weatherData);
    // gettemp();
  }

  void updateDisplayInfo(WeatherData weatherData) {
    setState(() {
      temperature = weatherData.currentTemperature.round();
      WeatherDisplayData weatherDisplayData =
          weatherData.getWeatherDisplayData();
      backgroundImage = weatherDisplayData.weatherImage;
      weatherDisplayIcon = weatherDisplayData.weatherIcon;
    });
  }

  // position_token(data_name) async {
  //   final response = await http.get(Uri.parse(
  //       '${IP().connect}/get_position_token/${data_name[0]['id_position']}'));
  //   var data_position = await json.decode(response.body);
  //   var list = data_position['token'];
  //   print(list);
  //   for (var index = 0; index < list.length; index++) {
  //     print(",${list[index]['token_staff']}");
  //   }
  // }

  // notify_app(data, data_name) async {
  //   final responce = await http.get(Uri.parse(
  //       '${IP().connect}/fcm_node/${data_name[0]['room_name']}/${data['tb_temp']['temp_temperature'].toString()}/${token2}'));
  //   var notify_app = await json.decode(responce.body);
  //   print("${notify_app}OK");
  // }

  // delete_notify(data2) async {
  //   // print(data2[0]['notitfy_id']);
  //   var url = "${IP().connect}/delete_tb_temp_notify/${data2[0]['notitfy_id']}";
  //   http.delete(Uri.parse(url));
  //   //  ,body: {'id': widget.list[widget.index]['id']}
  // }

  // add_peek_notify(data) async {
  //   var url =
  //       "${IP().connect}/set_tb_temp_notify_peek/${data['tb_temp']['room_id']}/${data['tb_temp']['sensor_id']}/${data['tb_temp']['temp_temperature']}/${data['tb_temp']['temp_humidity']}/${data['tb_temp']['temp_datetime']}";
  //   http.post(Uri.parse(url));
  //   print(data);
  // }

  // gettemp() async {
  //   final responce = await http.get(Uri.parse('${IP().connect}/get_notify'));
  //   var data2 = await json.decode(responce.body);
  //   print("Notify+${data2}");
  //   startnotify(data2);
  // }

  // startnotify(data2) async {
  //   var id = id_position.toString();
  //   final responce = await http
  //       .get(Uri.parse('${IP().connect}/get_room/${data2[0]['room_id']}'));
  //   var data_name = await json.decode(responce.body);
  //   // print("Room${data_name[0]['room_name']}");
  //   final response = await http.get(Uri.parse(
  //       '${IP().connect}/get_tb_temp_notify/${data2[0]['room_id']}/${data2[0]['sanser_id']}/${data2[0]['prescribe_temp']}/${data2[0]['Date']}/${id}'));
  //   var data = await json.decode(response.body);
  //   print(data);
  //   position_token(data_name);

  //   if (data['tb_temp'] != null) {
  //     // notify_app(data, data_name);
  //     showDialog(
  //         context: context,
  //         builder: (_) => BasicDialogAlert(
  //               // image: Image.network(
  //               //     "https://c.tenor.com/hF3lyPMSlU8AAAAC/termometro-caliente.gif"),
  //               title: Text(
  //                 " ${data_name[0]['room_name']}\n อุณหภูมิ ${data['tb_temp']['temp_temperature'].toString()} \n ความชื้น${data['tb_temp']['temp_humidity'].toString()}",
  //                 style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
  //                 textAlign: TextAlign.center,
  //               ),
  //               content: Text(
  //                 'ซึ่งเป็นอุณหภูมิที่เกินกำหนด',
  //                 textAlign: TextAlign.center,
  //                 style: TextStyle(),
  //               ),
  //               actions: <Widget>[
  //                 BasicDialogAction(
  //                   title: Text("OK"),
  //                   onPressed: () {
  //                     delete_notify(data2);
  //                     add_peek_notify(data);
  //                     Navigator.pop(
  //                       context,
  //                       MaterialPageRoute(
  //                         builder: (context) => HomeUser(),
  //                       ),
  //                     );
  //                   },
  //                 ),
  //               ],
  //               // entryAnimation: EntryAnimation.RIGHT_LEFT,
  //               // onOkButtonPressed: () {},
  //             ));
  //   } else {
  //     print('xxxxxxxxxxxxxxxxxNo');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          Colors.orange[900],
          Colors.orange[800],
        ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.all(0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: weatherDisplayIcon,
                  ),
                  FadeAnimation(
                    1,
                    Text(
                      ' $temperature°',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                      ),
                    ),
                  ),

                  // Center(
                  //   child: Text(
                  //     "Room Temperature",
                  //     style: TextStyle(color: Colors.white, fontSize: 20),
                  //   ),
                  // ),
                ],
              ),
            ),

            // Expanded(
            //   child: MyHomePage(),
            // ),
            Expanded(
              child: Launcher(),
            )
          ],
        ),
      ),
    );
  }
}
