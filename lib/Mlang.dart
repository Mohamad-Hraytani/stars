import 'package:flutter/material.dart';
import 'package:stars/main.dart';
import 'package:stars/sh.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class Mlang extends StatefulWidget {
  sh sh1 = sh();
  Mlang(this.sh1);
  @override
  _MlangState createState() => _MlangState(sh1);
}

class _MlangState extends State<Mlang> with SingleTickerProviderStateMixin {
  sh sh1 = sh();
  _MlangState(this.sh1);
  bool o = false;
  TabController ta;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ta = TabController(length: 4, vsync: this, initialIndex: 0);
    Future.delayed(Duration(milliseconds: 5000), () {
      setState(() {
        o = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('mmh'),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.ac_unit),
          onPressed: () {},
        ),
        body: Stack(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomPaint(
                  size: Size(double.infinity, double.infinity),
                  painter: profil()),
              TabBar(controller: ta, tabs: <Widget>[
                Tab(child: Text('1')),
                Tab(child: Text('1')),
                Tab(child: Text('1')),
                Tab(child: Text('1')),
              ]),
              Flexible(
                child: TabBarView(controller: ta, children: [
                  Container(
                      color: Colors.orangeAccent,
                      padding: EdgeInsets.all(24),
                      child: GridView.count(
                        crossAxisCount: 3,
                        children: List.generate(
                            15,
                            (index) => Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: ExactAssetImage(
                                            'assets/images (1).jpg')),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    )))).toList(),
                      )),
                  Container(
                      padding: EdgeInsets.all(24),
                      child: GridView.count(
                        crossAxisCount: 3,
                        children: List.generate(
                            15,
                            (index) => Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: ExactAssetImage(
                                            'assets/images (1).jpg')),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    )))).toList(),
                      )),
                  Container(
                      padding: EdgeInsets.all(24),
                      child: GridView.count(
                        crossAxisCount: 3,
                        children: List.generate(
                            15,
                            (index) => Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: ExactAssetImage(
                                            'assets/images (1).jpg')),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    )))).toList(),
                      )),
                  Container(
                      padding: EdgeInsets.all(24),
                      child: GridView.count(
                        crossAxisCount: 3,
                        children: List.generate(
                            15,
                            (index) => Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: ExactAssetImage(
                                            'assets/images (1).jpg')),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    )))).toList(),
                      ))
                ]),
              )
            ],
          )

          /*  AnimatedPositioned(
              duration: Duration(milliseconds: 5000),
              right: o
                  ? MediaQuery.of(context).size.width * 0.5
                  : MediaQuery.of(context).size.width * 0.6,
              top: o
                  ? MediaQuery.of(context).size.height * 0.5
                  : MediaQuery.of(context).size.height * 0.6,
              child: CircleAvatar(
                minRadius: 40,
                backgroundImage: ExactAssetImage('assets/images (1).jpg'),
              )), */
        ]));
  }

  langh() {
    return Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              sh1.enarlan('en', 'ar'),
            ),
            RaisedButton(onPressed: () {
              setState(() {
                if (sh1.enar == 0)
                  sh1.enar = 1;
                else
                  sh1.enar = 0;
              });

              //  Navigator.of(context).pop();
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (BuildContext context) => MyApp1(sh1)));
            }),
          ],
        ),
      ),
    );
  }

  List<Widget> bb() {
    return [
      Text('aa'),
      SizedBox(
        height: 20,
      ),
      Text('bb'),
      SizedBox(
        height: 20,
      ),
      Text('mm'),
      SizedBox(
        height: 20,
      ),
      Text('kk'),
      SizedBox(
        height: 20,
      ),
    ];
  }
}

class MyApp1 extends StatelessWidget {
  sh sh1 = sh();
  MyApp1(this.sh1);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),

      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', ''),
        Locale('ar', ''),
      ],
      // locale: Locale('en', ''),
      locale: sh1.enar == 0 ? Locale('en', '') : Locale('ar', ''),

      localeResolutionCallback: (currentLocale, supportedLocales) {
        if (currentLocale != null) {
          for (Locale locale in supportedLocales) {
            if (currentLocale.languageCode == locale.languageCode) {
              return currentLocale;
            }
          }
        }

        return supportedLocales.first;
      },

      home: Mlang(sh1),
    );
  }
}

class profil extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Rect rect = Rect.fromLTWH(0, 0, 0, 0);
    Gradient gradient =
        LinearGradient(colors: [Colors.red, Colors.green], stops: [0.5, 0.6]);
    Paint paint = Paint();
    paint.shader = gradient.createShader(rect);

    Path path = Path();

    paint.color = Colors.red;
    path.lineTo(0, size.height * 0.25);
    path.lineTo(size.width, size.height * 0.45);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, size.height * 0.25);
    path.quadraticBezierTo(0110, 0120, 0210,
        0220); // ترتيب النقط حسب النقطة يلي وصلتلا من النقطة السباقة وميزتا هل تابع انو بعمل امالة ما برسم سيوي

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
