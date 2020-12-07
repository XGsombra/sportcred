import 'package:flutter/material.dart';
import 'package:sportcred/cache/cache.dart';
import 'package:sportcred/network/profile_friend_rest_driver.dart';

class ClickableIdLabel extends StatefulWidget {
  final int userId;
  final void Function(int id) onPressed;
  final double width;
  final double height;
  final TextStyle style;

  ClickableIdLabel({
    Key key,
    @required this.userId,
    @required this.onPressed,
    this.height,
    @required this.style,
    this.width,
  }) : super(key: key);
  @override
  _ClickableIdLabelState createState() => _ClickableIdLabelState();
}

class _ClickableIdLabelState extends State<ClickableIdLabel> {
  String username = '';

  @override
  void initState() {
    super.initState();
    if (UsernameCache.instance.hasUsername(widget.userId)) {
      username = UsernameCache.instance.getUsername(widget.userId);
    } else {
      ProfileRestDriver.instance.getProfile(widget.userId).then((value) {
        UsernameCache.instance.setUsername(widget.userId, value.username);
        setState(() {
          username = value.username;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onPressed(widget.userId),
      child: Container(
        width: widget.width,
        height: widget.height,
        child: Text(
          username,
          style: widget.style,
          maxLines: 1,
        ),
      )
    );
  }
}