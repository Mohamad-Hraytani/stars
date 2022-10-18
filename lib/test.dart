/* import 'package:cloud_firestore/cloud_firestore.dart';
//import 'dart:html';
import 'dart:math';

//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'dart:html';
import 'firebase_auth.dart';
import 'dart:async';
//import 'package:image_picker/image_picker.dart';
//import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'dart:async';
import 'dart:io' as io;

class test1 extends StatefulWidget {
  @override
  _test1State createState() => _test1State();
}

class _test1State extends State<test1> {
  List<int> me = [1, 2, 3];
  // File file;
  int s;
  TextEditingController t1 = new TextEditingController();
  TextEditingController t2 = new TextEditingController();
  auc au1 = auc();
  io.File _image;

  /* final ImagePicker _picker = ImagePicker();

  get() async {
    final XFile image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image as io.File;
    });
  }

  Future<void> getpup(io.File image) async {
    /*  firebase_storage.Reference ref =
        firebase_storage.FirebaseStorage.instance.ref(_image.path);
    firebase_storage.UploadTask g =
        firebase_storage.FirebaseStorage.instance.ref(_image); */
  }

  List<firebase_storage.UploadTask> _uploadTasks = [];

  /// The user selects a file, and the task is added to the list.
  Future<firebase_storage.UploadTask> uploadFile(PickedFile file) async {
    if (file == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('No file was selected'),
      ));
      return null;
    }

    firebase_storage.UploadTask uploadTask;

    // Create a Reference to the file
    firebase_storage.Reference ref =
        firebase_storage.FirebaseStorage.instance.ref().child(file.path);
    //.child('/some-image.jpg');

    final metadata = firebase_storage.SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': file.path});

    if (kIsWeb) {
      uploadTask = ref.putData(await file.readAsBytes(), metadata);
    } else {
      uploadTask = ref.putFile(io.File(file.path), metadata);
    }

    return Future.value(uploadTask);
  }

  Future getcame() async {
//var image= await ImagePicker
  } */

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    t1.dispose();
    t2.dispose();
  }

  String j;
  bool b = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  // var v1;
  final _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnimatedOpacity(
      opacity: b ? 1 : 0,
      duration: Duration(seconds: 10),
      child: ListView(
        children: [
          Form(
            key: _key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) return "no";
                    return null;
                  },
                  cursorColor: Colors.black,
                  controller: t1,
                  decoration: InputDecoration(hintText: 'email'),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) return "no";
                    return null;
                  },
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  cursorColor: Colors.black,
                  obscureText: true,
                  controller: t2,
                  decoration: InputDecoration(hintText: 'password'),
                ),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(onPressed: () async {
                  if (_key.currentState.validate()) {
                    var v1 = await FirebaseFirestore.instance
                        .collection("protects")
                        .where('name',
                            isEqualTo: t1
                                .text) // جيب كل الكلمات يلي مخزنة عندي يلي اسما نفسو يلي دخلتو
                        .snapshots()
                        .first;

                    if (v1.docs.length >=
                        1) // اذا كان موجود مسبقا طالع رسالة خطا
                      print(' الفئة موجودة مسبقا');
                    else
                      FirebaseFirestore.instance // والا ضيفو
                          .collection('protects')
                          .doc()
                          .set({
                        'name': t1.text,
                        'age': t2.text,
                        "long": 183
                      }).then((value) => {}); // بس تخلص شو رح تعمل
                  }
                }),
                RaisedButton(
                  onPressed: () async {
                    /*      PickedFile file = await ImagePicker()
                        .getImage(source: ImageSource.gallery);
                    firebase_storage.UploadTask task = await uploadFile(file);
                    if (task != null) {
                      setState(() {
                        _uploadTasks = [..._uploadTasks, task];
                      });
                    }*/
                  },
                  child: Text('cam'),
                )
              ],
            ),

            /* RaisedButton(onPressed: () async {
                      print('${t1.text}  and  ${t2.text}');
                      String email = t1.text;
                      String password = t2.text;
                      var user = await au1.register(email, password);
                      print(user);
                    }),
                    RaisedButton(onPressed: () async {
                      var user = await au1.cure();
                      print(user);
                    }),
                    RaisedButton(onPressed: () async {
                      await au1.sinout();
                    }),
                    RaisedButton(onPressed: () async {
                      String email = t1.text;
                      String password = t2.text;
                      var s = await au1.sing(email, password);
                      print(s);
                    }) */
          ),
          // dro(),
          /*   Expanded(
            child: SizedBox(
              height: 300,
              // width: 200,
              child: n(),
            ),
          ) */
        ],
      ),
    ));
  }

  /* Widget n() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('protects').snapshots(),
      // stream: FirebaseFirestore.instance.collection('protects').orderBy('field' , descending: true).snapshots(),// ترتيب حسب حقل معين
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
            return ListTile(
              title: Text(document['name']),
              subtitle: Text(document['age'].toString()),
              trailing: IconButton(
                // (id) حذف سجل معين حسب ال
                icon: Icon(Icons.delete),
                onPressed: () {
                  FirebaseFirestore.instance
                      .collection('protects')
                      .doc(document.id)
                      .delete();
                },
              ),
            );
          }).toList(),
        );
      },
    );
  } */

  String val = 'mohamad';
/*   Widget dro() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('protects').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return DropdownButton<String>(
              onChanged: (String newvalue) {
                setState(() {
                  val = newvalue;
                });
              },
              value: val,
              items: snapshot.data.docs.map((DocumentSnapshot document) {
                return DropdownMenuItem<String>(
                    value: document['name'], child: Text(document['name']));
              }).toList());
        });
  } */
}
 */