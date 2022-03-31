import 'package:day14/Pageadmin/Mamager_position/show_drop_position.dart';
import 'package:day14/Pageadmin/Mamager_position/Show_Edit_position.dart';
import 'package:day14/Pageadmin/Mamager_position/newposition.dart';
import 'package:day14/Pageadmin/Mamager_sensor/new_sensor.dart';
import 'package:day14/Pageadmin/Mamager_sensor/show_delete_sensor.dart';
import 'package:day14/Pageadmin/Mamager_sensor/show_edit_sensor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';

class Manage_Sensor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white.withOpacity(.94),
        appBar: AppBar(
          title: Text(
            "เครื่องวัดอุณหภูมิ(sensor)",
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
                          builder: (context) => AddSensor(),
                        ),
                      );
                    },
                    icons: CupertinoIcons.person_alt_circle,
                    iconStyle: IconStyle(),
                    title: 'เพิ่มsensor',
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
                          builder: (context) => Show_Edit_sensor(),
                        ),
                      );
                    },
                    icons: CupertinoIcons.person_alt_circle,
                    iconStyle: IconStyle(),
                    title: 'แก้ไขsensor',
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
                          builder: (context) => Show_Drop_position(),
                        ),
                      );
                    },
                    icons: CupertinoIcons.person_alt_circle,
                    iconStyle: IconStyle(),
                    title: 'ลบsensor',
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
