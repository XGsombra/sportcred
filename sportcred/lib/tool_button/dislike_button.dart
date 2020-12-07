import 'package:flutter/material.dart';
import 'package:sportcred/sc_widget/flat_icon_button.dart';
import 'package:sportcred/util/util.dart';

class DislikeButton extends StatefulWidget {
  final String id;
  final int Function(String id) update;
  final bool Function(String id) onPressed;

  DislikeButton({
    Key key,
    @required this.id,
    @required this.update,
    @required this.onPressed,
  }) : super(key: key);

  @override
  DislikeButtonState createState() => DislikeButtonState(value: this.update(this.id));
}

class DislikeButtonState extends State<DislikeButton> {
  bool checked = false;
  int value = 0;

  DislikeButtonState({@required this.value});

  @override
  Widget build(BuildContext context) {
    return FlatIconButton(
        icon: Icon(Icons.thumb_down, color: checked ? Colors.red : Colors.grey),
        text: Text(
          numberToCompactString(value),
          style: TextStyle(
            color: Colors.blueGrey,
            fontFamily: 'AmazonEmber',
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.left,
        ),
        onPressed: () {
          if (this.widget.onPressed(this.widget.id)) {
            setState(() {
              checked = !checked;
              value = this.widget.update(this.widget.id);
            });
          }
        },
        width: 105
    );
  }
}
