import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:stars/SQL/Sqlmodel.dart';
import 'package:stars/SQL/Sql1.dart';

class mySqdb {
  Future<Database> dogdata() async {
    return openDatabase(
      join(await getDatabasesPath(), 'dogs_db.db'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE dogs (id INTEGER PRIMERY KEY, name TEXT, age INTEGER)');
      },
      version: 1,
    );
  }

  Future<void> insert(Sqmodel model) async {
    final Database db = await dogdata();
    await db.insert(model.tabel(), model.tomap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    db.close();
  }

  Future<void> delete(Sqmodel model) async {
    final Database db = await dogdata();
    await db.delete(model.tabel(), where: 'id = ?', whereArgs: [model.getid()]);
    db.close();
  }

  Future<void> update(Sqmodel model) async {
    final Database db = await dogdata();
    await db.update(model.tabel(), model.tomap(),
        where: 'id = ?', whereArgs: [model.getid()]);
    db.close();
  }

  Future<List<Sqmodel>> getAll(String table, String dbname) async {
    //  اذا عندي اكثر من موديل
    final Database db = await dogdata();

    final List<Map<String, dynamic>> maps = await db.query(table);
    List<Sqmodel> models = [];
    for (var item in maps) models.add(dog.fromMap(item));
    return models;
  }
}
