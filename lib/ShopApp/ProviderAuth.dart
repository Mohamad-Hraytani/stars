import 'dart:async';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class ProviderAuth with ChangeNotifier {
  String myemail;
  var ref = FirebaseDatabase.instance;
  final x = GlobalKey<ScaffoldState>(); // تحت اسم الكلاس اضعه
  String t;
  String usId;
  DateTime ex;
  Timer ti;
  String get tok {
    if (ex != null && ex.isAfter(DateTime.now()) && t != null) {
      return t;
    }
    return null;
  }

  String get Myemail {
    return myemail;
  }

  void setMyemail(String em) {
    myemail = em;
    notifyListeners();
  }

  bool get Auth {
    return tok != null;
  }

  longout() async {
    t = null;
    usId = null;
    ex = null;

    if (ti != null) {
      //تصفير التاميرات اذا كان في شي بقيان من قبل
      ti.cancel();
      ti = null;
    }
    notifyListeners();

    final pre = await SharedPreferences
        .getInstance(); // لازم لما نعمل تسجيل خروج من نمسح البيانات من الشيردبرفرينسس حتى ما يضل متذكرن ويرجع يسجل دخول

    pre.clear();
  }

  String get usid {
    return usId;
  }

  autolongout() {
    // لتجسيل الخروج بشكل تلقائي

    if (ti != null) {
      ti.cancel();
    }
    var timelate = ex
        .difference(DateTime.now())
        .inSeconds; // من هنا نحسب الفرق بين الوقت الحالي والوقت المتبقي لانتهاء مهلة الدخول
    ti = Timer(Duration(seconds: timelate), longout);
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
      // للتاكد ان المستخدم سجل دخول

      t = err['idToken'];
      usId = err['localId'];
      ex = DateTime.now().add(Duration(seconds: int.parse(err['expiresIn'])));

      autolongout(); // نقوم باستدعاء تابع تسجيل الخروج التلقائي هنا
      notifyListeners();
      //SharedPreferences مشان التطبيق يضل يتذكر بيانات الدخول ويدخل لحالو رح نستعمل ال
      final per = await SharedPreferences
          .getInstance(); // هنا نريد ان نحفظ بيانات الدخول حتى يتم تسجيل الدخول التلقائي في المرة القادمة
      final userdate = jsonEncode(
          // مشان نحطن بلمفتاح ونرسلن لانو عنا اكتر من قيمةString نحول البيانات الى
          {'token': t, 'userId': usId, 'expiresIn': ex.toIso8601String()});
      per.setString('userdate', userdate); //String نرسلهم ك
      //tryautlogin ثم نستلمهم بتابع ال

    } catch (e) {
      {
        ToastContext().init(context);

        Toast.show(e,
            duration: 3,
            gravity: Toast.top,
            backgroundColor: Colors.black,
            backgroundRadius: 4,
            textStyle: TextStyle(color: Colors.white));
      }
    }
  }

  Future<void> signUp(String email, String pass, BuildContext context) async {
    await mAPIfirebase(email, pass, 'signUp', context);

    // await puchuser(email, pass);
  }

  Future<void> signIn(String email, String pass, BuildContext context) async {
    await mAPIfirebase(email, pass, 'signInWithPassword', context);
  }

  Future<bool> tryautlogin() async {
    // تابع استقبال القيمة ليحفظها
    final pre = await SharedPreferences.getInstance();
    if (!pre.containsKey('userdate'))
      return false; // نفحص اذا المفتاح فيو بيانات او لا

    final extract = jsonDecode(pre.getString('userdate'))
        as Map<String, Object>; // Mapثم نستقبلهم ونحولهم الى جيسون وثم نحزنها ك
    final ex1 = DateTime.parse(extract[
        'expiresIn']); // نستقبل القيم يلي بداخل المفتاح..ثم نحولها الى نوع وقت
    if (ex1.isBefore(DateTime.now())) {
      // نفحص اذا الوقت المتبقي قبل هلق يعني انتهى
      return false; //false ارجع
    }

    t = extract['token']; // نستقبل البيانات
    usId = extract['userId'];
    ex = ex1;
    notifyListeners();
    autolongout();
    return true; //true بعد استلام البيانات بشكل صحيصح ارجع
  }

/*   puchuser(
    String email,
    String pass,
  ) async {
    final n = Uri.parse(
        "https://mmh1-969e3-default-rtdb.firebaseio.com/usernew.json"); //  اسم الفئة.جيسون jjj.jsonنقوم بنسخ رابط الداتا بيز ونضع باخرو
    http.post(n, body: jsonEncode({"email": email, "password": pass}));
  } */
}
