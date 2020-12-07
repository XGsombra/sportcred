import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sportcred/sc_widget/action_alert.dart';

class PictureGridCard extends StatefulWidget {
  final File image;
  final void Function(Widget widget) remove;
  final void Function(Widget widget, bool inc) update;

  PictureGridCard({
    Key key,
    @required this.image,
    @required this.remove,
    @required this.update,
  }) : super(key: key);

  @override
  _PictureGridCardState createState() => _PictureGridCardState();
}

class _PictureGridCardState extends State<PictureGridCard> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        return showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: Text(''),
            )
        );
      },
      onDoubleTap: () async {
        if (await showActionAlertDialog('Do you want to delete this picture', context))
          widget.remove(widget);
        print('Crash');
        print(selected);
      },
      onLongPress: () {
        setState(() {
          selected = !selected;
          widget.update(widget, selected);
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          image: DecorationImage(
            image: FileImage(widget.image),
            fit: BoxFit.cover
          ),
          border: selected ? Border.all(width: 3, color: Colors.deepPurple) : null
        ),
      ),
    );
  }
}