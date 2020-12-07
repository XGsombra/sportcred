import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sportcred/sc_widget/flat_icon_button.dart';
import 'package:sportcred/util/util.dart';

class LikeButton extends StatefulWidget {
  final int id;
  final Future<int> Function(int id) update;
  final Future<bool> Function(bool checked) onPressed;
  final Future<bool> Function() getStatus;
  final StreamController<int> updateController;

  LikeButton({
    Key key,
    @required this.id,
    @required this.update,
    @required this.onPressed,
    @required this.getStatus,
    this.updateController
  }) : super(key: key);

  @override
  LikeButtonState createState() => LikeButtonState();
}

class LikeButtonState extends State<LikeButton> {
  bool checked = false;
  int value = 0;

  LikeButtonState();

  void reRenderCount() {
    widget.update(widget.id).then((ele) {
      setState(() {
        value = ele;
      });
    });
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void reRenderCheckedState() {
    widget.getStatus().then((value) {
      setState(() {
        checked = value;
      });
    });
  }

  void reRender() {
    reRenderCheckedState();
    reRenderCount();
  }


  @override
  void initState() {
    reRender();
    if (widget.updateController != null) {
      widget.updateController.stream.listen((event) {
        reRender();
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FlatIconButton(
      icon: Icon(Icons.thumb_up, color: checked ? Colors.red : Colors.grey),
      text: Text(
        numberToCompactString(value),
        style: TextStyle(
          color: Colors.blueGrey,
          fontFamily: 'AmazonEmber',
          fontWeight: FontWeight.w600,
        ),
        textAlign: TextAlign.left,
      ),
      onPressed: () async {
        await widget.onPressed(checked);
        reRender();
      },
      width: 130
    );
  }
}
