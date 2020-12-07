import 'package:flutter/material.dart';

class MyPainter extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    Paint _paint = Paint()
      ..strokeWidth = 4;
    for (double i = 0; i < 8; i++) {
      canvas.drawLine(Offset(21 + i * 53, 0), Offset(21 + i * 53, 20), _paint);
      if (i % 2 == 0) {
        canvas.drawLine(Offset(19 + i * 53, 20), Offset(23 + (i + 1) * 53, 20), _paint);
        canvas.drawLine(Offset(47.5 + i * 53, 20), Offset(47.5 + i * 53, 40), _paint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return null;
  }
}

class MyPainter2 extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    Paint _paint = Paint()
      ..strokeWidth = 4;
    for (double i = 0; i < 8; i++) {
      if (i % 2 == 0) {
        canvas.drawLine(Offset(47.5 + i * 53, 0), Offset(47.5 + i * 53, 20), _paint);
      }
      if (i % 4 == 0) {
        canvas.drawLine(Offset(45.5 + i * 53, 20), Offset(49.5 + (i + 2) * 53, 20), _paint);
        canvas.drawLine(Offset(47.5 + (i + 1) * 53, 20), Offset(47.5 + (i + 1) * 53, 40), _paint);
      }
    }
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return null;
  }
}

class MyPainter3 extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    Paint _paint = Paint()
      ..strokeWidth = 4;
    canvas.drawLine(Offset(100.5, 0), Offset(100.5, 20), _paint);
    canvas.drawLine(Offset(312.5, 0), Offset(312.5, 20), _paint);
    canvas.drawLine(Offset(98.5, 20), Offset(314.5, 20), _paint);
    canvas.drawLine(Offset(206.5, 20), Offset(206.5, 40), _paint);
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return null;
  }
}

class MyPainter4 extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    Paint _paint = Paint()
      ..strokeWidth = 4;
    canvas.drawLine(Offset(206.5, 0), Offset(206.5, 20), _paint);
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return null;
  }
}

class MyPainter5 extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    Paint _paint = Paint()
      ..strokeWidth = 4;
    canvas.drawLine(Offset(100.5, 20), Offset(100.5, 40), _paint);
    canvas.drawLine(Offset(312.5, 20), Offset(312.5, 40), _paint);
    canvas.drawLine(Offset(98.5, 20), Offset(314.5, 20), _paint);
    canvas.drawLine(Offset(206.5, 0), Offset(206.5, 20), _paint);
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return null;
  }
}

class MyPainter6 extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    Paint _paint = Paint()
      ..strokeWidth = 4;
    for (double i = 0; i < 8; i++) {
      if (i % 2 == 0) {
        canvas.drawLine(Offset(47.5 + i * 53, 20), Offset(47.5 + i * 53, 40), _paint);
      }
      if (i % 4 == 0) {
        canvas.drawLine(Offset(45.5 + i * 53, 20), Offset(49.5 + (i + 2) * 53, 20), _paint);
        canvas.drawLine(Offset(47.5 + (i + 1) * 53, 0), Offset(47.5 + (i + 1) * 53, 20), _paint);
      }
    }
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return null;
  }
}

class MyPainter7 extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    Paint _paint = Paint()
      ..strokeWidth = 4;
    for (double i = 0; i < 8; i++) {
      canvas.drawLine(Offset(21 + i * 53, 20), Offset(21 + i * 53, 40), _paint);
      if (i % 2 == 0) {
        canvas.drawLine(Offset(19 + i * 53, 20), Offset(23 + (i + 1) * 53, 20), _paint);
        canvas.drawLine(Offset(47.5 + i * 53, 0), Offset(47.5 + i * 53, 20), _paint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return null;
  }
}