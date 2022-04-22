// ignore: unused_import
import 'dart:convert';
// ignore: unused_import
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:huflit_flutter/screen/dbhelper.dart';
// ignore: unused_import
import 'package:huflit_flutter/screen/student.dart';
import 'package:huflit_flutter/screen/user.dart';
import 'package:huflit_flutter/screen/edit_user.dart';
// ignore: unused_import
import 'package:huflit_flutter/screen/edit_student.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class SqlitePage extends StatefulWidget {
  const SqlitePage({Key? key}) : super(key: key);

  @override
  _SqlitePageState createState() => _SqlitePageState();
}

class _SqlitePageState extends State<SqlitePage> {
  // ignore: unused_field
  final String _data = '';
  late DBHelper dbHelper;
  late List<User> listStudent;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Future<List<User>> getAllUser() async {
    try {
      var url = Uri.parse(
          'http://api.phanmemquocbao.com/api/info/GetAccountAll?token=lethibaotran');
      var response = await http.get(url);
      listStudent =  User.parseList(response);
      return listStudent;
    } catch (err) {
      print(err);
    }
    return listStudent;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Load Data From API"),
      ),
      body: Center(
        child: buildFutureBuilderAssets(context),
      ),
    );
  }

  reloadPage() {
    setState(() {});
  }

  void disposed() {}

  buildFutureBuilderAssets(BuildContext context) {
    return FutureBuilder(
      future: getAllUser(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return const Text('Press button to start.');
          case ConnectionState.active:
          case ConnectionState.waiting:
            return const CircularProgressIndicatorPage();
          case ConnectionState.done:
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              List<User> listStudent = snapshot.data as List<User>;
              return listStudent.isNotEmpty
                  ?  ListEmployee(
                      students: listStudent,
                      reloadPage: reloadPage,
                    )
                  : const Text("Empty!");
            }
        }
      },
    );
  }
}

// ignore: must_be_immutable
class ListEmployee extends StatefulWidget {
  Function reloadPage;
  List<User> students;
  ListEmployee({Key? key, required this.students, required this.reloadPage}) : super(key: key);

  @override
  _ListEmployeeState createState() => _ListEmployeeState();
}

class _ListEmployeeState extends State<ListEmployee> {
  funcEditUser(User user) {
    return Navigator.of(context)
       .pushNamed(EditUserScreen.routeName, arguments: user);

    // Ở đây Navigator qua page EditUser nhé - Mẫu ở trên kìa

  }

  // handleDeleteStudent(int studentId) {
  //   DBHelper.db.deleteStudent(studentId);
  //   widget.reloadPage();
  // }

  handelRequiredDelete(int userId) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title:const Text('Delete User'),
            content: const Text('Are You Sure ?'),
            actions: [
              TextButton(
                onPressed: () {
                  handleDeleteUser(userId);
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child:const Text('No'),
              ),
            ],
          );
        });
  }

  handleDeleteUser(int userId) async {
    try {
      var url = Uri.parse(
          'http://api.phanmemquocbao.com/api/info/DeleteAccount?accountId=$userId&token=lethibaotran');
      await http.get(url);
    } catch (err) {
      // ignore: avoid_print
      print(err);
    }
    widget.reloadPage();
  }

  Future<void> makePhoneCall(String phone) async {
    if (await canLaunch('tel:$phone')) {
      await launch('tel:$phone');
    } else {
      throw 'Could not launch $phone';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onLongPress: () {
            // edit value
            funcEditUser(widget.students[index]);
          },
          child: ListTile(
            title: Text( widget.students[index].username + " - "+ widget.students[index].fullname ),
            subtitle: Text(widget.students[index].email),
            leading: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                onPrimary: Colors.white,
              ),
              icon:const Icon(Icons.phone),
              label:const Text("Call"),
              onPressed: () {
                makePhoneCall(widget.students[index].email);
              },
            ),
            trailing: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
                onPrimary: Colors.white,
              ),
              child: const Text('Delete'),
              onPressed: () => handelRequiredDelete(widget.students[index].id),
            ),



          ),
        );
      },
      // ignore: unnecessary_null_comparison
      itemCount: widget.students == null ? 0 : widget.students.length,
    );
  }
}

class CircularProgressIndicatorPage extends StatelessWidget {
  const CircularProgressIndicatorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: CircularProgressIndicator(
      backgroundColor: Colors.blue,
      strokeWidth: 5,
    ));
  }
}
