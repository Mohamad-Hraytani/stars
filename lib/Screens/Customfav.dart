
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

import '../services/CustomPaint.dart';
import '../widgets/GradientIcon.dart';
import 'Painting.dart';
import 'package:permission_handler/permission_handler.dart';


class customfav extends StatefulWidget {
  @override
  State<customfav> createState() => _cucustomfavState();
}

class _cucustomfavState extends State<customfav> {
  Color c = Colors.white;
  Color c1 = Colors.black;
  
  var coo1 = false;
  var coo2 = false;
  var coo3 = false;
  
  ScreenshotController screenshotController = ScreenshotController();
  
  final key_unique = GlobalKey<ScaffoldState>();

  double x = 0;
  double y = 0;
  String title_shirt = 'Enter Text here';

  var tt = true;
  var tt1 = false;
  var tt2 = false;
  
  File file_image;
  var pic = ImagePicker();

  Future GetImagee(ImageSource type) async {
    final t = await pic.pickImage(
        source: type,
        imageQuality: 100, // جودة الصورة
        maxWidth: double.infinity, //عرض الصورة
        maxHeight: double.infinity);
    setState(() {
      if (t != null) {
        file_image = File(t.path);
      } else
        print('object');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key_unique,
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Screenshot(
            controller: screenshotController,
            child: Stack(alignment: Alignment(0, y), children: [
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
                                    blurRadius: 50,
                                    color: Colors.purple.withOpacity(0.4),
                                    offset: Offset(-10, -20)),
                              ]),
                              child: Column(
                                children: [
                                  Text('Custom Shirt'),
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
                                              child: painting(),
                                              type: PageTransitionType.theme,
                                              childCurrent: customfav(),
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
                      decoration: BoxDecoration(color: Colors.white),
                      height: MediaQuery.of(context).size.height * 0.40,
                      child: CustomPaint(
                        size: Size(double.infinity, double.infinity),
                        painter: Painter(c),
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
                  ? file_image == null
                      ? Container()
                      : Container(
                          height: MediaQuery.of(context).size.height * 0.40,
                          child: Image.file(file_image),
                        )
                  : Container(),
              tt
                  ? Container()
                  : Align(
                      alignment: Alignment(x, y),
                      child: Text(
                        title_shirt,
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
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.purple.withOpacity(0.4),
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(30),
                                  topRight: Radius.circular(30))),
                          child: TextButton(
                            child: Text(
                              'Save',
                            ),
                            onPressed: () async {




                              await screenshotController
                                  .capture(
                                delay: Duration(milliseconds: 10),
                              )
                                  .then((capturedImage) async {
//PermissionStatus permission1 = await PermissionHandler().checkPermissionStatus(PermissionGroup.storage);

 await PermissionHandler().checkPermissionStatus(PermissionGroup.storage) == PermissionStatus.denied?  await  PermissionHandler().requestPermissions([PermissionGroup.storage]):null;




                                final result =
                                    await ImageGallerySaver.saveImage(
                                  Uint8List.fromList(
                                    capturedImage,
                                  ),
                                  quality: 100,
                                  name: '${capturedImage.hashCode}',
                                );
                                print(result);
                              }).catchError((onError) {
                                print(onError);
                              });
 if(await PermissionHandler().checkPermissionStatus(PermissionGroup.storage) == PermissionStatus.denied)
                             ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("you have to give Permission to save image")));
                           
                           
                        else  ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Complet Save")));
                            },
                          ),
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
                    borderSide: BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(50),
                        bottomLeft: Radius.circular(50))),
                fillColor: Colors.white,
                filled: true),
            textAlign: TextAlign.center,
            onChanged: (val) {
              setState(() {
                title_shirt = val;
              });
            },
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
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
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(50),
                                bottomLeft: Radius.circular(50))),
                        fillColor: Colors.white,
                        filled: true),
                    textAlign: TextAlign.center,
                    onChanged: (val) {
                      setState(() {
                        title_shirt = val;
                      });
                    },
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
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
        icon: State_show_icon(title),
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

  Widget State_show_icon(String title) {
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
      x = x + a1;
      y = y + b12;
    });
  }
}




