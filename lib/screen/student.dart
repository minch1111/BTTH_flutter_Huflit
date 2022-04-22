class Student{
  int id;
  String name;
  String address;

  Student({ required this.id, required this.name, required this.address});

  factory Student.fromJson(Map<String, dynamic> res){
    return Student(
      name:res['empname'] as String,
      address: res['department'] as String, id: res['id'] as int
    );
  }
}