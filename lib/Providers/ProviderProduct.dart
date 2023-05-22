import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:stars/Providers/Product.dart';


class ProviderProduct with ChangeNotifier {
  String authtoken;
  String userId;
  List<product> _items = [];
  int numitem = 0;
  var total = 0;




   void getNumberOfItemsInMyCard() {
  
    List<product> itemcard =
        items.where((element) => element.incard == true).toList();
  numitem = itemcard.length;
  notifyListeners();
  }

  setnumitem(int b) {
    numitem = b;
    notifyListeners();
  }



  List<product> get items {
    return [..._items];
  }

  getsum() {
    total = 0;
    final List<product> itemcard1 =
        items.where((element) => element.incard == true).toList();

    itemcard1.forEach((element) {
      total =
          total + int.parse(element.price.substring(1, element.price.length));
      print(total);
    });

    return total;
  }

  getdata(String token, String usID, List<product> proo) {
    authtoken = token;
    userId = usID;
    _items = proo;
    notifyListeners();
  }



  Future<void> fetchdata([bool filter]) async {
    final myfilter = filter ? 'orderBy="userId"&equalTo="$userId"' : '';
    try {
      final n = Uri.parse(
          "https://mmh1-969e3-default-rtdb.firebaseio.com/usernew.json?auth=$authtoken&$myfilter");

      final res1 = await http.get(n);
      final res = jsonDecode(res1.body) as Map<String, dynamic>;

      final n1 = Uri.parse(
          "https://mmh1-969e3-default-rtdb.firebaseio.com/userfav/$userId.json?auth=$authtoken");
      final resva1 = await http.get(n1);
      final resva = jsonDecode(resva1.body);

      final n2 = Uri.parse(
          "https://mmh1-969e3-default-rtdb.firebaseio.com/usercard/$userId.json?auth=$authtoken");
      final resca1 = await http.get(n2);
      final resca = jsonDecode(resca1.body);

      final List<product> L1 = [];
      if (res == null) {
        _items = [];
        notifyListeners();
      } else {
        res.forEach((key, value) {
          print(key);
          L1.add(product(
            id: key,
            title: value['title'],
            decreption: value['decreption'],
            image: value['image'],
            price: value['price'],
            isfav: resva == null ? false : resva[key] ?? false,
            incard: resca == null ? false : resca[key] ?? false,
          ));
        });

       _items =  L1;
        notifyListeners();
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  updateuserID(String id1) async {
    final n = Uri.parse(
        "https://mmh1-969e3-default-rtdb.firebaseio.com/usernew/$id1/userId.json?auth=$authtoken");

    final res1 = await http.get(n);
    final res = jsonDecode(res1.body);

    if (res == null || res != userId)
      await http
          .put(n, body: jsonEncode(userId))
          .then((value) => print('commmmm'));
    else
      return;
  }

  Future<void> addT(product p) async {
    final n = Uri.parse(
        "https://mmh1-969e3-default-rtdb.firebaseio.com/usernew.json?auth=$authtoken");

    final res = await http.post(n,
        body: jsonEncode({
          "title": p.title,
          "price": p.price,
          "decreption": p.decreption,
          "image": p.image
        }));

    final newp = product(
      id: jsonDecode(res.body)['name'],
      title: p.title,
      price: p.price,
      decreption: p.decreption,
      image: p.image,
    );
    items.add(newp);
    notifyListeners();
  }

/*   Future<void> updateT(String id, product p) async {
    var newwid = items.indexWhere((element) => element.id == id);
    if (newwid >= 0) {
      final n = Uri.parse(
          "https://mmh1-969e3-default-rtdb.firebaseio.com/usernew/$id.json?auth=$authtoken");

      final res = await http.patch(n,
          body: jsonEncode({
            'title': p.title,
            'price': p.price,
            'decreption': p.decreption,
            'image': p.image,
          }));
      items[newwid] = p;
      notifyListeners();
    } else {
      print('>>>>');
    }
  } */

/*   Future<void> deletT(String id) async {
    final n = Uri.parse(
        "https://mmh1-969e3-default-rtdb.firebaseio.com/usernew/$id.json?auth=$authtoken");

    var indexit = items.indexWhere((element) => element.id == id);
    var it = items[indexit];
    items.removeAt(indexit);
    notifyListeners();
    var res = await http.delete(n);

    if (res.statusCode >= 400) {
      items.insert(indexit, it);
      notifyListeners();
      throw ('error delet');
    }
    it = null;
  } */

/*   Future<void> addautoitem() async {
    try {
      final n = Uri.parse(
          "https://mmh1-969e3-default-rtdb.firebaseio.com/usernew.json?auth=$authtoken");

      await http.post(n,
          body: jsonEncode({
            "userId": userId,
            "title": 'gray car',
            "decreption": 'csacscsa',
            "price": '\$200',
            "image":
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSVljXMT4gijxvpJhtvudgPbNwolG1iWskJyQ&usqp=CAU'
          }));

      await http.post(n,
          body: jsonEncode({
            "userId": userId,
            "title": 'blue car',
            "decreption": 'csacscsa',
            "price": '\$500',
            "image":
                'https://media.istockphoto.com/photos/sport-car-picture-id176667558?k=20&m=176667558&s=170667a&w=0&h=n9i2U4QLKOIhUMhmdXr5XhhXyFro83q_XI6One7AYDE='
          }));

      await http.post(n,
          body: jsonEncode({
            "userId": userId,
            "title": 'red car',
            "decreption": 'csacscsa',
            "price": '\$100',
            "image":
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSVljXMT4gijxvpJhtvudgPbNwolG1iWskJyQ&usqp=CAU'
          }));

      await http.post(n,
          body: jsonEncode({
            "userId": userId,
            "title": 'green car',
            "decreption": 'csacscsa',
            "price": '\$300',
            "image":
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSVljXMT4gijxvpJhtvudgPbNwolG1iWskJyQ&usqp=CAU'
          }));
    } catch (e) {
      throw e.toString();
    }
  } */

/*   List<product> _items = [
    product(
        id: 1,
        title: 'blue car',
        decreption: 'csacscsa',
        price: '\$500',
        image:
            'https://media.istockphoto.com/photos/sport-car-picture-id176667558?k=20&m=176667558&s=170667a&w=0&h=n9i2U4QLKOIhUMhmdXr5XhhXyFro83q_XI6One7AYDE='),
    product(
        id: 2,
        title: 'red car',
        decreption: 'csacscsa',
        price: '\$100',
        image:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSVljXMT4gijxvpJhtvudgPbNwolG1iWskJyQ&usqp=CAU'),
    product(
        id: 3,
        title: 'green car',
        decreption: 'csacscsa',
        price: '\$300',
        image:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSVljXMT4gijxvpJhtvudgPbNwolG1iWskJyQ&usqp=CAU'),
    product(
        id: 4,
        title: 'gray car',
        decreption: 'csacscsa',
        price: '\$200',
        image:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSVljXMT4gijxvpJhtvudgPbNwolG1iWskJyQ&usqp=CAU'),
  ]; */

}
