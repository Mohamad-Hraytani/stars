import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:screenshot/screenshot.dart';

import 'package:image_gallery_saver/image_gallery_saver.dart';

import 'Painting.dart';

class custemfav extends StatefulWidget {
  @override
  State<custemfav> createState() => _cucustemfavState();
}

class _cucustemfavState extends State<custemfav> {
  Color c = Colors.white;
  Color c1 = Colors.black;
  var coo1 = false;
  var coo2 = false;
  var coo3 = false;
  ScreenshotController screenshotController = ScreenshotController();
  final x = GlobalKey<ScaffoldState>();
  var b12 = SnackBar(
    content: Container(),
  );
  double a = 0;
  double b1 = 0;
  String va = 'Enter Text here';
  var tt = true;
  var tt1 = false;
  var tt2 = false;
  File f;
  var pic = ImagePicker();

  Future GetImagee(ImageSource type) async {
    final t = await pic.getImage(
        source: type,
        imageQuality: 100, // جودة الصورة
        maxWidth: double.infinity, //عرض الصورة
        maxHeight: double.infinity);
    setState(() {
      if (t != null) {
        f = File(t.path);
      } else
        print('object');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: x,
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Screenshot(
            controller: screenshotController,
            child: Stack(alignment: Alignment(a, b1), children: [
              tt
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              decoration: BoxDecoration(boxShadow: [
                                BoxShadow(
                                    spreadRadius: 0.5,
                                    blurRadius: 50, // نصف قطر الظل
                                    color: Colors.purple.withOpacity(0.4),
                                    offset: Offset(-10, -20)),
                              ]),
                              child: Column(
                                children: [
                                  Text('Custem Shirt'),
                                  IconButton(
                                      iconSize: 100,
                                      onPressed: () {
                                        setState(() {
                                          tt = false;
                                          tt1 = true;
                                        });
                                      },
                                      icon: Icon(Icons.format_color_fill)),
                                ],
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(boxShadow: [
                                BoxShadow(
                                    spreadRadius: 0.5,
                                    blurRadius: 50,
                                    color: Colors.purple.withOpacity(0.4),
                                    offset: Offset(10, -20)),
                              ]),
                              child: Column(
                                children: [
                                  Text('Free Drawing'),
                                  IconButton(
                                      iconSize: 100,
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            PageTransition(
                                              ctx: context,
                                              duration: Duration(seconds: 2),
                                              child: ExamplePage(),
                                              type: PageTransitionType.theme,
                                              childCurrent: custemfav(),
                                              reverseDuration:
                                                  Duration(seconds: 2),
                                            ));
                                      },
                                      icon: Icon(Icons.brush)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 50),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              decoration: BoxDecoration(boxShadow: [
                                BoxShadow(
                                    spreadRadius: 0.5,
                                    blurRadius: 50,
                                    color: Colors.purple.withOpacity(0.4),
                                    offset: Offset(-10, 20)),
                              ]),
                              child: Column(
                                children: [
                                  Text('Photo Editing'),
                                  IconButton(
                                      iconSize: 100,
                                      onPressed: () {
                                        GetImagee(ImageSource.gallery);

                                        setState(() {
                                          tt = false;
                                          tt2 = true;
                                        });
                                      },
                                      icon: Icon(Icons.image)),
                                ],
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(boxShadow: [
                                BoxShadow(
                                    spreadRadius: 0.5,
                                    blurRadius: 50,
                                    color: Colors.purple.withOpacity(0.4),
                                    offset: Offset(10, 20)),
                              ]),
                              child: Column(
                                children: [
                                  Text('Camera Photo Editing'),
                                  IconButton(
                                      iconSize: 100,
                                      onPressed: () {
                                        GetImagee(ImageSource.camera);

                                        setState(() {
                                          tt = false;
                                          tt2 = true;
                                        });
                                      },
                                      icon: Icon(Icons.camera)),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  : Container(),
              tt1
                  ? Container(
                      decoration: BoxDecoration(color: Colors.white
                          //border: Border.all(color: Colors.red, width: 10)
                          ),
                      height: MediaQuery.of(context).size.height * 0.40,
                      child: CustomPaint(
                        size: Size(double.infinity, double.infinity),
                        painter: profil1(c),
                        child: Container(
                          decoration: BoxDecoration(
                              //color: Colors.white
                              //border: Border.all(color: Colors.black, width: 5)
                              ),
                        ),
                        isComplex: false,
                        willChange: true,
                      ))
                  : Container(),
              tt2
                  ? f == null
                      ? Container()
                      : Container(
                          height: MediaQuery.of(context).size.height * 0.40,
                          child: Image.file(f),
                        )
                  : Container(),
              tt
                  ? Container()
                  : Align(
                      alignment: Alignment(a, b1),
                      child: Text(
                        va,
                        style: TextStyle(
                          color: c1,
                        ),
                      ),
                    )
            ]),
          ),
          tt
              ? Container()
              : Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        tt1 ? detils('Colors Detils') : Container(),
                        tt1
                            ? coo1
                                ? showdetils('Colors Detils')
                                : Container()
                            : Container(),
                        tt1 ? detils('More Colors Detils') : Container(),
                        tt1
                            ? coo2
                                ? showdetils('More Colors Detils')
                                : Container()
                            : Container(),
                        detils('Text Setting'),
                        coo3 ? showdetils('Text Setting') : Container(),
                        ElevatedButton(
                          child: Text(
                            'Save',
                          ),
                          onPressed: () async {
                            screenshotController
                                .capture(
                              delay: Duration(milliseconds: 10),
                            )
                                .then((capturedImage) async {
                              final result = await ImageGallerySaver.saveImage(
                                Uint8List.fromList(
                                  capturedImage,
                                ),
                                quality: 60,
                                name: '${capturedImage.hashCode}',
                              );
                              print(result);
                            }).catchError((onError) {
                              print(onError);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  Widget showdetils(String type) {
    if (type == 'Colors Detils') {
      return Container(
        //height: 500,
        width: 300,
        child: MaterialPicker(
          pickerColor: c,
          onColorChanged: (cu) {
            setState(() {
              c = cu;
            });
          },
        ),
      );
    } else if (type == 'More Colors Detils') {
      return Container(
        //height: 500,
        width: 225,
        child: ColorPicker(
          pickerColor: c,
          onColorChanged: (cu) {
            setState(() {
              c = cu;
            });
          },
        ),
      );
    } else {
      return Column(
        children: [
          TextField(
            decoration: InputDecoration(
                hintText: 'Write Text here',
                hintStyle: TextStyle(color: Colors.purple),
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.transparent), // لون الايطار تبع الفورم
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(50),
                        bottomLeft: Radius.circular(50))), // لضيع اطار للشكل
                /*  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50))), */
                /*  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50))), */
                /*    disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50))), */
                fillColor: Colors.white,
                filled: true),
            textAlign: TextAlign.center,
            onChanged: (val) {
              setState(() {
                va = val;
              });
            },
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                //  height: 300,
                width: 200,
                child: MaterialPicker(
                  pickerColor: c1,
                  onColorChanged: (cu) {
                    setState(() {
                      c1 = cu;
                    });
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 10),
                alignment: Alignment.center,
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.purple.withOpacity(0.4), Colors.white],
                      stops: [-1, 1]),
                  shape: BoxShape.circle,
                ),
                child: Stack(children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () => _Position(0, -0.1),
                          icon: Icon(Icons.arrow_upward_rounded, size: 40)),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () => _Position(-0.1, 0),
                                icon: Icon(Icons.arrow_back, size: 40)),
                            IconButton(
                                onPressed: () => _Position(0.1, 0),
                                icon: Icon(Icons.arrow_forward, size: 40))
                          ]),
                      IconButton(
                          onPressed: () => _Position(0, 0.1),
                          icon: Icon(Icons.arrow_downward, size: 40))
                    ],
                  ),
                ]),
              )
            ],
          ),
        ],
      );
    }
  }

  void showdetilsnotif(String type) {
    if (type == 'Colors Detils') {
      showModalBottomSheet(
          backgroundColor: Colors.purple.withOpacity(0.6),
          barrierColor: Colors.transparent,
          isDismissible: true,
          context: context,
          builder: (BuildContext context) {
            return Container(
              height: 325,
              width: 300,
              child: MaterialPicker(
                pickerColor: c,
                onColorChanged: (cu) {
                  setState(() {
                    c = cu;
                  });
                },
              ),
            );
          });
    } else if (type == 'More Colors Detils') {
      showModalBottomSheet(
          backgroundColor: c,
          barrierColor: Colors.transparent,
          isDismissible: true,
          context: context,
          builder: (BuildContext context) {
            return SingleChildScrollView(
              child: Container(
                // height: 300,
                width: 200,
                child: ColorPicker(
                  portraitOnly: true,
                  pickerColor: c,
                  onColorChanged: (cu) {
                    setState(() {
                      c = cu;
                    });
                  },
                ),
              ),
            );
          });
    } else {
      showModalBottomSheet(
          backgroundColor: Colors.purple.withOpacity(0.6),
          barrierColor: Colors.transparent,
          context: context,
          builder: (BuildContext context) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                        hintText: 'Write Text here',
                        hintStyle: TextStyle(color: Colors.purple),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors
                                    .transparent), // لون الايطار تبع الفورم
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(50),
                                bottomLeft:
                                    Radius.circular(50))), // لضيع اطار للشكل
                        /*  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50))), */
                        /*  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50))), */
                        /*    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50))), */
                        fillColor: Colors.white,
                        filled: true),
                    textAlign: TextAlign.center,
                    onChanged: (val) {
                      setState(() {
                        va = val;
                      });
                    },
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        //  height: 300,
                        width: 200,
                        child: MaterialPicker(
                          pickerColor: c1,
                          onColorChanged: (cu) {
                            setState(() {
                              c1 = cu;
                            });
                          },
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 10),
                        alignment: Alignment.center,
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Colors.purple.withOpacity(0.4),
                            Colors.white
                          ], stops: [
                            -1,
                            1
                          ]),
                          shape: BoxShape.circle,
                        ),
                        child: Stack(children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                  onPressed: () => _Position(0, -0.1),
                                  icon: Icon(Icons.arrow_upward_rounded,
                                      size: 40)),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    IconButton(
                                        onPressed: () => _Position(-0.1, 0),
                                        icon: Icon(Icons.arrow_back, size: 40)),
                                    IconButton(
                                        onPressed: () => _Position(0.1, 0),
                                        icon:
                                            Icon(Icons.arrow_forward, size: 40))
                                  ]),
                              IconButton(
                                  onPressed: () => _Position(0, 0.1),
                                  icon: Icon(Icons.arrow_downward, size: 40))
                            ],
                          ),
                        ]),
                      )
                    ],
                  ),
                ],
              ),
            );
          });
    }
  }

  Widget detils(String title) {
    return ListTile(
      title: Text(title),
      leading: IconButton(
        icon: bb(title),
        onPressed: () {
          setState(() {
            if (title == 'Colors Detils') {
              coo1 = !coo1;
            } else if (title == 'More Colors Detils') {
              coo2 = !coo2;
            } else {
              coo3 = !coo3;
            }
          });
        },
      ),
      trailing: IconButton(
        iconSize: 40,
        alignment: Alignment.center,
        onPressed: () {
          if (title == 'Colors Detils') {
            showdetilsnotif('Colors Detils');
          } else if (title == 'More Colors Detils') {
            showdetilsnotif('More Colors Detils');
          } else {
            showdetilsnotif('Text Color');
          }
        },
        icon: GradientIcon(
          Icons.color_lens,
          40.0,
          LinearGradient(
            colors: <Color>[
              Colors.red,
              Colors.yellow,
              Colors.blue,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
    );
  }

  Widget bb(String title) {
    Icon b;
    if (title == 'Colors Detils') {
      if (coo1 == true)
        b = Icon(Icons.arrow_upward);
      else
        b = Icon(Icons.arrow_downward_outlined);
    } else if (title == 'More Colors Detils') {
      if (coo2 == true)
        b = Icon(Icons.arrow_upward);
      else
        b = Icon(Icons.arrow_downward_outlined);
    } else {
      if (coo3 == true)
        b = Icon(Icons.arrow_upward);
      else
        b = Icon(Icons.arrow_downward_outlined);
    }
    return b;
  }

  void _Position(double a1, double b12) {
    setState(() {
      a = a + a1;
      b1 = b1 + b12;
    });
  }
}

class profil1 extends CustomPainter {
  Color c;

  profil1(this.c);

  @override
  void paint(Canvas canvas, Size size) {
    print(c.toString());

    Rect rect = Rect.fromLTWH(0, 0, 0, 0);

    Gradient gradient = LinearGradient(
      colors: [c, c],
      stops: [0.5, 0.6],
    );
    Paint paint = Paint();
    paint.shader = gradient.createShader(rect);

    Path path = Path();

    //paint.color = c;

    path.lineTo(size.width * 0.35, size.height * 0.35);

    path.lineTo(size.width * 0.25, size.height * 0.38);
    path.lineTo(size.width * 0.25, size.height * 0.25);

    path.lineTo(size.width * 0.35, size.height * 0.15);
    //path.lineTo(size.width * 0.25, size.height * 0.25);

    path.lineTo(size.width * 0.35, size.height * 0.75);
    path.lineTo(size.width * 0.65, size.height * 0.75);

    path.lineTo(size.width * 0.65, size.height * 0.35);
    path.lineTo(size.width * 0.75, size.height * 0.38);
    path.lineTo(size.width * 0.75, size.height * 0.25);

    path.lineTo(size.width * 0.65, size.height * 0.15);
    path.lineTo(size.width * 0.58, size.height * 0.15);

    path.quadraticBezierTo(size.width * 0.50, size.height * 0.25,
        size.width * 0.43, size.height * 0.15);

    path.lineTo(size.width * 0.43, size.height * 0.15);
    path.lineTo(size.width * 0.35, size.height * 0.15);
    // ترتيب النقط حسب النقطة يلي وصلتلا من النقطة السباقة وميزتا هل تابع انو بعمل امالة ما برسم سيوي
    path.lineTo(size.width * 0.35, size.height * 0.35);

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class GradientIcon extends StatelessWidget {
  GradientIcon(
    this.icon,
    this.size,
    this.gradient,
  );

  final IconData icon;
  final double size;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      child: SizedBox(
        width: size * 1.9,
        height: size,
        child: Icon(
          icon,
          size: size,
          color: Colors.white,
        ),
      ),
      shaderCallback: (Rect bounds) {
        final Rect rect = Rect.fromLTRB(0, size, size, 0);
        return gradient.createShader(rect);
      },
    );
  }
}
