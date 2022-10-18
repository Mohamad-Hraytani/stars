import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:painter/painter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class ExamplePage extends StatefulWidget {
  @override
  _ExamplePageState createState() => new _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  bool _finished = false;
  PainterController _controller = _newController();

  @override
  void initState() {
    super.initState();
  }

  ScreenshotController screenshotController = ScreenshotController();
  static PainterController _newController() {
    PainterController controller = new PainterController();
    controller.thickness = 5.0;
    controller.backgroundColor = Colors.white;
    return controller;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> actions;
    if (_finished) {
      actions = <Widget>[
        new IconButton(
            icon: new Icon(Icons.content_copy),
            tooltip: 'New Painting',
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

              setState(() {
                _finished = false;
                _controller = _newController();
              });
            }),
      ];
    } else {
      actions = <Widget>[
        new IconButton(
            icon: new Icon(
              Icons.undo,
            ),
            tooltip: 'Undo',
            onPressed: () {
              if (_controller.isEmpty) {
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) =>
                        new Text('Nothing to undo'));
              } else {
                _controller.undo();
              }
            }),
        new IconButton(
            icon: new Icon(Icons.delete),
            tooltip: 'Clear',
            onPressed: () => _controller.clear),
        new IconButton(
            icon: new Icon(Icons.check),
            onPressed: () => _show(_controller.finish(), context)),
      ];
    }
    return new Scaffold(
      appBar: new AppBar(
          backgroundColor: Colors.purple.withOpacity(0.4),
          title: const Text('Painter Example'),
          actions: actions,
          bottom: new PreferredSize(
            child: new DrawBar(_controller),
            preferredSize: new Size(MediaQuery.of(context).size.width, 30.0),
          )),
      body: Screenshot(
        controller: screenshotController,
        child: new Center(
            child: new AspectRatio(
                aspectRatio: 1.0, child: new Painter(_controller))),
      ),
    );
  }

  void _show(PictureDetails picture, BuildContext context) {
    setState(() {
      _finished = true;
    });
    /* Navigator.of(context)
        .push(new MaterialPageRoute(builder: (BuildContext context) {
      return new Scaffold(
        appBar: new AppBar(

          title: const Text('View your image'),
        ),
        body: new Container(
            alignment: Alignment.center,
            child: new FutureBuilder<Uint8List>(
              future: picture.toPNG(),
              builder:
                  (BuildContext context, AsyncSnapshot<Uint8List> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.done:
                    if (snapshot.hasError) {
                      return new Text('Error: ${snapshot.error}');
                    } else {
                      return Image.memory(snapshot.data);
                    }
                    break;
                  default:
                    return new Container(
                        child: new FractionallySizedBox(
                      widthFactor: 0.1,
                      child: new AspectRatio(
                          aspectRatio: 1.0,
                          child: new CircularProgressIndicator()),
                      alignment: Alignment.center,
                    ));
                }
              },
            )),
      );
    } ));*/
  }
}

class DrawBar extends StatelessWidget {
  final PainterController _controller;

  DrawBar(this._controller);

  @override
  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Flexible(child: new StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return new Container(
              child: new Slider(
            value: _controller.thickness,
            onChanged: (double value) => setState(() {
              _controller.thickness = value;
            }),
            min: 1.0,
            max: 20.0,
            activeColor: Colors.white,
            inactiveColor: Colors.grey,
          ));
        })),
        new StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return new RotatedBox(
              quarterTurns: _controller.eraseMode ? 2 : 0,
              child: IconButton(
                  icon: new Icon(Icons.create),
                  tooltip: (_controller.eraseMode ? 'Disable' : 'Enable') +
                      ' eraser',
                  onPressed: () {
                    setState(() {
                      _controller.eraseMode = !_controller.eraseMode;
                    });
                  }));
        }),
        new ColorPickerButton(_controller, false),
        new ColorPickerButton(_controller, true),
      ],
    );
  }
}

class ColorPickerButton extends StatefulWidget {
  final PainterController _controller;
  final bool _background;

  ColorPickerButton(this._controller, this._background);

  @override
  _ColorPickerButtonState createState() => new _ColorPickerButtonState();
}

class _ColorPickerButtonState extends State<ColorPickerButton> {
  @override
  Widget build(BuildContext context) {
    return new IconButton(
        icon: new Icon(_iconData, color: _color),
        tooltip: widget._background
            ? 'Change background color'
            : 'Change draw color',
        onPressed: _pickColor);
  }

  void _pickColor() {
    Color pickerColor = _color;
    Navigator.of(context)
        .push(new MaterialPageRoute(
            fullscreenDialog: true,
            builder: (BuildContext context) {
              return new Scaffold(
                  appBar: new AppBar(
                    title: const Text('Pick color'),
                  ),
                  body: new Container(
                      alignment: Alignment.center,
                      child: new ColorPicker(
                        pickerColor: pickerColor,
                        onColorChanged: (Color c) => pickerColor = c,
                      )));
            }))
        .then((_) {
      setState(() {
        _color = pickerColor;
      });
    });
  }

  Color get _color => widget._background
      ? widget._controller.backgroundColor
      : widget._controller.drawColor;

  IconData get _iconData =>
      widget._background ? Icons.format_color_fill : Icons.brush;

  set _color(Color color) {
    if (widget._background) {
      widget._controller.backgroundColor = color;
    } else {
      widget._controller.drawColor = color;
    }
  }
}

class profil2 extends CustomPainter {
  Color c;

  profil2(this.c);

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

    path.lineTo(size.width * 0.30, size.height * 0.35);

    path.lineTo(size.width * 0.20, size.height * 0.38);
    path.lineTo(size.width * 0.20, size.height * 0.25);

    path.lineTo(size.width * 0.30, size.height * 0.15);
    //path.lineTo(size.width * 0.25, size.height * 0.25);

    path.lineTo(size.width * 0.30, size.height * 0.75);
    path.lineTo(size.width * 0.70, size.height * 0.75);

    path.lineTo(size.width * 0.70, size.height * 0.35);
    path.lineTo(size.width * 0.80, size.height * 0.38);
    path.lineTo(size.width * 0.80, size.height * 0.25);

    path.lineTo(size.width * 0.70, size.height * 0.15);
    path.lineTo(size.width * 0.60, size.height * 0.15);

    path.quadraticBezierTo(size.width * 0.50, size.height * 0.25,
        size.width * 0.40, size.height * 0.15);

    path.lineTo(size.width * 0.40, size.height * 0.15);
    path.lineTo(size.width * 0.30, size.height * 0.15);
    // ترتيب النقط حسب النقطة يلي وصلتلا من النقطة السباقة وميزتا هل تابع انو بعمل امالة ما برسم سيوي
    path.lineTo(size.width * 0.30, size.height * 0.35);

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
