/* import 'dart:async';
import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class AUTHPRO with ChangeNotifier {
  var emailco;
  var nameco;

  var ref = FirebaseDatabase.instance;
  final x = GlobalKey<ScaffoldState>();
  String t;
  String usId;
  DateTime ex;
  Timer ti;
  void setema(String ema) {
    emailco = ema;
  }

  void setnam(String nam) {
    nameco = nam;
  }

  String get tok {
    if (ex != null && ex.isAfter(DateTime.now()) && t != null) {
      return t;
    }
    return null;
  }

  bool get Auth1 {
    return tok != null;
  }

  longout() async {
    t = null;
    usId = null;
    ex = null;

    if (ti != null) {
      ti.cancel();
      ti = null;
    }
    notifyListeners();

    final pre = await SharedPreferences.getInstance();

    pre.clear();
  }

  String get usid {
    return usId;
  }

  autolongout() {
    if (ti != null) {
      ti.cancel();
    }
    var timelate = ex.difference(DateTime.now()).inSeconds;
    ti = Timer(Duration(seconds: timelate), longout);
  }

  Future<void> mAPIfirebase(
      String email, String pass, String typeSing, BuildContext context) async {
    var url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:$typeSing?key=AIzaSyD6h4f9Rt3_t7izuiKJHJQo-R5LuenKSBE');
    try {
      var u = await http.post(url,
          body: jsonEncode(
              {'email': email, 'password': pass, 'returnSecureToken': true}));
      var err = jsonDecode(u.body);
      if (err['error'] != null) {
        throw "${err['error']['message']}";
      }

      t = err['idToken'];
      usId = err['localId'];
      ex = DateTime.now().add(Duration(seconds: int.parse(err['expiresIn'])));

      autolongout();
      notifyListeners();

      final per = await SharedPreferences.getInstance();
      final userdate = jsonEncode(
          {'token': t, 'userId': usId, 'expiresIn': ex.toIso8601String()});
      per.setString('userdate', userdate);
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
  }

  Future<void> signIn(String email, String pass, BuildContext context) async {
    await mAPIfirebase(email, pass, 'signInWithPassword', context);
  }

  Future<bool> tryautlogin() async {
    final pre = await SharedPreferences.getInstance();
    if (!pre.containsKey('userdate')) return false;

    final extract =
        jsonDecode(pre.getString('userdate')) as Map<String, Object>;
    final ex1 = DateTime.parse(extract['expiresIn']);
    if (ex1.isBefore(DateTime.now())) {
      return false;
    }

    t = extract['token'];
    usId = extract['userId'];
    ex = ex1;
    notifyListeners();
    autolongout();
    return true;
  }
}
 */