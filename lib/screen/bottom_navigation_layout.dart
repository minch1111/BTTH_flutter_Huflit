import 'package:flutter/material.dart';
import 'package:huflit_flutter/screen/info_fragment.dart';
import 'package:huflit_flutter/screen/home_fragment.dart';
import 'package:huflit_flutter/screen/login.dart';
import 'package:huflit_flutter/screen/logout_fragment.dart';
import 'package:huflit_flutter/screen/notification_fragment.dart';
import 'package:huflit_flutter/screen/dashboardlist_fragment.dart';
class BottomNavigationLayout extends StatefulWidget {
  static const routeName = "bottom-layout";
  @override
  _BottomNavigationLayoutState createState() => _BottomNavigationLayoutState();
}

class _BottomNavigationLayoutState extends State<BottomNavigationLayout> {
  late int _currentIndex;
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    _currentIndex = 0;
  }
  bodyWidget(int pos){
    switch(pos){
      case 0:
        return HomeFragmentWidget();
      case 1:
        return SqlitePage();
      case 2:
        return const InfoScreen();
      case 3:
        return const LogoutFragmentWidget();}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Bottom Navigation'),
      // ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: false,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        currentIndex:  _currentIndex,
        // ignore: prefer_const_literals_to_create_immutables
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.home, color: Colors.blue,), label: 'Home'),
          const BottomNavigationBarItem(icon: Icon(Icons.dashboard, color: Colors.blue,), label: 'Dashboard'),
          const BottomNavigationBarItem(icon: Icon(Icons.notifications_active, color: Colors.blue,), label: 'Add'),
          const BottomNavigationBarItem(icon: Icon(Icons.directions_run, color: Colors.blue,), label: 'Logout'),
        ],
      ),
      body: bodyWidget(_currentIndex),
    );
  }
}
