import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sportcred/profile/profile.dart';
import 'package:sportcred/sc_widget/clickable_id_label.dart';
import 'package:sportcred/sc_widget/clickable_round_avatar.dart';
import 'package:sportcred/sc_widget/horizontal_splitter.dart';
import 'package:sportcred/sign_in/auth.dart';
import 'package:sportcred/util/util.dart';

class CommentCard extends StatefulWidget {
  final int cid;
  final int uid;
  final String comment;
  final StreamController<Key> streamController;
  final FocusNode focusNode;
  final StreamController<int> replyToController;

  CommentCard({
    Key key,
    @required this.cid,
    @required this.uid,
    @required this.streamController,
    @required this.focusNode,
    @required this.replyToController,
    @required this.comment
  }) : super(key: key);

  @override
  _CommentCardState createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  bool isShow = false;

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
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

    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClickableRoundAvatar(
            userId: widget.uid,
            onPressed: (int uid) => navi(context, ProfilePage(self: widget.uid == Auth.instance.userId, userId: widget.uid)),
            size: 36
          ),
          Flexible(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClickableIdLabel(
                        userId: widget.uid,
                        onPressed: (int id) { navi(
                          context,
                          ProfilePage(self: widget.uid == Auth.instance.userId, userId: widget.uid)
                        ); },
                        style: TextStyle(
                          fontSize: 17,
                          fontFamily: 'AmazonEmber'
                        )
                      ),
                      Divider(),
                      Text(
                        widget.comment,
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
                            width: isShow ? 170 : 0,
                            height: 36,
                            duration: Duration(milliseconds: 100),
                            child: Flex(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              direction: Axis.horizontal,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        isShow = !isShow;
                                      });
                                      widget.streamController.add(isShow ? widget.key : null);
                                    },
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
                                      widget.replyToController.add(0);
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
    );
  }
}