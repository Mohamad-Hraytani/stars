import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:page_view_indicator/page_view_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'go4.dart';

class go3 extends StatefulWidget {
  @override
  _go3State createState() => _go3State();
}

class _go3State extends State<go3> {
  List<String> image = [
    'lib/img/main.png',
    'lib/img/one.png',
    'lib/img/tow.png',
  ];
  List<String> text1 = ['اجهزة', 'اجهزة', 'اجهزة', 'اجهزة'];
  List<String> text2 = ['30%', '30%', '30%', '30%'];

  ScrollController co = new ScrollController();
  int a = 0;
  int na = 0;

  String msg;
  void initState() {
    super.initState();
    co.addListener(() {
      if (co.position.pixels == co.position.maxScrollExtent) {
        setState(() {
          a = 1;
        });
      } else
        setState(() {
          a = 0;
        });
    });
  }

  ValueNotifier<int> no = new ValueNotifier(0);
  Widget pagee(int length) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: PageViewIndicator(
        alignment: MainAxisAlignment.center,
        pageIndexNotifier: no,
        length: length,
        normalBuilder: (animationController, index) => Circle(
          size: 8.0,
          color: Colors.green.shade100,
        ),
        highlightedBuilder: (animationController, index) => ScaleTransition(
          scale: CurvedAnimation(
            parent: animationController,
            curve: Curves.ease,
          ),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.green),
            height: 8,
            width: 25,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text(
            'الصفحة الرئيسة',
            textAlign: TextAlign.center,
          ),
          centerTitle: true,
          actions: [
            Icon(Icons.search),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();

            prefs.setBool('se', true);

            /*    /*    Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => go4())); */ */
          },
        ),
        body: Stack(children: [
          ListView(controller: co, children: [
            Container(
              margin: EdgeInsets.only(top: 25, left: 5, right: 5),
              width: MediaQuery.of(context).size.width,
              height: 150,
              child: PageView.builder(
                itemBuilder: (context, index) {
                  return new Stack(children: <Widget>[
                    Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                                image: ExactAssetImage(
                                  image[index],
                                ),
                                fit: BoxFit.fill))),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          text2[index],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 50,
                              fontWeight: FontWeight.bold),
                        ))
                  ]);
                },
                itemCount: image.length,
                onPageChanged: (index) {
                  setState(() {
                    //   v = index;
                    no.value = index;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: pagee(image.length),
            ),
            Container(
              height: 30,
              width: MediaQuery.of(context).size.width,
              child: ListView(
                  // ليستاية افقية
                  scrollDirection: Axis.horizontal,
                  children: List.generate(
                      4,
                      (index) => Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                height: 30,
                                width: 100,
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text(
                                  text1[index],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ),
                            ],
                          )).toList()),
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'المنتجات الجديدة',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 400,
              width: 400,
              child: GridView(
                //    scrollDirection: Axis.vertical,

                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  mainAxisExtent: 200, //ارتفاع كل عنصر
                  maxCrossAxisExtent: 175, // عرض كل عنصر
                  // childAspectRatio: 3 / 2, // نسبة العرض للطول
                  mainAxisSpacing: 20, //البعد بين العناصر بلطول
                  crossAxisSpacing: 20, // البعد بين العناصر بالعضر
                ),
                children: List.generate(
                    3,
                    (index) => Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [Colors.yellow, Colors.white],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight)),
                          //  height: 200,
                          //  width: 200,
                          child: Card(
                            child: Stack(
                              children: [
                                Align(
                                    alignment: Alignment.center,
                                    child: Image.asset('lib/img/ballon.png')),
                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Icon(
                                      Icons.bookmark_sharp,
                                      size: 30,
                                      color: Colors.green,
                                    )),
                                Align(
                                    alignment: Alignment.topRight,
                                    child: Icon(
                                      Icons.favorite_border,
                                      color: Colors.grey,
                                    )),
                                Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Container(
                                      margin:
                                          EdgeInsets.only(left: 15, bottom: 15),
                                      height: 25,
                                      width: 25,
                                      decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Transform.translate(
                                        offset: Offset(7, -8),
                                        child: IconButton(
                                          onPressed: () {},
                                          alignment: Alignment.center,
                                          icon: Icon(
                                            Icons.add,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ))
                              ],
                            ),
                          ),
                        )).toList(),
              ),
            ),
          ]),
          a == 0
              ? Transform.translate(
                  offset: na == 0
                      ? Offset(-150, 475)
                      : na == 1
                          ? Offset(-100, 475)
                          : na == 2
                              ? Offset(-50, 475)
                              : na == 3
                                  ? Offset(-200, 475)
                                  : na == 4
                                      ? Offset(-250, 475)
                                      : Offset(-100, 500),
                  child: FloatingActionButton(
                    onPressed: () {
                      setState(() {
                        na = 0;
                      });
                    },
                    elevation: 5,
                    backgroundColor: Colors.white,
                    child: Align(
                        alignment: Alignment.topCenter,
                        child: Icon(
                          Icons.home,
                          color: Colors.green,
                          size: 32,
                        )),
                  ),
                )
              : Container(),
          a == 0
              ? Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    child: Card(
                      elevation: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  na = 1;
                                });
                              },
                              icon: Icon(
                                Icons.shopping_cart_rounded,
                                size: na == 1 ? 40 : 20,
                              )),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  na = 2;
                                });
                              },
                              icon: Icon(
                                Icons.book,
                                size: na == 2 ? 40 : 20,
                              )),
                          Align(
                              alignment: Alignment.topCenter,
                              child: Text(
                                'الرئيسية',
                              )),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  na = 3;
                                });
                              },
                              icon: Icon(
                                Icons.favorite,
                                size: na == 3 ? 40 : 20,
                              )),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  na = 4;
                                });
                              },
                              icon: Icon(
                                Icons.person,
                                size: na == 4 ? 40 : 20,
                              )),
                        ],
                      ),
                    ),
                  ))
              : Container(),
        ]));
  }
}
