/* import 'dart:math';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:stars/ShopApp/ProviderAuth.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:toast/toast.dart';

import 'AUTHPRO.dart';

class AuthScreenTask extends StatefulWidget {
  @override
  State<AuthScreenTask> createState() => _AuthScreenTaskState();
}

class _AuthScreenTaskState extends State<AuthScreenTask> {
  final GlobalKey<FormState> ke = GlobalKey();
  final price = FocusNode();
  final price1 = FocusNode();
  final confprice = FocusNode();
  final confprice1 = FocusNode();

  var passco;
  var conpassco = TextEditingController();
  var ve = TextEditingController();
  var islog = true;
  var dis0 = true;
  var dis = false;
  var dis1 = false;
  double b = -5.0;
  double n = 0.0;
  var t;
  List nm = [];
  @override
  Widget build(BuildContext context) {
    print('object');
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [Colors.pink, Colors.white],
            )),
            child: Center(
              child: AnimatedContainer(
                onEnd: () {
                  setState(() {
                    b = 0.0;
                    n = 0.0;
                  });
                },
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 1,
                        color: Colors.white,
                        offset: Offset(1, n == 0 ? 0 : 50))
                  ],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                ),
                duration: Duration(seconds: 1.5.toInt()),
                curve: Curves.linear,
                height: islog ? 365 : 315,
                width: 320,
                alignment: islog ? Alignment(n, n) : Alignment(-b, b),
                child: Container(
                  padding: EdgeInsets.only(top: 10),
                  width: 300,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 1,
                            color: Colors.pink,
                            offset: Offset(1, 5))
                      ],
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20))),
                  child: Form(
                      key: ke,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextFormField(
                                key: ValueKey('0'),
                                enabled: dis1 ? true : false,
                                keyboardType: TextInputType.emailAddress,
                                style: TextStyle(),
                                decoration: InputDecoration(
                                  suffixText: "@gmail.com",
                                  prefixIcon: Icon(Icons.alternate_email_sharp),
                                  contentPadding: EdgeInsets.all(5),
                                  labelText: 'Enter Your Email',
                                ),
                                validator: (value) {
                                  if (value.isEmpty ||
                                      !value.contains('@') ||
                                      value.length < 5)
                                    return 'Please Enter a correct value';
                                  else
                                    return null;
                                },
                                onSaved: (b) {
                                  Provider.of<AUTHPRO>(context, listen: false)
                                      .setema(b);
                                },
                                textInputAction: TextInputAction.next,
                                onFieldSubmitted: (_) {
                                  FocusScope.of(context).requestFocus(price1);
                                }),
                            TextFormField(
                                key: ValueKey('1'),
                                enabled: dis1 ? true : false,
                                keyboardType: TextInputType.name,
                                style: TextStyle(),
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.alternate_email_sharp),
                                  contentPadding: EdgeInsets.all(5),
                                  labelText: 'Enter Your NAME',
                                ),
                                validator: (value) {
                                  if (value.isEmpty)
                                    return 'Please Enter Your name';
                                  else
                                    return null;
                                },
                                onChanged: (b) {
                                  Provider.of<AUTHPRO>(context, listen: false)
                                      .setnam(b);
                                },
                                textInputAction: TextInputAction.next,
                                onFieldSubmitted: (_) {
                                  FocusScope.of(context).requestFocus(price);
                                },
                                focusNode: price1),
                            TextFormField(
                                key: ValueKey('2'),
                                enabled: dis1 ? true : false,
                                style: TextStyle(),
                                obscureText: true,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.security),
                                  contentPadding: EdgeInsets.all(5),
                                  labelText: 'Enter Your password',
                                ),
                                validator: (value) {
                                  if (value.isEmpty || value.length < 8)
                                    return 'Please Enter a correct value';
                                  else
                                    return null;
                                },
                                onSaved: (b) {
                                  passco = b;
                                },
                                focusNode: price,
                                textInputAction: TextInputAction.next,
                                onFieldSubmitted: (_) {
                                  FocusScope.of(context)
                                      .requestFocus(confprice);
                                }),
                            islog
                                ? TextFormField(
                                    key: ValueKey('3'),
                                    enabled: dis1 ? true : false,
                                    style: TextStyle(),
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.spellcheck_sharp),
                                      contentPadding: EdgeInsets.all(5),
                                      labelText: 'Enter Your same Password',
                                    ),
                                    validator: (value1) {
                                      if (value1 != passco) {
                                        return 'your password is not corecct';
                                      }
                                      if (value1.isEmpty || value1.length < 8)
                                        return 'Please Enter a correct value';
                                      else
                                        return null;
                                    },
                                    focusNode: confprice,
                                    textInputAction: TextInputAction.next,
                                    onFieldSubmitted: (_) {
                                      FocusScope.of(context)
                                          .requestFocus(confprice1);
                                    })
                                : Container(),
                            dis0
                                ? TextFormField(
                                    key: ValueKey('4'),
                                    keyboardType: TextInputType.phone,
                                    style: TextStyle(),
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.phone),
                                      contentPadding: EdgeInsets.all(5),
                                      labelText: 'Enter Your Phone',
                                      labelStyle: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    onChanged: (value) {
                                      nm.add(value);
                                    },
                                    validator: (value) {
                                      if (value.isEmpty ||
                                          value.length < 8 ||
                                          !value.startsWith('+9'))
                                        return 'Please Enter a correct value';
                                      else
                                        return null;
                                    },
                                    focusNode: confprice1,
                                  )
                                : Container(),
                            dis0
                                ? RaisedButton(
                                    onPressed: () async {
                                      final rand = Random();
                                      setState(() {
                                        t = rand.nextInt(10000);
                                      });
                                      print(t.toString());

                                      try {
                                        await sendSMS(
                                            message: t.toString(),
                                            recipients: nm);
                                        setState(() {
                                          dis = true;
                                          dis0 = false;
                                        });
                                      } catch (e) {
                                        ToastContext().init(context);
                                        Toast.show(e,
                                            duration: 3,
                                            gravity: Toast.top,
                                            backgroundColor: Colors.black,
                                            backgroundRadius: 4,
                                            textStyle:
                                                TextStyle(color: Colors.white));
                                      }
                                    },
                                    child: Text('verification '))
                                : Container(),
                            dis
                                ? RaisedButton(
                                    color: Colors.green.shade100,
                                    onPressed: () async {
                                      try {
                                        if (ve.text == t.toString()) {
                                          ToastContext().init(context);
                                          Toast.show('write code',
                                              duration: 3,
                                              gravity: Toast.top,
                                              backgroundColor: Colors.white,
                                              backgroundRadius: 4,
                                              textStyle: TextStyle(
                                                  color: Colors.green,
                                                  fontSize: 20));
                                          setState(() {
                                            dis = false;
                                            dis1 = true;
                                          });
                                        }
                                      } catch (e) {
                                        ToastContext().init(context);
                                        Toast.show(e,
                                            duration: 3,
                                            gravity: Toast.top,
                                            backgroundColor: Colors.black,
                                            backgroundRadius: 4,
                                            textStyle:
                                                TextStyle(color: Colors.white));
                                      }
                                    },
                                    child: Text('verification '))
                                : Container(),
                            dis
                                ? TextFormField(
                                    key: ValueKey('5'),
                                    controller: ve,
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(),
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.spellcheck_sharp),
                                      contentPadding: EdgeInsets.all(5),
                                      labelText: 'Enter Your code',
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty)
                                        return 'Please Enter a correct value';
                                      else
                                        return null;
                                    },
                                  )
                                : Container(),
                            dis1
                                ? RaisedButton(
                                    onPressed: () async {
                                      mydb mydb1 = mydb();
                                      mydb1.userdata();
                                      await mydb1.insert(us(
                                          0,
                                          Provider.of<AUTHPRO>(context,
                                                  listen: false)
                                              .nameco));

/*  var h = await mydb1.getAll('user', 'userdb1.db');print(h[0].name); */ //التاكد من الحصول على الاسم

                                      ke.currentState.validate();
                                      ke.currentState.save();
                                      if (ke.currentState.validate()) {
                                        islog
                                            ? Provider.of<AUTHPRO>(context,
                                                    listen: false)
                                                .signIn(
                                                    Provider.of<AUTHPRO>(
                                                            context,
                                                            listen: false)
                                                        .emailco,
                                                    passco,
                                                    context)
                                                .then((_) {
                                                ToastContext().init(context);
                                                Toast.show(
                                                    'Welcom ${Provider.of<AUTHPRO>(context, listen: false).nameco} \nyour email is: ${Provider.of<AUTHPRO>(context, listen: false).emailco}',
                                                    duration: 3,
                                                    gravity: Toast.top,
                                                    backgroundColor:
                                                        Colors.black,
                                                    backgroundRadius: 4,
                                                    textStyle: TextStyle(
                                                        color: Colors.white));
                                              })
                                            : Provider.of<AUTHPRO>(context,
                                                    listen: false)
                                                .signUp(
                                                    Provider.of<AUTHPRO>(
                                                            context,
                                                            listen: false)
                                                        .emailco,
                                                    passco,
                                                    context)
                                                .then((_) {
                                                ToastContext().init(context);
                                                Toast.show(
                                                    'Welcom ${Provider.of<AUTHPRO>(context, listen: false).nameco} \nyour email is: ${Provider.of<AUTHPRO>(context, listen: false).emailco}',
                                                    duration: 3,
                                                    gravity: Toast.top,
                                                    backgroundColor:
                                                        Colors.black,
                                                    backgroundRadius: 4,
                                                    textStyle: TextStyle(
                                                        color: Colors.white));
                                              });
                                      }
                                    },
                                    child: islog
                                        ? Text('SingIn')
                                        : Text('Regester'),
                                  )
                                : Container(),
                            FlatButton(
                              onPressed: () {
                                setState(() {
                                  islog = !islog;
                                  n = -5.0;
                                  b = -5.0;
                                });
                              },
                              child: islog
                                  ? Text('Create account')
                                  : Text('SingIn'),
                            )
                          ],
                        ),
                      )),
                ),
              ),
            )));
  }
}

class mydb {
  Future<Database> userdata() async {
    return openDatabase(
      join(await getDatabasesPath(), 'userdb1.db'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE user (id INTEGER PRIMERY KEY, username TEXT)');
      },
      version: 1,
    );
  }

  Future<void> insert(us model) async {
    final Database db = await userdata();
    await db.insert(model.tabel(), model.tomap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    db.close();
  }

  /* Future<List<us>> getAll(String table, String dbname) async { //التاكد من الحصول على الاسم
    //  اذا عندي اكثر من موديل
    final Database db = await userdata();

    List<Map<String, dynamic>> maps = await db.query(table);
    List<us> models = [];
    for (var item in maps) models.add(us.fromMap(item));
    return models;
  } */
}

class us {
  int id;
  String name;

  us(
    this.id,
    this.name,
  );

  @override
  int getid() {
    return this.id;
  }

  @override
  Map<String, dynamic> tomap() {
    return {
      'id': this.id,
      'username': this.name,
    };
  }

  us.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.name = map['username'];
  }

  @override
  String tabel() {
    return 'user';
  }
}
 */