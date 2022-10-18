import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class firestorage extends StatefulWidget {
  @override
  State<firestorage> createState() => _firestorageState();
}

class _firestorageState extends State<firestorage> {
  File f;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          ///مساعدة
          var Au = FirebaseAuth.instance;
          final Au1 =
              await Au.signInWithEmailAndPassword(email: 'email', password: '');

          ///مساعدة

          final ref = FirebaseStorage.instance
              .ref() // جلب باغيت جديد للتخزين او مصدر جديد للتخزين
              .child('user_image') // نسميه بهذا الاسم
              .child(
                  Au1.user.uid + '.jpg'); // ثم نعطي لكل ملف مرفوع اسم خاص فيه
//مشان نعطي شي مخصص لكل صورة شخصية خاصة بيوزر معين Authنفسو تبع ال idواستعنا بل

          await ref.putFile(f); //Storage قمنا هنا برفع الملف الى ال
          var url = await ref
              .getDownloadURL(); //ويكون خاص بهل مستخدم Storeممكن الحصول على رابط خاص بلصورة يلي اخترناها مشان خزنو بل

          ///Storeمساعدة وتخزين بل
          FirebaseFirestore.instance.collection('user').doc(Au1.user.uid).set({
            'email': 'co.text',
            'pass': 'co2.text',
            'name': 'co3.text',
            'image_url': url
          });
        },
      ),
    );
  }
}
