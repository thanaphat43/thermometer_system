import 'package:day14/Pageadmin/AdminSettinge.dart';
import 'package:day14/Pageadmin/Profile_admin.dart';
import 'package:day14/pageUser/Profile.dart';
import 'package:day14/pageUser/sign_out.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LauncherAdmin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LauncherState();
  }
}

class _LauncherState extends State<LauncherAdmin> {
  int _selectedIndex = 1;
  final List<Widget> _pageWidget = <Widget>[
    Profile_admin(),
    AdminSetting(),
    // Setting(),
  ];
  final List<BottomNavigationBarItem> _menuBar = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(FontAwesomeIcons.infoCircle),
      label: 'Profile',
    ),
    BottomNavigationBarItem(
      icon: Icon(FontAwesomeIcons.home),
      label: 'Home',
    ),
    // BottomNavigationBarItem(
    //   icon: Icon(FontAwesomeIcons.cog),
    //   label: 'Settings',
    // ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageWidget.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: _menuBar,
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
