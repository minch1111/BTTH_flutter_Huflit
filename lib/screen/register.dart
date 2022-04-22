import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:huflit_flutter/screen/login.dart';

class RegisterNewScreen extends StatefulWidget {
  static const routeName = "/register";

  @override
  _RegisterNewScreenState createState() => _RegisterNewScreenState();
}

class _RegisterNewScreenState extends State<RegisterNewScreen> {
  final userName = TextEditingController();
  final password = TextEditingController();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final confirmpassword = TextEditingController();
  bool checkedValue = true;
  //
  funcSaveInfo(String _firstname, String _lastname, String _username, String _password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('firstname', _firstname);
    prefs.setString('lastname', _lastname);
    prefs.setString('username', _username);
    prefs.setString('password', _password);
  }

  funcRegister() {
    final strUserName = userName.text;
    final strPassword = password.text;
    final strfirstName = firstName.text;
    final strlastName = lastName.text;
    if (strUserName != '' && strPassword != '' && strfirstName != '' && strlastName != '') {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Info'),
              content: Text('Register successfull.'),
              actions: [
                TextButton(
                  onPressed: () {
                    funcSaveInfo(strfirstName, strlastName, strUserName, strPassword);
                    return Navigator.popUntil(context, ModalRoute.withName(LoginScreen.routeName));
                  },
                  child: Text('OK'),
                ),
              ],
            );
          });
    } else {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Warning'),
              content: Text('Please fill all information.'),
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
      // het Dialog
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            SizedBox(
              width: 70,
              height: 70,
              child: Image.asset(
                'assets/account.png',
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
              child: Text(
                'REGISTER',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w500,
                  fontSize: 30,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new Flexible(
                    child: new TextField(controller: firstName, decoration: InputDecoration(contentPadding: EdgeInsets.all(10), border: OutlineInputBorder(), labelText: 'First name')),
                  ),
                  SizedBox(width: 10),
                  new Flexible(
                    child: new TextField(controller: lastName, decoration: InputDecoration(contentPadding: EdgeInsets.all(10), border: OutlineInputBorder(), labelText: 'Last name')),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: userName,
                decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'User Name'),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: TextField(
                controller: password,
                obscureText: true,
                decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Password'),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: TextField(
                controller: confirmpassword,
                obscureText: true,
                decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Confirm Password'),
              ),
            ),
            // ignore: deprecated_member_use
            Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: CheckboxListTile(
                  title: Text("I accept the Terms of Use & Privacy Policy"),
                  value: checkedValue,
                  onChanged: (newValue) {
                    setState(() {
                      checkedValue = newValue!;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading, //  <-- leading Checkbox
                )),
            Container(
              height: 50,
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.teal,
                  onPrimary: Colors.white,
                  onSurface: Colors.grey,
                ),
                child: Text('Register Now'),
                onPressed: () {
                  funcRegister();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
