import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'dart:async';

import 'Artic.dart';
import 'apiaur.dart';

class Api {
  Map<String, String> headers1 = {'accept': 'application/json'};
  Artic o;
  Future<List<Artic>> fetch(int page) async {
    var news = Uri.parse(
        'https://newsapi.org/v2/everything?domains=techcrunch.com,thenextweb.com&apiKey=' +
            Apiurl.url +
            '+&page=' +
            page.toString());

    var response = await http.get(news, headers: headers1);
/* 
    if (response.statusCode == 200) {
      return null;
    } */

    var body = jsonDecode(response.body);

    var data = body['articles'];

    List<Artic> n = [];
    for (var item in data) {
      var o1 = Artic.fromJson(item);
      n.add(o1);
    }

    /* for (int i = 0; i < 20; i++) n.add(Artic.fromJson(body['articles'][i]));
 */

    for (int i = 0; i < n.length; i++) {
      print(n[i].author);
    }

    return n;
  }
}
