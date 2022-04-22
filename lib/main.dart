import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:huflit_flutter/screen/bottom_navigation_layout.dart';
import 'package:huflit_flutter/screen/edit_user.dart';
import 'package:huflit_flutter/screen/login.dart';
import 'package:huflit_flutter/screen/register.dart';
import 'package:huflit_flutter/screen/edit_student.dart';

Future<void> main() async {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Login App",
    home: LoginScreen(),
    routes: {
      // LoginScreen.routeName: (ctx) => LoginScreen(),
      BottomNavigationLayout.routeName: (ctx) => BottomNavigationLayout(),
      RegisterNewScreen.routeName: (ctx) => RegisterNewScreen(),
      EditStudentScreen.routeName: (ctx) => EditStudentScreen(),
      EditUserScreen.routeName: (ctx) => EditUserScreen(),
    },
  ));
}
