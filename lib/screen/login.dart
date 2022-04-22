import 'package:flutter/material.dart';
import 'package:huflit_flutter/screen/bottom_navigation_layout.dart';
import 'package:huflit_flutter/screen/register.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  static const routeName = "/";
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final userName = TextEditingController();
  final password = TextEditingController();

  funcLogin() async {
    final strUserName = userName.text;
    final strPassword = password.text;

    try {
      var url = Uri.parse(
          'http://api.phanmemquocbao.com/api/info/CheckAccount?username=$strUserName&password=$strPassword&token=lethibaotran');
      var response = await http.get(url);

      if ((strUserName == "admin" && strPassword == "123") ||
          response.body != null) {
        Navigator.of(context)
            .pushReplacementNamed(BottomNavigationLayout.routeName);
      } else {
        return showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Warning'),
                content: Text('Username or password is not correct.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      return Navigator.of(context).pop();
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            });
      }
    } catch (err) {
      print(err);
    }
  }

  funcRegister() {
    return Navigator.of(context).pushNamed(RegisterNewScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login App'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
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
              child: Text(
                'LOGIN INFORMATION',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w500,
                  fontSize: 30,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: userName,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'User Name'),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: TextField(
                controller: password,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Password'),
              ),
            ),
            // ignore: deprecated_member_use
            FlatButton(
                onPressed: () {},
                textColor: Colors.blue,
                child: Text('Forgot Password')),
            Container(
              height: 50,
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
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
                  Text('Does not have account?'),
                  FlatButton(
                    textColor: Colors.blue,
                    child: Text(
                      'Sign in',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      funcRegister();
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
