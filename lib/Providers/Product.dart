import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class product with ChangeNotifier {
  final id;
  final title;
  final decreption;
  final price;
  final image;
  bool incard;
  bool isfav;

  product({
    this.decreption,
    this.price,
    this.isfav = false,
    this.id,
    this.title,
    this.image,
    this.incard = false,
  });

  bool get getisfav {
    return isfav;
  }

  bool get getincard {
    return incard;
  }

  void _setcard(bool newval) {
    incard = newval;
    notifyListeners();
  }

  void _setval(bool newval) {
    isfav = newval;
    notifyListeners();
  }

  Future<void> updatecard(String t, String usId) async {
    final oldcard = incard;
    incard = !incard;
    notifyListeners();

    final n0 = Uri.parse(
        "https://mmh1-969e3-default-rtdb.firebaseio.com/usercard/$usId/$id.json?auth=$t");

    try {
      final res = await http.put(n0, body: jsonEncode(incard));

      if (res.statusCode >= 400) _setcard(oldcard);
    } catch (e) {
      _setcard(oldcard);
    }
  }

  Future<void> updatefav(String t, String usId) async {
    final oldfav = isfav;
    isfav = !isfav;
    notifyListeners();

    final n0 = Uri.parse(
        "https://mmh1-969e3-default-rtdb.firebaseio.com/userfav/$usId/$id.json?auth=$t");

    try {
      final res = await http.put(n0, body: jsonEncode(isfav));

      if (res.statusCode >= 400) _setval(oldfav);
    } catch (e) {
      _setval(oldfav);
    }
  }
}
