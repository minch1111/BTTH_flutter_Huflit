import 'package:flutter/material.dart';
import 'package:huflit_flutter/screen/login.dart';

class Register extends StatefulWidget {
  static const routeName = "/register";

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final userName = TextEditingController();
  final password = TextEditingController();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final confirmPassword = TextEditingController();
  bool checkedValue = true;

  funcRegister() {
    final strUserName = userName.text.trim();
    final strPassword = password.text.trim();
    final strFirstName = firstName.text.trim();
    final strLastName = lastName.text.trim();

    if (strUserName != '' && strPassword != '' && strFirstName != '' && strLastName != '') {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Info'),
              content: Text('Register successfull.'),
              actions: [
                TextButton(
                  onPressed: () {
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
                    child: Text('OK')),
              ],
            );
          });
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
              child: Image.asset('assets/account.png'),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
              child: Text(
                'REGISTER INFORMATION',
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
                      child: new TextField(
                    controller: firstName,
                    decoration: InputDecoration(contentPadding: EdgeInsets.all(10), border: OutlineInputBorder(), labelText: 'First name'),
                  )),
                  SizedBox(width: 10),
                  new Flexible(
                      child: new TextField(
                    controller: lastName,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      border: OutlineInputBorder(),
                      labelText: 'Last name',
                    ),
                  ))
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: userName,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'User name',
                ),
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
              child: CheckboxListTile(
                title: Text("I accept the Terms of Use & Privacy Policy"),
                value: checkedValue,
                onChanged: (newValue) {
                  setState(() {
                    checkedValue = newValue!;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
              ),
            ),
            Container(
              height: 50,
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
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
