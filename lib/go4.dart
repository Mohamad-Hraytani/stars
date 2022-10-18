import 'dart:async';
import 'dart:convert';

import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stars/FireBase.dart/FireStore.dart';
import 'package:toast/toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stars/MyProvider.dart';
import 'package:stars/SQL/Sql1.dart';

import 'go3.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb;
import 'package:flutter/material.dart';

import 'firebase_options.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class go4 extends StatefulWidget {
  @override
  State<go4> createState() => _go4State();
}

class _go4State extends State<go4> with SingleTickerProviderStateMixin {
  static const List<String> image = [
    'lib/img/main.png',
    'lib/img/one.png',
    'lib/img/tow.png',
  ];

  tot(String e, BuildContext context) {
    ToastContext().init(
        context); // bulid لانو انا خارج الدالة contextوضعت هي مشان تأهيت ال
    Toast.show(
      e, // النص الظاهر
      duration: 10,
      gravity: Toast.bottom, // المكان
      //  backgroundColor: Colors.black,// لون خلفية الاشعار
      backgroundRadius: 4, // تدوير اطار الاشعار
      // textStyle: TextStyle()
    );
  }

  List<post> mmh = [];

  String t;
  String us;
  DateTime ex;

  String get tok {
    if (ex != null && ex.isAfter(DateTime.now()) && t != null) {
      return t;
    }
    return null;
  }

  bool get Auth {
    return tok != null;
  }

  Future<void> mAPIfirebase(
      String email, String pass, String typeSing, BuildContext context) async {
    var url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:$typeSing?key=AIzaSyD6h4f9Rt3_t7izuiKJHJQo-R5LuenKSBE');

    try {
      //لمعالجة اخطاء الايملات وكلمات السر لانو هون مافي معالجة اتوماتيكية
      var u = await http.post(url,
          body: jsonEncode(
              {'email': email, 'password': pass, 'returnSecureToken': true}));
      var err = jsonDecode(u.body);
      if (err['error'] != null) {
        //error لانو المفتاح يلي بجي فيو الخطأ اسمو
        throw "${err['error']['message']}";
      } // catchثم ارميه بشكل يديوي لل error يلي بقلب المفتاح'message استخراج رسالة الخطامن قلب المفتاح

    } catch (e) {
      tot(e.toString(),
          context); // مررت الى تابع  وحصرا مع كونتكسToast حتى يطبعلي الخطا
    }
  }

  File f;
  var pic = ImagePicker();

  Future get() async {
    final t = await pic.getImage(
        source: ImageSource.gallery,
        // source: ImageSource.gallery
        imageQuality: 50, // جودة الصورة
        maxWidth: 150 //عرض الصورة
        );
    setState(() {
      if (t != null) {
        f = File(t.path);
      } else
        print('object');
    });
  }

  final ke = GlobalKey<FormState>();
  var co = TextEditingController();
  var co2 = TextEditingController();
  var co3 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    print('object');
    var Au = FirebaseAuth.instance;
    var fire = FirebaseFirestore.instance;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              setState(() {
                co.text = 'm.mhraytani.m@gmail.com';
                co2.text = '0955630801@mmh';
                co3.text = 'mohamd';
              });
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            try {
              var r1 = await Au.createUserWithEmailAndPassword(
                  email: co.text, password: co2.text);

              final ref = FirebaseStorage.instance
                  .ref() // جلب باغيت جديد للتخزين او مصدر جديد للتخزين
                  .child('user_image') // نسميه بهذا الاسم
                  .child(r1.user.uid + '.jpg');

              await ref.putFile(f); //Storage قمنا هنا برفع الملف الى ال
              var url = await ref.getDownloadURL();

              await FirebaseFirestore.instance
                  .collection('users')
                  .doc(r1.user.uid)
                  .set({
                'email': co.text,
                'pass': co2.text,
                'name': co3.text,
                'image_url': url
              }).then((value) => print('plese enter to app'));
            } catch (e) {
              print(e);
            }
          },
        ),
        body: RefreshIndicator(
          onRefresh: () async => null,
          child: Column(
            children: [
              Form(
                  key: ke,
                  child: Column(
                    children: [
                      AnimatedContainer(
                        duration: Duration(seconds: 5),
                        curve: Curves.linear,
                        //   height: f == null ? 100 : 200,
                        constraints: BoxConstraints(
                          maxHeight: f == null ? 100 : 200,
                          //   maxWidth: f == null ? 100 : 200
                        ),
                        child: FlatButton(
                          shape: CircleBorder(side: BorderSide.none),
                          onPressed: get,
                          child: CircleAvatar(
                            backgroundImage: f == null
                                ? Image.network(
                                        'https://www.ums-ncn.com/LiveUms/ums/upload/website/NCN_1301624557503.jpg')
                                    .image
                                : Image.file(
                                    f,
                                    fit: BoxFit.contain,
                                  ).image,
                            radius: f == null ? 50 : 100,
                          ),
                        ),
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'key'),
                        controller: co,
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'value'),
                        controller: co2,
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'name'),
                        controller: co3,
                      ),
                      FloatingActionButton(
                        onPressed: () {
                          try {
                            Au.signInWithEmailAndPassword(
                                email: co.text, password: co2.text);
                          } catch (e) {
                            print(e);
                          }
                        },
                      )
                    ],
                  )),
            ],
          ),
        ));
  }
}

void here(String co, String co2) async {}

class post {
  String id;
  String name;
  post({this.id, this.name});
}
