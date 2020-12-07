import 'package:flutter/material.dart';
import 'package:sportcred/sc_widget/clickable_id_label.dart';
import 'package:sportcred/sc_widget/clickable_round_avatar.dart';
import 'package:sportcred/sc_widget/horizontal_splitter.dart';

class BlogHeader extends StatelessWidget {
  final int userId;
  final void Function(int id) onPressed;
  final TextStyle titleStyle;
  final double size;
  final double space;

  BlogHeader({
    Key key,
    @required this.userId,
    @required this.onPressed,
    @required this.titleStyle,
    @required this.size,
    @required this.space,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ClickableRoundAvatar(
          userId: userId,
          onPressed: onPressed,
          size: size
        ),
        HorizontalSplitter(width: space),
        ClickableIdLabel(
          userId: userId,
          onPressed: onPressed,
          style: titleStyle
        ),
      ],
    );
  }
}
