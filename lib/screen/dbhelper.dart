import 'dart:io';
// ignore: unused_import
import 'dart:typed_data';
import 'dart:core';
// ignore: unused_import
import 'package:flutter/services.dart';
import 'package:huflit_flutter/screen/student.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
// ignore: duplicate_import
import 'package:path/path.dart';

class DBHelper {
  copyDB() async {
    // Construct a file path to copy database to
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "student.db");

// Only copy if the database doesn't exist
    if (FileSystemEntity.typeSync(path) == FileSystemEntityType.notFound) {
      // Load database from asset and copy
      ByteData data = await rootBundle.load(join('assets', 'student.db'));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Save copied asset to documents
      await File(path).writeAsBytes(bytes);
    }
  }

  openDB() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String databasePath = join(appDocDir.path, 'student.db');

    return await openDatabase(databasePath);
  }

  static final DBHelper db = DBHelper._();
  static Database? _database;

  DBHelper._();

  Future<Database?> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "TestDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Students ("
          "id INTEGER PRIMARY KEY,"
          "name TEXT,"
          "address TEXT"
          ")");
    });
  }

  Future<List<Student>> getStudents() async {
    List<Student> data = <Student>[];
    Database? db = await database;
    // var list = await db.rawQuery('SELECT * FROM Students');
    List<Student> list = (await db?.query('Students'))!.cast<Student>();
    for (var item in list.toList()) {
     data.add(Student(
          id: item.id, name: item.name, address: item.address));
    }
    // for (var i = 0; i < list!.length; i++) {

    // }
    return data;
  }

  Future<int> insertStudent(Student student) async {
    Database? db = await database;
    Map<String, String> values = {
      'name': student.name,
      'address': student.address
    };
    var result = db!.insert('Students', values);
    return result;
  }

  Future<int> updateStudent(Student student) async {
    Database? db = await database;
    Map<String, String> values = {
      'name': student.name,
      'address': student.address
    };
    var result =
        db!.update('Students', values, where: 'id=?', whereArgs: [student.id]);
    return result;
  }

  Future<int> deleteStudent(int id) async {
    Database? db = await database;
    var result = db!.delete('Students', where: 'id=?', whereArgs: [id]);
    return result;
  }

  countStudent() async {
    Database? db = await database;
    var count = Sqflite.firstIntValue(
        await db!.rawQuery('SELECT COUNT(*) FROM Students'));
    return count;
  }
}
