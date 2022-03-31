import 'package:day14/Pageadmin/Mamager_User/Search_user.dart';
import 'package:day14/Pageadmin/Mamager_User/Show_Drop_User.dart';
import 'package:day14/Pageadmin/Mamager_User/Show_Edit_User.dart';
import 'package:day14/Pageadmin/Mamager_User/newdata.dart';
import 'package:day14/Pageadmin/ManageRoom/Adduser.dart';
import 'package:day14/Pageadmin/ManageRoom/ShowUser.dart';
import 'package:day14/Pageadmin/Manager_Room/ShowRoom_Drop.dart';
import 'package:day14/Pageadmin/Manager_Room/ShowRoom_Edit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';

class Manage_User extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white.withOpacity(.94),
        appBar: AppBar(
          title: Text(
            "Admin Page",
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
              // user card
              // SimpleUserCard(
              //   userName: "Nom de l'utilisateur",
              //   userProfilePic: AssetImage("assets/profilpic.png"),
              // ),
              // SettingsGroup(
              //   items: [
              //     SettingsItem(
              //       onTap: () {
              //         Navigator.push(
              //           context,
              //           // MaterialPageRoute(
              //           //   builder: (context) => Show_Edit_User(),
              //           // ),
              //           MaterialPageRoute(
              //             builder: (context) => Search_user(),
              //           ),
              //         );
              //       },
              //       icons: CupertinoIcons.person_alt_circle,
              //       iconStyle: IconStyle(),
              //       title: 'ดูสมาชิก',
              //       // subtitle: "",
              //     ),
              //   ],
              // ),
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
                          builder: (context) => AddData(),
                        ),
                      );
                    },
                    icons: CupertinoIcons.person_alt_circle,
                    iconStyle: IconStyle(),
                    title: 'เพิ่มสมาชิก',
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
                          builder: (context) => Show_Edit_User(),
                        ),
                      );
                    },
                    icons: CupertinoIcons.person_alt_circle,
                    iconStyle: IconStyle(),
                    title: 'แก้ไขสมาชิก',
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
                          builder: (context) => DropUser(),
                        ),
                      );
                    },
                    icons: CupertinoIcons.person_alt_circle,
                    iconStyle: IconStyle(),
                    title: 'ระงับผู้ใช้งาน',
                    // subtitle: "Make Ziar'App yours",
                  ),
                ],
              ),

              // SettingsGroup(
              //   items: [
              //     SettingsItem(
              //       onTap: () {
              //         Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //             builder: (context) => Adduser(),
              //           ),
              //         );
              //       },
              //       icons: CupertinoIcons.pencil_outline,
              //       iconStyle: IconStyle(),
              //       title: 'manage Add',
              //       subtitle: "Make Ziar'App yours",
              //     ),
              //   ],
              // ),
              // SettingsGroup(
              //   items: [
              //     SettingsItem(
              //       onTap: () {},
              //       icons: Icons.info_rounded,
              //       iconStyle: IconStyle(
              //         backgroundColor: Colors.purple,
              //       ),
              //       title: 'About',
              //       subtitle: "Learn more about Ziar'App",
              //     ),
              //   ],
              // ),
              // You can add a settings title
              // SettingsGroup(
              //   settingsGroupTitle: "Account",
              //   items: [
              //     SettingsItem(
              //       onTap: () {},
              //       icons: Icons.exit_to_app_rounded,
              //       title: "",
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
