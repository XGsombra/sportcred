import 'package:flutter/material.dart';

class BottomToolArea extends StatelessWidget {
  final List<Widget> children;

  BottomToolArea({
    Key key,
    @required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: children,
    );
  }
}