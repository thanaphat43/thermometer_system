import 'package:day14/Pageadmin/Mamager_User/Search_user.dart';
import 'package:day14/Pageadmin/Mamager_User/Show_Drop_User.dart';
import 'package:day14/Pageadmin/Mamager_User/Show_Edit_User.dart';
import 'package:day14/Pageadmin/Mamager_User/newdata.dart';
import 'package:day14/Pageadmin/Mamager_position/show_drop_position.dart';
import 'package:day14/Pageadmin/Mamager_position/Show_Edit_position.dart';
import 'package:day14/Pageadmin/Mamager_position/newposition.dart';
import 'package:day14/Pageadmin/ManageRoom/Adduser.dart';
import 'package:day14/Pageadmin/ManageRoom/ShowUser.dart';
import 'package:day14/Pageadmin/Manager_Room/ShowRoom_Drop.dart';
import 'package:day14/Pageadmin/Manager_Room/ShowRoom_Edit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';

class Manage_Position extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white.withOpacity(.94),
        appBar: AppBar(
          title: Text(
            "หน่วยงาน",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
              SettingsGroup(
                items: [
                  SettingsItem(
                    onTap: () {
                      Navigator.push(
                        context,
                        // MaterialPageRoute(
                        //   builder: (context) => Show_Edit_User(),
                        // ),
                        MaterialPageRoute(
                          builder: (context) => AddPosition(),
                        ),
                      );
                    },
                    icons: CupertinoIcons.person_alt_circle,
                    iconStyle: IconStyle(),
                    title: 'เพิ่มหน่วยงาน',
                    // subtitle: "",
                  ),
                ],
              ),
              SettingsGroup(
                items: [
                  SettingsItem(
                    onTap: () {
                      Navigator.push(
                        context,
                        // MaterialPageRoute(
                        //   builder: (context) => Show_Edit_User(),
                        // ),
                        MaterialPageRoute(
                          builder: (context) => Show_Edit_position(),
                        ),
                      );
                    },
                    icons: CupertinoIcons.person_alt_circle,
                    iconStyle: IconStyle(),
                    title: 'แก้ไขหน่วยงาน',
                    // subtitle: "Make Ziar'App yours",
                  ),
                ],
              ),
              SettingsGroup(
                items: [
                  SettingsItem(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Drop_position(),
                        ),
                      );
                    },
                    icons: CupertinoIcons.person_alt_circle,
                    iconStyle: IconStyle(),
                    title: 'ลบหน่วยงาน',
                    // subtitle: "Make Ziar'App yours",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
