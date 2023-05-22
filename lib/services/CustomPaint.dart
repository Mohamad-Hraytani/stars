

import 'package:flutter/material.dart';

class Painter extends CustomPainter {
  Color c;

  Painter(this.c);

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

    path.lineTo(size.width * 0.35, size.height * 0.35);

    path.lineTo(size.width * 0.25, size.height * 0.38);
    path.lineTo(size.width * 0.25, size.height * 0.25);

    path.lineTo(size.width * 0.35, size.height * 0.15);

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
    path.lineTo(size.width * 0.35, size.height * 0.35);

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}