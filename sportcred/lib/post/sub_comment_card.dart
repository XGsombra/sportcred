import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sportcred/profile/profile.dart';
import 'package:sportcred/sc_widget/clickable_id_label.dart';
import 'package:sportcred/sc_widget/clickable_round_avatar.dart';
import 'package:sportcred/sc_widget/horizontal_splitter.dart';
import 'package:sportcred/util/util.dart';
import 'package:sportcred/sign_in/auth.dart';

class SubCommentInfo {
  final int id;
  final int commentId;
  final int userId;
  final int commentToUserId;
  final String content;
  final int createdTime;
  final int likeCount;
  final bool liked;

  SubCommentInfo({
    @required this.id,
    @required this.commentId,
    @required this.userId,
    @required this.commentToUserId,
    @required this.content,
    @required this.createdTime,
    @required this.likeCount,
    @required this.liked
  });
}

class SubCommentCard extends StatefulWidget {
  final StreamController streamController;
  final SubCommentInfo subCommentInfo;
  final FocusNode focusNode;
  final StreamController<int> replyToController;

  SubCommentCard({
    Key key,
    @required this.streamController,
    @required this.subCommentInfo,
    @required this.focusNode,
    @required this.replyToController
  }) : super(key: key);

  @override
  _SubCommentCard createState() => _SubCommentCard();
}

class _SubCommentCard extends State<SubCommentCard> {
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
    widget.streamController.stream.listen((event) {
      if (event != widget.key) {
        setState(() {
          isShow = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClickableRoundAvatar(
                userId: widget.subCommentInfo.userId,
                onPressed: (int uid) => navi(
                  context,
                  ProfilePage(self: widget.subCommentInfo.userId == Auth.instance.userId, userId: widget.subCommentInfo.userId)
                ),
                size: 36
              ),
              Flexible(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flex(
                            direction: Axis.horizontal,
                            children: widget.subCommentInfo.commentToUserId == 0 ? [
                              ClickableIdLabel(
                                  userId: widget.subCommentInfo.userId,
                                  onPressed: (int id) {
                                    navi(
                                      context,
                                      ProfilePage(self: widget.subCommentInfo.userId == Auth.instance.userId, userId: widget.subCommentInfo.userId)
                                    );
                                  },
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontFamily: 'AmazonEmber'
                                  )
                              ),
                            ]: [
                              ClickableIdLabel(
                                userId: widget.subCommentInfo.userId,
                                onPressed: (int id) {
                                  navi(
                                    context,
                                    ProfilePage(
                                      self: widget.subCommentInfo.userId == Auth.instance.userId,
                                      userId: widget.subCommentInfo.userId
                                    )
                                  );
                                },
                                style: TextStyle(
                                    fontSize: 17,
                                    fontFamily: 'AmazonEmber'
                                )
                              ),
                              Text('   To   ', style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'AmazonEmber'
                              )),
                              ClickableIdLabel(
                                userId: widget.subCommentInfo.commentToUserId,
                                onPressed: (int id) {
                                  navi(
                                    context,
                                    ProfilePage(
                                        self: widget.subCommentInfo.userId == Auth.instance.userId,
                                        userId: widget.subCommentInfo.userId
                                    )
                                  );
                                },
                                style: TextStyle(
                                    fontSize: 17,
                                    fontFamily: 'AmazonEmber'
                                )
                              ),
                            ],
                          ),
                          Divider(),
                          Text(
                              widget.subCommentInfo.content,
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
                                  // mainAxisAlignment: MainAxisAlignment.center,
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
                                              widget.replyToController.add(widget.subCommentInfo.userId);
                                            });
                                          },
                                          child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Icon(Icons.chat_bubble_outline_rounded, color: Colors.white, size: 17),
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