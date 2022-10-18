//import '../Sqlmodel.dart';

import 'package:stars/SQL/Sqlmodel.dart';

class dog implements Sqmodel {
  int id;
  String name;
  int age;

  dog(this.id, this.name, this.age);

  @override
  Map<String, dynamic> tomap() {
    return {'id': this.id, 'name': this.name, 'age': this.age};
  }

  dog.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.name = map['name'];
    this.age = map['age'];
  }

  @override
  String tabel() {
    return 'dogs';
  }

  @override
  int getid() {
    return this.id;
  }

  @override
  String getnamedb() {
    return 'dogs_db';
  }
}
