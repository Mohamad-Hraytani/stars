import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:stars/SQL/Sqlmodel.dart';
import 'package:stars/SQL/mySqdb.dart';

import 'Sql1.dart';

class Sqltest extends StatefulWidget {
  @override
  _SqltestState createState() => _SqltestState();
}

class _SqltestState extends State<Sqltest> {
  mySqdb mydb = mySqdb();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder(
            future: mydb.getAll('dogs', 'dogs_db'),
            builder:
                (BuildContext context, AsyncSnapshot<List<Sqmodel>> snapshot) {
              print(snapshot.data);

              switch (snapshot.connectionState) {
                // apiفحص حالة الاتصال مع ال
                case ConnectionState.active: //  نشطة تعمل الان apiال
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());

                case ConnectionState.none:
                  return Center(child: Text('eror'));

                case ConnectionState.done: // اشتغلت شغلا وخلصت
                  if (snapshot
                      .hasError) // رجع خطا nullاذا كان عندي خطا يعني مارجعلي
                    return Center(child: Text(snapshot.error.toString()));

                  if (!snapshot.hasData) // اذا كانت لا تملك بيانات
                    return Center(child: Text('no data'));
                  return n(context, snapshot.data.cast());
                  break;
                default:
                  return Center(child: Text('no conn'));
                  break;
              }
            }),
      ),
    );
  }

  Widget n(BuildContext context, List<dog> dogss) {
    // List<dog> dogs = snap ;
    return ListView.builder(
      itemCount: dogss.length,
      itemBuilder: (BuildContext context, int position) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(dogss[position].name),
            SizedBox(
              width: 15,
            ),
            Text(dogss[position].age.toString()),
            SizedBox(
              width: 15,
            ),
            Text(dogss[position].id.toString()),
            SizedBox(
              width: 15,
            ),
            RaisedButton(onPressed: () async {
              await mydb.update(dog(0, 'mmh0', 100));
            }),
          ],
        );

        /*  ListTile(
          title: Text(dogss[position].name),
          leading: Text(dogss[position].age.toString()),
        ); */
      },
    );
  }
}
