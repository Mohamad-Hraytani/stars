import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:page_view_indicator/page_view_indicator.dart';

class go2 extends StatefulWidget {
  @override
  _go2State createState() => _go2State();
}

class _go2State extends State<go2> with SingleTickerProviderStateMixin {
  double r = 20.0;

  List<String> text1 = [
    'اجهزة',
    'اجهزة',
    'اجهزة',
    'اجهزة',
    'اجهزة',
  ];
  List<String> image = [
    'lib/img/ballon.png',
    'lib/img/ballon.png',
    'lib/img/ballon.png',
    'lib/img/ballon.png',
    'lib/img/ballon.png',
  ];
  List<Icon> text2 = [
    Icon(
      Icons.house_outlined,
      size: 20,
    ),
    Icon(
      Icons.house_outlined,
      size: 20,
    ),
    Icon(
      Icons.house_outlined,
      size: 20,
    ),
    Icon(
      Icons.house_outlined,
      size: 20,
    ),
    Icon(
      Icons.house_outlined,
      size: 20,
    ),
  ];
  List<Icon> text3 = [
    Icon(
      Icons.house_outlined,
      size: 40,
    ),
    Icon(
      Icons.house_outlined,
      size: 40,
    ),
    Icon(
      Icons.house_outlined,
      size: 40,
    ),
    Icon(
      Icons.house_outlined,
      size: 40,
    ),
    Icon(
      Icons.house_outlined,
      size: 40,
    ),
  ];
  ValueNotifier<int> no = new ValueNotifier(0);
  Widget pagee(int length) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: Container(
        height: 50,
        margin: EdgeInsets.only(top: 5, bottom: 5),
        decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(color: Colors.grey.shade500, width: 1),
            borderRadius: BorderRadius.circular(10)),
        child: PageViewIndicator(
            pageIndexNotifier: no,
            length: length,
            normalBuilder: (animationController, index) => Container(
                  height: 40,
                  width: 65,
                  //margin: EdgeInsets.only(top: 5, bottom: 5),
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(color: Colors.transparent, width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      Text(
                        text1[index],
                      ),
                      text2[index]
                    ],
                  ),
                ),
            highlightedBuilder: (animationController, index) => ScaleTransition(
                scale: CurvedAnimation(
                  parent: animationController,
                  curve: Curves.ease,
                ),
                child: Container(
                    height: 40,
                    width: 65,
                    //    margin: EdgeInsets.only(top: 5, bottom: 5),
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        border:
                            Border.all(color: Colors.grey.shade500, width: 1),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        Text(
                          text1[index],
                        ),
                        text2[index]
                      ],
                    )))),
      ),
    );
  }

  TabController tc;
  @override
  void initState() {
    super.initState();
    tc = new TabController(initialIndex: 0, length: text1.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(children: [
          Column(children: [
            Container(
              height: 50,
              margin: EdgeInsets.only(top: 30, right: 10, left: 10, bottom: 10),
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: Colors.grey.shade500, width: 1),
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.linear_scale),
                      Text(
                        'القائمة',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Container(
                    height: 40,
                    width: 125,
                    margin: EdgeInsets.only(top: 5, bottom: 5),
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        border:
                            Border.all(color: Colors.grey.shade500, width: 1),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'الصفحة الرئيسية',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          Icons.house_sharp,
                          size: 30,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'Fri 31 Dec 02:53:22',
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                  Icon(
                    Icons.watch_later_outlined,
                    size: 40,
                  ),
                ],
              ),
            ),
            //  pagee(text1.length),

            Container(
              height: 70,
              margin: EdgeInsets.only(top: 5, bottom: 5),
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: Colors.grey.shade500, width: 2),
                  borderRadius: BorderRadius.circular(15)),
              child: TabBar(
                // PreferredSize  preferredSize: new Size(200.0, 200.0),

                isScrollable: true,
                controller: tc,

                indicatorPadding:
                    EdgeInsets.only(top: 16, bottom: 18, right: 15, left: 15),
                indicator: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(
                    color: Colors.grey.shade500,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                tabs: List.generate(
                  text1.length,
                  (index) => Material(
                    //borderOnForeground: true,
                    borderRadius: BorderRadius.circular(12),
                    elevation: 10,
                    child: Container(
                      height: 30,
                      width: 70,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.transparent, width: 2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            text1[index],
                          ),
                          text2[index]
                        ],
                      ),
                    ),
                  ),
                ).toList(),
              ),
            ),
            Container(
              height: 40,
              width: 200,
              child: Form(
                child: TextFormField(
                    decoration: InputDecoration(
                  labelStyle: TextStyle(
                      fontSize: 12, decoration: TextDecoration.underline),
                  labelText: 'ابحث من هنا عن طلبك',
                  counterStyle: TextStyle(
                      fontSize: 10, decoration: TextDecoration.underline),
                  suffixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(50))), //
                )),
              ),
            ),

            Expanded(
              child: Stack(children: [
                TabBarView(controller: tc, children: [
                  GridView.count(
                    childAspectRatio: (0.55),
                    // controller: new ScrollController(keepScrollOffset: false),
                    // shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    //     primary: false,
                    //   padding: const EdgeInsets.all(20),
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 25,
                    crossAxisCount: 3,
                    children: List.generate(5, (index) {
                      return Material(
                        //borderOnForeground: true,
                        borderRadius: BorderRadius.circular(12),
                        elevation: 5,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border:
                                Border.all(color: Colors.transparent, width: 2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          //height: 400,
                          child: Column(children: [
                            SizedBox(
                              height: 5,
                            ),
                            Material(
                              //borderOnForeground: true,
                              borderRadius: BorderRadius.circular(12),
                              elevation: 2,
                              child: Container(
                                height: 95,
                                width: 90,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.transparent, width: 2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Image.asset(
                                  image[index],
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            Text(
                              'المنتج ',
                              style: TextStyle(fontSize: 15),
                            ),
                            Text(
                              'السعر',
                              style: TextStyle(fontSize: 15),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "عرض",
                                  style: TextStyle(fontSize: 15),
                                ),
                                Icon(
                                  Icons.remove_red_eye,
                                  size: 20,
                                )
                              ],
                            )
                          ]),
                        ),
                      );
                    }),
                  ),
                  GridView.count(
                    crossAxisCount: 3,
                    children: List.generate(5, (index) {
                      return Container(
                        height: 100,
                        child: Card(
                          child: Column(children: [
                            Image.asset(
                              image[index],
                              fit: BoxFit.fill,
                            ),
                            Text('المنتج '),
                            Text('السعر'),
                            Row(
                              children: [
                                Icon(Icons.remove_red_eye),
                                Text("عرض")
                              ],
                            )
                          ]),
                        ),
                      );
                    }),
                  ),
                  GridView.count(
                    crossAxisCount: 3,
                    children: List.generate(5, (index) {
                      return Container(
                        child: Card(
                          child: Column(children: [
                            Image.asset(
                              image[index],
                              fit: BoxFit.cover,
                            ),
                            Text('المنتج '),
                            Text('السعر'),
                            Row(
                              children: [
                                Icon(Icons.remove_red_eye),
                                Text("عرض")
                              ],
                            )
                          ]),
                        ),
                      );
                    }),
                  ),
                  GridView.count(
                    crossAxisCount: 3,
                    children: List.generate(5, (index) {
                      return Container(
                        child: Card(
                          child: Column(children: [
                            Image.asset(
                              image[index],
                              fit: BoxFit.cover,
                            ),
                            Text('المنتج '),
                            Text('السعر'),
                            Row(
                              children: [
                                Icon(Icons.remove_red_eye),
                                Text("عرض")
                              ],
                            )
                          ]),
                        ),
                      );
                    }),
                  ),
                  GridView.count(
                    crossAxisCount: 3,
                    children: List.generate(5, (index) {
                      return Container(
                        child: Card(
                          child: Column(children: [
                            Image.asset(
                              image[index],
                              fit: BoxFit.cover,
                            ),
                            Text('المنتج '),
                            Text('السعر'),
                            Row(
                              children: [
                                Icon(Icons.remove_red_eye),
                                Text("عرض")
                              ],
                            )
                          ]),
                        ),
                      );
                    }),
                  ),
                ]),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(),
                )
              ]),
            )
          ]),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 100,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade500, width: 2),
                  borderRadius: BorderRadius.circular(10)),
              child: TabBar(
                // PreferredSize  preferredSize: new Size(200.0, 200.0),
                indicatorColor: Colors.black,

                labelColor: Colors.black,
                unselectedLabelColor: Colors.black,
                isScrollable: true,
                controller: tc,
                labelPadding: EdgeInsets.only(right: 5, left: 5),
                //  unselectedLabelColor: Colors.white,
                indicatorPadding:
                    EdgeInsets.only(top: 5, bottom: 5, right: 5, left: 5),
                indicator: BoxDecoration(
                  backgroundBlendMode: BlendMode.darken,
                  color: Colors.black,
                  border: Border.all(
                    color: Colors.grey.shade500,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                tabs: List.generate(
                  5,
                  (index) => Material(
                    //borderOnForeground: true,
                    borderRadius: BorderRadius.circular(10),
                    //    elevation: 10,
                    child: Container(
                      height: 80,
                      width: 58,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          text3[index],
                          Text(
                            text1[index],
                          ),
                        ],
                      ),
                    ),
                  ),
                ).toList(),
              ),
            ),
          ),
        ]));
  }
}

// ignore: camel_case_types
