//declare packages
import 'dart:async';
import 'dart:convert';
import 'package:day14/Pageadmin/ManageUser/ShowUserid.dart';
import 'package:day14/pageUser/PageLocation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../connect/ip.dart';

class ShowUser extends StatefulWidget {
  ShowUser() : super();

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

class SearchRoomState extends State<ShowUser> {
  final _debouncer = Debouncer();

  List<Subject> ulist = [];
  List<Subject> userLists = [];
  //API call for All Subject List

  Future<List<Subject>> getAllulistList() async {
    try {
      final responce = await http.get(Uri.parse("${IP().connect}/apistaff"));
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

  @override
  void initState() {
    super.initState();
    getAllulistList().then((subjectFromServer) {
      setState(() {
        ulist = subjectFromServer;
        userLists = ulist;
      });
    });
  }

  //Main Widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ShowUser Page",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue[900],
        elevation: 0,
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
                hintText: 'Search Room Allow',
              ),
              onChanged: (string) {
                _debouncer.run(() {
                  setState(() {
                    userLists = ulist
                        .where(
                          (u) => (u.username.toLowerCase().contains(
                                string.toLowerCase(),
                              )),
                        )
                        .where(
                          (u) => (u.firstName.toLowerCase().contains(
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
              itemCount: userLists == null ? 0 : userLists.length,
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
                              PageRoom1(list: userLists, index: index),
                          // (userLists: userLists, index: index)
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
                            child: Image.network(
                                // (list[i]['imageStaff'])
                                (userLists[index].imageStaff),

                                // width: 300,
                                height: 150,
                                fit: BoxFit.fill),
                          ),
                          ListTile(
                            title: Text(
                              (userLists[index].username),

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
class Subject {
  int idStaff;
  String firstName;
  String lastName;
  String username;
  String password;
  String imageStaff;
  int idPosition;
  int byAdminId;

  Subject(
      {this.idStaff,
      this.firstName,
      this.lastName,
      this.username,
      this.password,
      this.imageStaff,
      this.idPosition,
      this.byAdminId});

  Subject.fromJson(Map<String, dynamic> json) {
    idStaff = json['id_staff'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    username = json['username'];
    password = json['password'];
    imageStaff = json['image_staff'];
    idPosition = json['id_position'];
    byAdminId = json['by_admin_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_staff'] = this.idStaff;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['username'] = this.username;
    data['password'] = this.password;
    data['image_staff'] = this.imageStaff;
    data['id_position'] = this.idPosition;
    data['by_admin_id'] = this.byAdminId;
    return data;
  }
}
