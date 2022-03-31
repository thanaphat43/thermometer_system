import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:nextflow_local_notification/test.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   // const AndroidInitializationSettings initializationSettingsAndroid =
//   //     AndroidInitializationSettings("@mipmap-hdpi\ic_launcher.png");
// var  initializationSettingsAndroid =
//     new AndroidInitializationSettings('@mipmap/ic_launcher');
//   final InitializationSettings initializationSettings =
//       InitializationSettings(android: initializationSettingsAndroid);
//   await flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Nextflow Flutter Widget Today',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: MyHomePage(title: 'Flutter 3 นาที: Local Notification'),
//     );
//   }
// }

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _controller = TextEditingController();

  Future<void> _showNotification() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('Notify1', 'แจ้งเตือนทั่วไป',
            importance: Importance.max, //เลือกระดับกลุ่มchannel
            priority: Priority.high, //เลือกระดับกลุ่มchannel
            ticker: 'ticker' //
            ); //กำหนด กลุ่มchannelการแจ้งเตือน
    const NotificationDetails platformChannelDetails =
        NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
        0, 'สวัสดี', 'กินข้าวยัง', platformChannelDetails);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: RaisedButton(
                onPressed: () {
                  _showNotification();
                },
                child: Text('เด้ง noti'),
              ),
            ),
            //      SizedBox(
            //       width: double.infinity,
            //       child: RaisedButton(
            //        onPressed: () => Navigator.of(context).push(
            //   MaterialPageRoute(
            //     builder: (BuildContext contex) => Home2(),
            //   ),
            // ),
            //         child: Text('เด้ง noti'),
            //       ),
            //     ),
          ],
        ),
      ),
    );
  }
}
