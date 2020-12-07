import 'package:flutter/material.dart';
import 'package:sportcred/sc_widget/flat_icon_button.dart';
import 'package:sportcred/util/util.dart';

class ReplyButton extends StatefulWidget {
  final String id;
  final int Function(String id) update;
  final bool Function(String id) onPressed;

  ReplyButton({
    Key key,
    @required this.id,
    @required this.update,
    @required this.onPressed,
  }) : super(key: key);

  @override
  ReplyButtonState createState() => ReplyButtonState(value: this.update(this.id));
}

class ReplyButtonState extends State<ReplyButton> {
  bool checked = false;
  int value = 0;

  ReplyButtonState({@required this.value});

  @override
  Widget build(BuildContext context) {
    return FlatIconButton(
        icon: Icon(Icons.chat_bubble_outline_outlined, color: checked ? Colors.red : Colors.grey),
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
        width: 130
    );
  }
}
