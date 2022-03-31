import 'package:day14/Animation/FadeAnimation.dart';
import 'package:day14/Pageadmin/AdminSettinge.dart';
import 'package:day14/Pageadmin/screens/LauncherAdmin.dart';
import 'package:day14/Weather/screens/loading_screen.dart';
import 'package:day14/Weather/screens/loading_screen2.dart';
import 'package:day14/homeapp.dart';
import 'package:day14/pageUser/LoginUser.dart';
import 'package:day14/pageUser/PageLocation.dart';
import 'package:day14/pageUser/chart/last_data_notify.dart';
import 'package:day14/pageUser/screens/launcher.dart';
import 'package:day14/pageUser/SearchRoom.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var initializationSettingsAndroid =
      new AndroidInitializationSettings('@mipmap/ic_launcher');
  final InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: LoadingScreen(),
    );
  }
}
