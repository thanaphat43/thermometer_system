import 'package:day14/Animation/FadeAnimation.dart';
import 'package:day14/Pageadmin/LoginAdmin.dart';
import 'package:day14/Weather/screens/loading_screen2.dart';

import 'package:day14/homeuser.dart';
import 'package:day14/pageUser/screens/launcher.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../connect/ip.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePage();
  }
}

class _HomePage extends State<HomePage> {
  String errormsg;
  bool error, showprogress;
  String username, password;

  var _username = TextEditingController();
  var _password = TextEditingController();

  startLogin() async {
    String apiurl = "${IP().connect}/login";

    print(username);
    var response = await http.post(Uri.parse(apiurl), body: {
      'username': username, //get the username text
      'password': password //get password text
    });
    var data = await json.decode(response.body);

    Future<void> nextPage() async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setInt('id_staff', data['access_lavel'][0]['id_staff']);
      preferences.setString(
          'first_name', data['access_lavel'][0]['first_name']);
      preferences.setString('last_name', data['access_lavel'][0]['last_name']);
      preferences.setString('username', data['access_lavel'][0]['username']);
      preferences.setString(
          'image_staff', data['access_lavel'][0]['image_staff']);
      preferences.setString(
          'name_position', data['access_lavel'][0]['name_position']);
      preferences.setInt('id_position', data['access_lavel'][0]['id_position']);
      // if (data != '{"access_lavel":"No"}') {
    }

    if (response.statusCode == 200) {
      if (data['token'] != null) {
        print(data[0]);

        setState(() {
          nextPage();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LoadingScreen2(),
              // builder: (context) => Launcher(),
            ),
          );
        });
      } else if (data[0] == error) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Username หรือ Password ผิดค่ะ")));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Username หรือ Password ผิดพลาด")));
      }
    }
  }

  @override
  void initState() {
    username = "";
    password = "";
    errormsg = "";
    error = false;
    showprogress = false;

    //_username.text = "defaulttext";
    //_password.text = "defaultpassword";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('ห้องที่สามารถเข้าถึงได้',
      //       textAlign: TextAlign.center, style: TextStyle(fontSize: 20)),
      // ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          Colors.orange[900],
          Colors.orange[800],
          Colors.orange[400]
        ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 80,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeAnimation(
                    1,
                    Text(
                      "ระบบตรวจวัดอุณหภูมิ",
                      style: TextStyle(color: Colors.white, fontSize: 35),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FadeAnimation(
                      1.3,
                      Text(
                        "Welcome",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      )),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60))),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 60,
                        ),
                        FadeAnimation(
                          1.4,
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color.fromRGBO(225, 95, 27, .3),
                                      blurRadius: 20,
                                      offset: Offset(0, 10))
                                ]),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey[200]))),
                                  child: TextField(
                                    controller: _username,
                                    decoration: InputDecoration(
                                        hintText: "Username",
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        border: InputBorder.none),
                                    onChanged: (value) {
                                      //set username  text on change
                                      username = value;
                                    },
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey[200]))),
                                  child: TextField(
                                    obscureText: true,
                                    controller: _password,
                                    decoration: InputDecoration(
                                        hintText: "Password",
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        border: InputBorder.none),
                                    onChanged: (value) {
                                      // change password text
                                      password = value;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        // FadeAnimation(
                        //     1.5,
                        //     Text(
                        //       "Forgot Password?",
                        //       style: TextStyle(color: Colors.grey),
                        //     )),
                        SizedBox(
                          height: 40,
                        ),
                        FadeAnimation(
                            1.6,
                            Container(
                              height: 50,
                              margin: EdgeInsets.symmetric(horizontal: 50),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.orange[400]),
                              child: RaisedButton(
                                onPressed: () {
                                  if (username == null ||
                                      username.isEmpty ||
                                      password == null ||
                                      password.isEmpty) {
                                    ArtSweetAlert.show(
                                        context: context,
                                        artDialogArgs: ArtDialogArgs(
                                          type: ArtSweetAlertType.danger,
                                          title: "กรุณาใส่ให้ครบ",
                                        ));
                                  } else {
                                    setState(() {
                                      //show progress indicator on click
                                      showprogress = true;
                                    });
                                    startLogin();
                                  }
                                },
                                child: showprogress
                                    ? SizedBox(
                                        height: 30,
                                        width: 60,
                                        child: CircularProgressIndicator(
                                          backgroundColor: Colors.orange[400],
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  Colors.deepOrangeAccent),
                                        ),
                                      )
                                    : Text("เข้าสู่ระบบ",
                                        // style: TextStyle(fontSize: 20),
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                // if showprogress == true then show progress indicator
                                // else show "LOGIN NOW" text
                                colorBrightness: Brightness.dark,
                                color: Colors.orange,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)
                                    //button corner radius
                                    ),
                              ),
                            )),
                        SizedBox(
                          height: 50,
                        ),
                        FadeAnimation(
                          1.7,
                          FlatButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Login_admin(),
                                ),
                              );
                            },
                            child: Center(
                                child: Text(
                              "Are you  admin?",
                              style: TextStyle(color: Colors.grey),
                            )),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
