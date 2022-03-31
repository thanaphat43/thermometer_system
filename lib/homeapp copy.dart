// import 'package:day14/Animation/FadeAnimation.dart';
// import 'package:day14/Weather/utils/weather.dart';
// import 'package:day14/homeuser.dart';
// import 'package:day14/pageUser/LoginUser.dart';
// import 'package:day14/pageUser/screens/launcher.dart';
// import 'package:day14/test_firebase.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import './Weather/constants.dart';
// import './Weather/utils/weather.dart';

// class HomeApp extends StatefulWidget {
//   HomeApp({@required this.weatherData});

//   final WeatherData weatherData;

//   @override
//   _HomeAppState createState() => _HomeAppState();
// }

// class _HomeAppState extends State<HomeApp> {
//   int temperature;
//   Icon weatherDisplayIcon;
//   AssetImage backgroundImage;

//   String first_name;
//   Future checkUser() async {
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     setState(
//       () {
//         first_name = preferences.getString('first_name');
//         print(first_name);
//       },
//     );
//     if (first_name != null) {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           // builder: (context) => HomeUser(),
//           builder: (context) => Launcher(),
//         ),
//       );
//     }
//   }

//   void updateDisplayInfo(WeatherData weatherData) {
//     setState(() {
//       temperature = weatherData.currentTemperature.round();
//       WeatherDisplayData weatherDisplayData =
//           weatherData.getWeatherDisplayData();
//       backgroundImage = weatherDisplayData.weatherImage;
//       weatherDisplayIcon = weatherDisplayData.weatherIcon;
//     });
//   }

//   @override
//   void initState() {
//     // TODO: implement initState

//     updateDisplayInfo(widget.weatherData);
//     checkUser();

//     final firebaseMessaging = FCM();
//     firebaseMessaging.setNotifications();

//     firebaseMessaging.streamCtlr.stream.listen(_changeData);
//     firebaseMessaging.bodyCtlr.stream.listen(_changeBody);
//     firebaseMessaging.titleCtlr.stream.listen(_changeTitle);
//     super.initState();
//   }

//   _changeData(String msg) => setState(() => print('_changeBody=$msg'));
//   _changeBody(String msg) => setState(() => print('_changeBody=$msg'));
//   _changeTitle(String msg) => setState(() => print('_changeBody=$msg'));

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             colors: [
//               Colors.orange[900],
//               Colors.orange[800],
//               Colors.orange[400]
//             ],
//           ),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             SizedBox(
//               height: 80,
//             ),
//             Padding(
//               padding: EdgeInsets.all(20),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   FadeAnimation(
//                       1,
//                       Text(
//                         "Room Temperature",
//                         style: TextStyle(color: Colors.white, fontSize: 35),
//                       )),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   FadeAnimation(
//                       1.3,
//                       Text(
//                         "Welcome Back",
//                         style: TextStyle(color: Colors.white, fontSize: 18),
//                       )),
//                 ],
//               ),
//             ),
//             SizedBox(height: 20),
//             Expanded(
//               child: Container(
//                 constraints: BoxConstraints.expand(),
//                 // decoration: BoxDecoration(
//                 //   image: DecorationImage(
//                 //     image: backgroundImage,
//                 //     fit: BoxFit.cover,
//                 //   ),
//                 // ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     SizedBox(
//                       height: 85,
//                     ),
//                     Container(
//                       child: weatherDisplayIcon,
//                     ),
//                     SizedBox(
//                       height: 15.0,
//                     ),
//                     Center(
//                       child: Text(
//                         ' $temperature°',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 80.0,
//                           letterSpacing: -5,
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 50,
//                     ),
//                     FadeAnimation(
//                       1.7,
//                       FlatButton(
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => HomePage(),
//                             ),
//                           );
//                         },
//                         child: Center(
//                             child: Text(
//                           "Are you Login?",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 25.0,
//                           ),
//                         )),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       // body: Container(
//       //   constraints: BoxConstraints.expand(),
//       //   decoration: BoxDecoration(
//       //     image: DecorationImage(
//       //       image: backgroundImage,
//       //       fit: BoxFit.cover,
//       //     ),
//       //   ),
//       //   child: Column(
//       //     crossAxisAlignment: CrossAxisAlignment.stretch,
//       //     children: [
//       //       SizedBox(
//       //         height: 85,
//       //       ),
//       //       Container(
//       //         child: weatherDisplayIcon,
//       //       ),
//       //       SizedBox(
//       //         height: 15.0,
//       //       ),
//       //       Center(
//       //         child: Text(
//       //           ' $temperature°',
//       //           style: TextStyle(
//       //             color: Colors.white,
//       //             fontSize: 80.0,
//       //             letterSpacing: -5,
//       //           ),
//       //         ),
//       //       ),
//       //     ],
//       //   ),
//       // ),
//     );
//   }
// }
