import 'package:flutter/material.dart';

class HorizontalSplitter extends StatelessWidget {
  final double width;

  HorizontalSplitter({
    Key key,
    @required this.width
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
    );
  }
}