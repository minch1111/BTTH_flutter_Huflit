// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:huflit_flutter/screen/bottom_navigation_layout.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "/";

  const LoginScreen({Key? key}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final userName = TextEditingController();
  final password = TextEditingController();

  funcLogin() {
    final strUserName = userName.text;
    final strPassword = password.text;
    if (strUserName == 'admin' && strPassword == '123') {
      Navigator.of(context)
          .pushReplacementNamed(BottomNavigationLayout.routeName);
    } else {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Warning'),
              content:const Text('Username or password is not correct.'),
              actions: [
                TextButton(
                  onPressed: () {
                    return Navigator.of(context).pop();
                  },
                  child:const Text('OK'),
                ),
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Login App'),
      ),
      body: Padding(
        padding:const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            SizedBox(
              width: 100,
              height: 150,
              child: Image.asset(
                'assets/logoqb.jpg',
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
              child: const Text(
                'LOGIN INFORMATION',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w500,
                  fontSize: 30,
                ),
              ),
            ),
            Container(
              padding:const EdgeInsets.all(10),
              child: TextField(
                controller: userName,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'User Name'),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: TextField(
                controller: password,
                obscureText: true,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Password'),
              ),
            ),
            // ignore: deprecated_member_use
            FlatButton(
                onPressed: () {},
                textColor: Colors.blue,
                child: const Text('Forgot Password')),
            Container(
              height: 50,
              padding:const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.teal,
                  onPrimary: Colors.white,
                  onSurface: Colors.grey,
                ),
                child: Text('Login'),
                onPressed: () {
                  funcLogin();
                },
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  const Text('Does not have account?'),
                   FlatButton(
                    textColor: Colors.blue,
                    child: const Text(
                      'Sign in',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      funcLogin();
                    },
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
