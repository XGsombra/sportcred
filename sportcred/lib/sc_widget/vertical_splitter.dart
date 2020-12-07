import 'package:flutter/material.dart';

class VerticalSplitter extends StatelessWidget {
  final double height;

  VerticalSplitter({
    Key key,
    @required this.height
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
    );
  }
}
