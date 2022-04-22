import 'package:flutter/material.dart';
import 'package:huflit_flutter/screen/bottom_navigation_layout.dart';
import 'package:huflit_flutter/screen/dbhelper.dart';
import 'package:huflit_flutter/screen/student.dart';
import 'package:huflit_flutter/screen/user.dart';
import 'package:huflit_flutter/screen/dbhelper.dart';
import 'package:huflit_flutter/screen/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:http/http.dart' as http;

class EditUserScreen extends StatefulWidget {
  static const routeName = "/edit-user";

  @override
  _EditUserScreenState createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  final strName = TextEditingController();
  final strUserName= TextEditingController();
  final strPassword = TextEditingController();
  final strEmail = TextEditingController(); // dùng tam để Phone vào
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  late DBHelper dbHelper;
  late User user;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // dbHelper = DBHelper();
    // dbHelper.copyDB();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    user = ModalRoute.of(context)?.settings.arguments as User;
    strName.text = user.fullname;
    strEmail.text = user.email;
    strUserName.text= user.username;
    strPassword.text= user.password!;
  }

  funcSave() async {
    final name = strName.text;
    final password = strPassword.text;
    final username= strUserName.text;
    final email= strEmail.text;
    if (name != '' && username != '' && password != '' && email != '') {
      var url = Uri.parse(
          'http://api.phanmemquocbao.com/api/info/UpdateAccount?accountId=${user.id}&username=${username}&fullname=${name}&email=${email}&password=${password}&token=lethibaotran');
      await http.get(url);
      Navigator.of(context).pop();
    } else {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Warning'),
              content: Text('Please enter full info.'),
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Update USER'),
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
                'USER INFORMATION',
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
                controller: strName,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Full Name'),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: strUserName,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'User Name'),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: strPassword,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Password'),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: strEmail,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Phone'),
              ),
            ),
            Container(
              height: 50,
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.teal,
                  onPrimary: Colors.white,
                  onSurface: Colors.grey,
                ),
                child: Text('Save'),
                onPressed: () {
                  funcSave();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
