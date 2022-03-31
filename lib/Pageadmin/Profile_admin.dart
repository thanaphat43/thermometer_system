// import 'package:flutter/material.dart';
// import 'package:flutter_vector_icons/flutter_vector_icons.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class Profile extends StatelessWidget {
//   @override
//   String first_name;
//   String last_name;
//   String image_staff;
//   String name_position;

//   Future getUser() async {
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     setState(
//       () {
//         first_name = preferences.getString('first_name');
//         last_name = preferences.getString('last_name');
//         image_staff = preferences.getString('image_staff');
//         name_position = preferences.getString('name_position');
//         print(first_name);
//       },
//     );
//   }

//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     double height = MediaQuery.of(context).size.height;
//     return Stack(
//       fit: StackFit.expand,
//       children: [
//         Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [
//                 Color.fromRGBO(4, 9, 35, 1),
//                 Color.fromRGBO(39, 105, 171, 1),
//               ],
//               begin: FractionalOffset.bottomCenter,
//               end: FractionalOffset.topCenter,
//             ),
//           ),
//         ),
//         Scaffold(
//           backgroundColor: Colors.white,
//           body: SingleChildScrollView(
//             physics: BouncingScrollPhysics(),
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 35),
//               child: Column(
//                 children: [
//                   Text(
//                     'Profile Staff',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 34,
//                       fontFamily: 'Nisebuschgardens',
//                     ),
//                   ),
//                   SizedBox(
//                     height: 30,
//                   ),
//                   Container(
//                     height: height * 0.55,
//                     child: LayoutBuilder(
//                       builder: (context, constraints) {
//                         double innerHeight = constraints.maxHeight;
//                         double innerWidth = constraints.maxWidth;
//                         return Stack(
//                           fit: StackFit.expand,
//                           children: [
//                             Positioned(
//                               bottom: 0,
//                               left: 0,
//                               right: 0,
//                               child: Container(
//                                 height: innerHeight * 0.70,
//                                 width: innerWidth,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(30),
//                                   color: Colors.white,
//                                 ),
//                                 child: Column(
//                                   children: [
//                                     SizedBox(
//                                       height: 60,
//                                     ),
//                                     Text(
//                                       first_name.toString(),
//                                       style: TextStyle(
//                                         color: Color.fromRGBO(39, 105, 171, 1),
//                                         fontFamily: 'Nunito',
//                                         fontSize: 25,
//                                       ),
//                                     ),
//                                     Text(
//                                       last_name.toString(),
//                                       style: TextStyle(
//                                         color: Color.fromRGBO(39, 105, 171, 1),
//                                         fontFamily: 'Nunito',
//                                         fontSize: 25,
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 20,
//                                     ),
//                                     Column(
//                                       children: [
//                                         Text(
//                                           'ตำแหน่ง',
//                                           style: TextStyle(
//                                             color: Colors.grey[700],
//                                             fontFamily: 'Nunito',
//                                             fontSize: 25,
//                                           ),
//                                         ),
//                                         SizedBox(
//                                           height: 20,
//                                         ),
//                                         Text(
//                                           'นักศึกษาฝึกงาน',
//                                           style: TextStyle(
//                                             color: Colors.grey[700],
//                                             fontFamily: 'Nunito',
//                                             fontSize: 25,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             Positioned(
//                               top: 20,
//                               left: 0,
//                               right: 0,
//                               child: Center(
//                                 child: CircleAvatar(
//                                   backgroundImage: NetworkImage(
//                                       "https://scontent.fbkk7-2.fna.fbcdn.net/v/t1.6435-9/50623534_2293533630887751_7427215429472354304_n.jpg?_nc_cat=110&ccb=1-5&_nc_sid=84a396&_nc_eui2=AeG0WZTsrIOnmAMGXejdD_kdRqDl76-9Gd5GoOXvr70Z3mxOGRU_B8KQxlIB6eI-GAUlclNHB7I2H24HpaGPO2qN&_nc_ohc=5AAf2JBX6kMAX9MQElI&_nc_ht=scontent.fbkk7-2.fna&oh=00_AT_yqqShVoDbgO0CI-0VrUidTANbk9YGVTpvVEfqUpJTmQ&oe=6212AFA9"),
//                                   radius: 60.0,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         );
//                       },
//                     ),
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         )
//       ],
//     );
//   }

//   void setState(Null Function() param0) {}
// }

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart'; // for using json.decode()

class Profile_admin extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

int id_staffadmin;
String y = id_staffadmin.toString();
String username;
String image_staff;

class _HomePageState extends State<Profile_admin> {
  // The list that contains information about photos
  List _loadedPhotos = [];

  void initState() {
    getUser();
    super.initState();
  }

  Future getUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(
      () {
        id_staffadmin = preferences.getInt('id_staffadmin');

        username = preferences.getString('username');
        image_staff = preferences.getString('image_staff');

        print(id_staffadmin);
      },
    );
  }

  // Future<void> _fetchData() async {
  //   const API_URL = 'http://192.168.1.6:3000/position_room/';

  //   final response = await http.get(Uri.parse(API_URL + y));
  //   final data1 = json.decode(response.body);
  //   print(data1);
  //   setState(() {
  //     _loadedPhotos = data1;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(4, 9, 35, 1),
                Color.fromRGBO(39, 105, 171, 1),
              ],
              begin: FractionalOffset.bottomCenter,
              end: FractionalOffset.topCenter,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 35),
              child: Column(
                children: [
                  Text(
                    'Profile Staff',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 34,
                      fontFamily: 'Nisebuschgardens',
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: height * 0.55,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        double innerHeight = constraints.maxHeight;
                        double innerWidth = constraints.maxWidth;
                        return Stack(
                          fit: StackFit.expand,
                          children: [
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: innerHeight * 0.70,
                                width: innerWidth,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 60,
                                    ),
                                    Text(
                                      username.toString(),
                                      style: TextStyle(
                                        color: Color.fromRGBO(39, 105, 171, 1),
                                        fontFamily: 'Nunito',
                                        fontSize: 25,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              top: 20,
                              left: 0,
                              right: 0,
                              child: Center(
                                child: CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(image_staff.toString()),
                                  radius: 60.0,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
