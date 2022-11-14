import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'package:page_view_indicator/page_view_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class ExplanPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new ExplanPageState();
  }
}

class ExplanPageState extends State<ExplanPage>
    with SingleTickerProviderStateMixin {
  int v = 0;
  int g = 0;
  String s;

  bool b2 = false;
  int b1 = 0;

  void ontv(int va) {
    setState(() {
      {
        b1 = va;
      }
    });
  }

  void ontv2(bool va) {
    setState(() {
      {
        b2 = va;
      }
    });
  }

  ValueNotifier<int> no = new ValueNotifier(0);
  Widget pagee(int length) {
    return PageViewIndicator(
      pageIndexNotifier: no,
      length: length,
      normalBuilder: (animationController, index) => Circle(
        size: 8.0,
        color: Colors.white,
      ),
      highlightedBuilder: (animationController, index) => ScaleTransition(
        scale: CurvedAnimation(
          parent: animationController,
          curve: Curves.ease,
        ),
        child: Circle(size: 12.0, color: Colors.purple.withOpacity(0.4)),
      ),
    );
  }

  List<String> image = [
    'lib/img/0.png',
    'lib/img/1.png',
    'lib/img/2.png',
    'lib/img/3.png',
    'lib/img/4.png',
    'lib/img/5.png',
    'lib/img/6.png',
    'lib/img/7.png',
    'lib/img/8.png'
  ];

  TabController tcpage;
  @override
  void initState() {
    super.initState();
    tcpage = new TabController(length: 9, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        PageView.builder(
          itemBuilder: (context, index) {
            return new Stack(children: <Widget>[
              Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: ExactAssetImage(
                            image[index],
                          ),
                          fit: BoxFit.cover))),
            ]);
          },
          itemCount: image.length,
          onPageChanged: (index) async {
            setState(() {
              //   v = index;
              no.value = index;
            });
            print(index);
            if (index == image.length - 1) {
              SharedPreferences pr1 = await SharedPreferences.getInstance();
              pr1.setBool('se', true);
              setState(() {
                g = 1;
              });
            }
          },
        ),
        g == 1
            ? Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: 10,
                    left: 250,
                  ),
                  child: SizedBox(
                    height: 75,
                    width: 200,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        gradient: LinearGradient(colors: [
                          Colors.white,
                          Colors.purple.withOpacity(0.4)
                        ]),
                      ),
                      child: FlatButton(
                          //   elevation: 30,
                          onPressed: () => {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                      ctx: context,
                                      duration: Duration(seconds: 2),
                                      child: MyApp(),
                                      type: PageTransitionType.theme,
                                      childCurrent: ExplanPage(),
                                      reverseDuration: Duration(seconds: 2),
                                    ))
                              },
                          child: Text(
                            "Start",
                            style: TextStyle(
                              fontSize: 30,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          )),
                    ),
                  ),
                ),
              )
            : Container(),
        Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 100),
              child: pagee(image.length),
            )),
      ],
    ));
  }
}
