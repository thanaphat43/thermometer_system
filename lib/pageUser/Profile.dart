import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../connect/ip.dart'; // for using json.decode()

class Profile extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

int id_position;
String y = id_position.toString();
String first_name;
String last_name;
String image_staff;
String name_position;
dynamic data_name_position;

class _HomePageState extends State<Profile> {
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
        id_position = preferences.getInt('id_position');
        first_name = preferences.getString('first_name');
        first_name = preferences.getString('first_name');
        last_name = preferences.getString('last_name');
        image_staff = preferences.getString('image_staff');
        name_position = preferences.getString('name_position');
        print(first_name);

        print(id_position);
      },
    );
    final gettemp = await http
        .get(Uri.parse('${IP().connect}/position_name/${id_position}'));
    var data2 = await json.decode(gettemp.body);
    setState(() {
      data_name_position = data2;
    });
  }

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
                  // SizedBox(
                  //   height: 10,
                  // ),
                  Container(
                    height: height * 1,
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
                                width: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      first_name.toString(),
                                      style: TextStyle(
                                        color: Color.fromRGBO(39, 105, 171, 1),
                                        fontFamily: 'Nunito',
                                        fontSize: 25,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      last_name.toString(),
                                      style: TextStyle(
                                        color: Color.fromRGBO(39, 105, 171, 1),
                                        fontFamily: 'Nunito',
                                        fontSize: 25,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          'ตำแหน่ง',
                                          style: TextStyle(
                                            color: Colors.grey[700],
                                            fontFamily: 'Nunito',
                                            fontSize: 25,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          name_position.toString(),
                                          style: TextStyle(
                                            color: Colors.grey[700],
                                            fontFamily: 'Nunito',
                                            fontSize: 25,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    // Column(
                                    //   children: [
                                    //     Text(
                                    //       'หน่วยงาน',
                                    //       style: TextStyle(
                                    //         color: Colors.grey[700],
                                    //         fontFamily: 'Nunito',
                                    //         fontSize: 25,
                                    //       ),
                                    //     ),
                                    //     Text(
                                    //       //  "${data_name_position[0]['name_position']}",
                                    //       "${data_name_position?.length > 0 ? data_name_position[0]['name_position'] : ''}",
                                    //       style: TextStyle(
                                    //         color: Colors.grey[700],
                                    //         fontFamily: 'Nunito',
                                    //         fontSize: 25,
                                    //       ),
                                    //     ),
                                    //   ],
                                    // ),
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
                                  radius: 80.0,
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
