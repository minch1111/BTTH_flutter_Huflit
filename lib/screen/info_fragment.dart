import 'package:flutter/material.dart';
import 'package:huflit_flutter/screen/bottom_navigation_layout.dart';
import 'package:huflit_flutter/screen/dbhelper.dart';
import 'package:huflit_flutter/screen/student.dart';
import 'package:sqflite/sqflite.dart';
import 'package:http/http.dart' as http;

class InfoScreen extends StatefulWidget {
  static const routeName = "/";

  const InfoScreen({Key? key}) : super(key: key);

  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  final userName = TextEditingController();
  final password = TextEditingController();
  final firstName = TextEditingController();
  final email = TextEditingController();
  // ignore: unnecessary_new
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  late DBHelper dbHelper;
  late List<Student> listStudent;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // dbHelper = DBHelper();
    // dbHelper.copyDB();
    // ignore: deprecated_member_use
    listStudent = <Student>[];
  }

  funcSave() async {
    final strUserName = userName.text;
    final strPassword = password.text;
    final strfirstName = firstName.text;
    final strEmail = email.text;
    if (strUserName != '' &&
        strPassword != '' &&
        strfirstName != '' &&
        strEmail != '') {
      var url = Uri.parse(
          'http://api.phanmemquocbao.com/api/info/InsertAccount?username=$strUserName&fullname=$strfirstName&email=$strEmail&password=$strPassword&token=lethibaotran');
      var response = await http.get(url);

      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title:const Text('Success'),
              content:const Text('Tạo user thành công'),
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
    } else {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title:const Text('Warning'),
              content:const Text('Please enter full info.'),
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
      key: _scaffoldKey,
      appBar: AppBar(
        title:const Text('Information Student'),
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
              padding:const EdgeInsets.fromLTRB(10, 20, 10, 10),
              child:const Text(
                'USER INFORMATION',
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
                decoration:const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'UserName'),
              ),
            ),
            Container(
              padding:const EdgeInsets.all(10),
              child: TextField(
                controller: password,
                decoration:const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Password'),
              ),
            ),
            Container(
              padding:const EdgeInsets.all(10),
              child: TextField(
                controller: firstName,
                decoration:const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Fullname'),
              ),
            ),
            Container(
              padding:const EdgeInsets.all(10),
              child: TextField(
                controller: email,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Phone'),
              ),
            ),
            Container(
              height: 50,
              padding:const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.teal,
                  onPrimary: Colors.white,
                  onSurface: Colors.grey,
                ),
                child:const Text('Save'),
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
