import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sportcred/post/comment_page.dart';
import 'package:sportcred/profile/profile.dart';
import 'package:sportcred/sc_widget/clickable_id_label.dart';
import 'package:sportcred/sc_widget/clickable_round_avatar.dart';
import 'package:sportcred/sc_widget/horizontal_splitter.dart';
import 'package:sportcred/sign_in/auth.dart';
import 'package:sportcred/util/util.dart';

class CommentInfo {
  final int cid;
  final int pid;
  final int commenter;
  final String content;
  int likeCount;
  final int time;

  CommentInfo({
    @required this.cid,
    @required this.pid,
    @required this.commenter,
    @required this.content,
    @required this.likeCount,
    @required this.time
  });
}

class CommentBody extends StatefulWidget {
  final StreamController streamController;
  final CommentInfo commentInfo;

  CommentBody({
    Key key,
    @required this.streamController,
    @required this.commentInfo
  }) : super(key: key);

  @override
  _CommentBodyState createState() => _CommentBodyState();
}

class _CommentBodyState extends State<CommentBody> {
  bool isShow = false;

  double getWidth() {
    return isShow ? 170 : 0;
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    widget.streamController.stream.listen((event) {
      if (event != widget.key) {
        setState(() {
          isShow = false;
        });
      }
    });

    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClickableRoundAvatar(
                userId: widget.commentInfo.commenter,
                onPressed: (int uid) => navi(
                  context,
                  ProfilePage(self: widget.commentInfo.commenter == Auth.instance.userId, userId: widget.commentInfo.commenter)
                ),
                size: 36
              ),
              Flexible(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClickableIdLabel(
                            userId: widget.commentInfo.commenter,
                            onPressed: (int id) { navi(context, ProfilePage(self: widget.commentInfo.commenter == Auth.instance.userId, userId: widget.commentInfo.commenter)); },
                            style: TextStyle(
                              fontSize: 17,
                              fontFamily: 'AmazonEmber'
                            )
                          ),
                          Divider(),
                          Text(
                            widget.commentInfo.content,
                            style: TextStyle(fontSize: 15, fontFamily: 'AmazonEmber')
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              AnimatedContainer(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  color: Color(0xff4c5154),
                                ),
                                width: getWidth(),
                                height: 36,
                                duration: Duration(milliseconds: 150),
                                child: Flex(
                                  direction: Axis.horizontal,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: InkWell(
                                        onTap: () {},
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.favorite_border, color: Colors.white, size: 17),
                                            HorizontalSplitter(width: 4),
                                            Text("Like", style: TextStyle(
                                              fontFamily: 'AmazonEmber',
                                              fontSize: 14,
                                              color: Colors.white,
                                            )),
                                          ]
                                        )
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            isShow = false;
                                            widget.streamController.add(null);
                                          });
                                          print(widget.commentInfo);
                                          navi(context, CommentPage(commentInfo: widget.commentInfo));
                                        },
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.chat_bubble_outline, color: Colors.white, size: 17),
                                            HorizontalSplitter(width: 4),
                                            Text("Reply", style: TextStyle(
                                                fontFamily: 'AmazonEmber',
                                                fontSize: 14,
                                                color: Colors.white,
                                              )),
                                          ]
                                        )
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              HorizontalSplitter(width: 5),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    isShow = !isShow;
                                    widget.streamController.add(isShow ? widget.key : null);
                                  });
                                },
                                splashColor: Colors.grey.withOpacity(0.2),
                                child: Image.asset('assets/button.png', width: 40, height: 20),
                              )
                            ],
                          )
                        ]
                    ),
                  )
              )
            ],
          ),
        )
    );
  }
}