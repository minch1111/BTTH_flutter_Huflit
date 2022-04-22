import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:huflit_flutter/screen/student.dart';

class JsonPage extends StatefulWidget {
  const JsonPage({Key? key}) : super(key: key);

  @override
  _JsonPageState createState() => _JsonPageState();
}

class _JsonPageState extends State<JsonPage> {
  // ignore: unused_field
  final String _data = '';
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Load JSON File From Local"),
      ),
      body: Center(
        child: buildFutureBuilderAssets(context),
      ),
    );
  }

  FutureBuilder<String> buildFutureBuilderAssets(BuildContext context) {
    return FutureBuilder(
      future:
          DefaultAssetBundle.of(context).loadString("assets/emprecord.json"),
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
              List<Student> listStudent = parseJson(snapshot.data.toString());
              return listStudent.isNotEmpty
                  ? ListEmployee(students: listStudent)
                  : const Text("file is empty");
            }
        }
      },
    );
  }

  String getStringFromBytes(ByteData data) {
    final buffer = data.buffer;
    var list = buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    return utf8.decode(list);
  }

  List<Student> parseJson(String response) {
    // ignore: unnecessary_null_comparison
    if (response == null) {
      return [];
    }
    final parsed =
        json.decode(response.toString()).cast<Map<String, dynamic>>();
    return parsed.map<Student>((json) => Student.fromJson(json)).toList();
  }
}

// ignore: must_be_immutable
class ListEmployee extends StatelessWidget {
  List<Student> students;
  ListEmployee({Key? key, required this.students}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(students[index].name),
          subtitle: Text(students[index].address),
        );
      },
      // ignore: unnecessary_null_comparison
      itemCount: students == null ? 0 : students.length,
    );
  }
}

class CircularProgressIndicatorPage extends StatelessWidget {
  const CircularProgressIndicatorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
        child:  CircularProgressIndicator(
      backgroundColor: Colors.blue,
      strokeWidth: 5,
    ));
  }
}
