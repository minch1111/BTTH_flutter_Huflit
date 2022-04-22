// ignore_for_file: unnecessary_new

import 'dart:convert';

class User {
  int id;
  String fullname;
  String username;
  // String password;
  String email;

  User({required this.id, required this.fullname,required this.username, required this.email});

  String? get password => null;

  static List<User> parseList(response) {
    var list = json.decode(response.body) as List;
    // ignore: unnecessary_null_comparison
    if(list!= null){
    return list.map((item) => User.fromJson(item)).toList();
    }
    else{
      // ignore: deprecate
      return <User>[];
    }
  }

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['AccountId'],
        fullname: json['FullName'],
        username: json['UserName'],
        email: json['Email'],
      );
}
