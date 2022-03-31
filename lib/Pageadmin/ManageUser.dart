// import 'package:flutter/material.dart';

// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:flutter_settings_screens/flutter_settings_screens.dart';
// import 'package:settings_ui/settings_ui.dart';

// class adminSetting extends StatelessWidget {
//   adminSetting();

//   @override
//   Widget build(BuildContext context) {
//   return Scaffold(
//       body: SettingsList(

//         sections: [
//           SettingsSection(
//             title: Text('admin manager',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(color: Colors.black, fontSize: 25)
//                    ),
//             tiles: [
//               // SettingsTile(
//               //   title: Text("ตั้งค่าแจ้งเตือนอุณหภูมิ"),
//               // ),
//               SettingsTile(
//                   title: Text("จัดการผู้ใช้งานระบบ"),
//                   leading: Icon(Icons.settings),
//                   onPressed: (BuildContext context) {
//                     Navigator.pushNamed(context, '/about');
//                   }),
//             ],
//           ),
//           // SettingsSection(
//           //   tiles: [
//           //     SettingsTile.switchTile(
//           //       title: Text("แจ้งเตือนอุณหภูมิสูงต่ำเกินมาตรฐาน"),
//           //     ),
//           //   ],
//           // ),
//           SettingsSection(
//             tiles: [
//               SettingsTile(
//                   title: Text("จัดการสถานที่"),
//                   leading: Icon(Icons.),
//                   onPressed: (BuildContext context) {
//                     Navigator.pushNamed(context, '/about');
//                   }),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   BottomNavigationBar buildBottombar() {
//     return BottomNavigationBar(
//       items: const <BottomNavigationBarItem>[
//         BottomNavigationBarItem(
//           icon: Icon(FontAwesomeIcons.home),
//           label: 'Home',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(FontAwesomeIcons.infoCircle),
//           label: 'About',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(FontAwesomeIcons.userAlt),
//           label: 'Profile',
//         ),
//       ],
//       // currentIndex: _selectedIndex,
//       // onTap: _onItemTapped,
//     );
//   }

//   // Row Setting(BuildContext context) {
//   //   return Row(
//   //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//   //     children: <Widget>[
//   //       Text('Open'),
//   //       Switch(
//   //           activeColor: Theme.of(context).accentColor, onChanged: (newVal) {}),
//   //       Text('Open'),
//   //     ],
//   //   );
//   // }
// }

import 'package:day14/Pageadmin/Mamager_User/Show_Drop_User.dart';
import 'package:day14/Pageadmin/Mamager_User/Show_Edit_User.dart';
import 'package:day14/Pageadmin/Manager_Room/ShowRoom_Drop.dart';
import 'package:day14/Pageadmin/Manager_Room/ShowRoom_Edit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';

class adminSetting extends StatelessWidget {
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
                    title: 'manage users (Edit)',
                    subtitle: "Make Ziar'App yours",
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
                          builder: (context) => Show_Edit_User(),
                        ),
                      );
                    },
                    icons: CupertinoIcons.person_alt_circle,
                    iconStyle: IconStyle(),
                    title: 'manage users (Drop)',
                    subtitle: "Make Ziar'App yours",
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
                          builder: (context) => Home_room_Edit(),
                        ),
                      );
                    },
                    icons: CupertinoIcons.pencil_outline,
                    iconStyle: IconStyle(),
                    title: 'manage room(Edit)',
                    subtitle: "Make Ziar'App yours",
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
                          builder: (context) => Home_room_Drop(),
                        ),
                      );
                    },
                    icons: CupertinoIcons.pencil_outline,
                    iconStyle: IconStyle(),
                    title: 'manage room(Drop)',
                    subtitle: "Make Ziar'App yours",
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
              SettingsGroup(
                settingsGroupTitle: "Account",
                items: [
                  SettingsItem(
                    onTap: () {},
                    icons: Icons.exit_to_app_rounded,
                    title: "Sign Out",
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
