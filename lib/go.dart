import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:page_view_indicator/page_view_indicator.dart';

class go extends StatefulWidget {
  @override
  _goState createState() => _goState();
}

class _goState extends State<go> {
  List<String> image = [
    'lib/img/main.png',
    'lib/img/one.png',
    'lib/img/tow.png',
  ];
  List<String> text1 = ['اجهزة', 'اجهزة', 'اجهزة', 'اجهزة'];
  List<String> text2 = ['30%', '30%', '30%', '30%'];
  ScrollController co = new ScrollController();
  int a = 0;
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
        body: Stack(children: [
          ListView(
            controller: co,
            children: [
              Form(
                  child: Stack(
                children: [
                  TextFormField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  )
                ],
              )),
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
                                )
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
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: 175,
                        width: 150,
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
                      ),
                      Container(
                        height: 175,
                        width: 150,
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
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: 200,
                        width: 150,
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
                      ),
                      Container(
                        height: 200,
                        width: 150,
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
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
          a == 0
              ? Transform.translate(
                  offset: Offset(-150, 475),
                  child: FloatingActionButton(
                    onPressed: () {},
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
                              onPressed: () {},
                              icon: Icon(
                                Icons.shopping_cart_rounded,
                                size: 20,
                              )),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.book,
                                size: 20,
                              )),
                          Align(
                              alignment: Alignment.topCenter,
                              child: Text(
                                'الرئيسية',
                              )),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.favorite,
                                size: 20,
                              )),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.person,
                                size: 20,
                              )),
                        ],
                      ),
                    ),
                  ))
              : Container(),
        ]));
  }
}
