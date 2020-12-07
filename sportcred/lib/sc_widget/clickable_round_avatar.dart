import 'package:flutter/material.dart';
import 'package:sportcred/cache/cache.dart';
import 'package:sportcred/network/profile_friend_rest_driver.dart';
import 'package:sportcred/util/util.dart';

class ClickableRoundAvatar extends StatefulWidget {
  final int userId;
  final void Function(int id) onPressed;
  final double size;

  ClickableRoundAvatar({
    Key key,
    @required this.userId,
    @required this.onPressed,
    @required this.size
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ClickableRoundAvatarState();
}

class _ClickableRoundAvatarState extends State<ClickableRoundAvatar> {
  String avatarUri = '';

  @override
  void initState() {
    super.initState();
    if (AvatarCache.instance.hasAvatar(widget.userId)) {
      avatarUri = AvatarCache.instance.getAvatar(widget.userId);
    } else {
      ProfileRestDriver.instance.getProfile(widget.userId).then((value) {
        AvatarCache.instance.setAvatar(widget.userId, value.avatarUrl);
        setState(() {
          avatarUri = value.avatarUrl;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onPressed(widget.userId),
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: NetworkImage(getImageEndpoint(avatarUri)),
            fit: BoxFit.fill
          )
        ),
      ),
    );
  }
}