import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class FireStore extends StatefulWidget {
  @override
  State<FireStore> createState() => _FireStoreState();
}

class _FireStoreState extends State<FireStore> {
  @override
  Widget build(BuildContext context) {
    var r;
    final con = TextEditingController();
    //  con.clear(); // يجب تصفير الكونترولر بعد كتابة قيمة ما فيو في تطبيق الشات
    print('object');

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.exit_to_app),
          onPressed: () {
            FirebaseAuth.instance.signOut();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () async {}

          /*  //add عبرFirestore اضافة حقل ما الى ال
        onPressed: () async {
          FirebaseFirestore.instance
              .collection('chat/32IM1BV41vtIgw6NERCB/mese')
              .add({
            'name': 'kamel',
            'time': Timestamp.now()
          }); // تمرير قيمة الوقت الحالي مشان يرتبن وقت يجيبن بلشات حسب الوقت

//setاضافة كولكشن بشكل يدوي واسناد له قيم بتابع
          FirebaseFirestore.instance
              .collection('new collection')
              .doc(r.user
                  .uid) //r وهو عندي اسمو  create..وذلك من الاوبجكت العائد من استدعاء الدالة idنفس الFirestore خاص به ولذلك نريد اعطاء التخزين في id عندما نقوم بانشاء حساب جديد يقوم باعطاءه
              .set({'name': ''}); // تخزين الاييمل الباسوورد

//1/ قراءة بطريقة الليسينر
          /*  FirebaseFirestore.instance 
              .collection('chat/32IM1BV41vtIgw6NERCB/mese')
              .snapshots()
              .listen((event) {
            event.docs.forEach((element) {
              print(element['name']);
            });
          }); */
//2/ قراءة بطريقة الليسينر
          /*   FirebaseFirestore.instance
              .collection('chat/32IM1BV41vtIgw6NERCB/mese').get()
              .then((value) => value.docs.forEach((element) {
                    print(element['name']);
                  } )); */
//2.2/ليوزر معين id جلب بيانات عن طريق
          var curuse = FirebaseAuth.instance.currentUser;
          var use = FirebaseFirestore.instance
              .collection('chat/32IM1BV41vtIgw6NERCB/mese')
              .doc(curuse.uid)
              .get();
          //  var m = use['name'];
        }, */
          ),
      //1/ Streamولكن هنا لدي منبع من البيانات ويجب ان اقراءها ب
      body: Column(
        children: [
          Container(
            height: 200,
            child: StreamBuilder(
              // stream: FirebaseFirestore.instance.collection("protects").snapshots(),
              //ترتيب حسب حقل معين
              stream: FirebaseFirestore.instance
                  .collection("chats")
                  .orderBy('time', descending: true) // الترتيب تصاعدي او تنازلي
                  .snapshots(),
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting)
                  return CircularProgressIndicator();
                final doc = snapshot.data.docs;
                var cur = FirebaseAuth.instance.currentUser;

                return ListView.builder(
                    reverse: true,
                    itemCount: doc.length,
                    itemBuilder: (ctx, index) {
                      // doc[index].documentID; //userالخاص بل id
                      return Row(
                        mainAxisAlignment: doc[index]['useId'] == cur.uid
                            ? MainAxisAlignment.start
                            : MainAxisAlignment.end,
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                NetworkImage(doc[index]['image_url']),
                            radius: 30,
                          ),
                          Text(
                            doc[index]['username'],
                            style: TextStyle(fontSize: 20),
                          ),
                          FlatButton(
                              onPressed: () {
                                FirebaseFirestore.instance
                                    .collection('chats')
                                    .doc(doc[index].id)
                                    .delete();
                              },
                              child: Text(doc[index]['mess'])),
                        ],
                      );
                    });
              },
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextField(
                controller: con,
              ),
              IconButton(
                  onPressed: () async {
                    var cur = FirebaseAuth.instance.currentUser;
                    var use = await FirebaseFirestore.instance
                        .collection('users')
                        .doc(cur.uid)
                        .get();

                    await FirebaseFirestore.instance.collection('chats').add({
                      'mess': con.text,
                      'time': Timestamp.now(),
                      'username': use['name'],
                      'useId': cur.uid,
                      'image_url': use['image_url']
                    });
                    con.clear();
                  },
                  icon: Icon(Icons.send))
            ],
          )
        ],
      ),
    );
  }
}
