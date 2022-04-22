import 'package:flutter/material.dart';
import 'package:huflit_flutter/screen/bottom_navigation_layout.dart';
import 'package:huflit_flutter/screen/dbhelper.dart';
import 'package:huflit_flutter/screen/student.dart';
import 'package:huflit_flutter/screen/dbhelper.dart';
import 'package:huflit_flutter/screen/student.dart';
import 'package:sqflite/sqflite.dart';

class EditStudentScreen extends StatefulWidget {
  static const routeName = "/edit";

  @override
  _EditStudentScreenState createState() => _EditStudentScreenState();
}

class _EditStudentScreenState extends State<EditStudentScreen> {
  final strName = TextEditingController();
  final strAddress = TextEditingController();
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  late DBHelper dbHelper;
  late Student student;
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
    student = ModalRoute.of(context)?.settings.arguments as Student;
    strName.text = student.name;
    strAddress.text = student.address;
  }

  funcSave() {
    final name = strName.text;
    final address = strAddress.text;
    if (name != '' && address != '') {
// them vào databaseExists(path)
      DBHelper.db
          .updateStudent(Student(id: student.id, name: name, address: address))
          .then((value) {
        if (value > 0) {
          _scaffoldKey.currentState
              // ignore: deprecated_member_use
              ?.showSnackBar(const SnackBar(content: Text('Update Successful')));
        }
      }).catchError((onError) {
        _scaffoldKey.currentState
            // ignore: deprecated_member_use
            ?.showSnackBar(SnackBar(content: Text(onError.toString())));
      });
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
        title: Text('Update Student'),
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
                'STUDENT INFORMATION',
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
                    border: OutlineInputBorder(), labelText: 'Name'),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: strAddress,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Address'),
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
