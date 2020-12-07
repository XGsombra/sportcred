import 'package:flutter/material.dart';

class FlatIconButton extends StatelessWidget {
  final Icon icon;
  final Text text;
  final Color backgroundColor;
  final void Function() onPressed;
  final double width;
  final double height;

  FlatIconButton({
    @required this.icon,
    @required this.text,
    @required this.onPressed,
    @required this.width,
    this.height = 40,
    this.backgroundColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: FlatButton(
        color: backgroundColor,
        onPressed: onPressed,
        child: Flex(
          direction: Axis.horizontal,
          children: [
            Expanded(
              flex: 1,
              child: Center(child: icon)
            ),
            Expanded(
              flex: 1,
              child: text,
            )
          ]
        )
      )
    );
  }
}
