import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sportcred/network/comment_rest_driver.dart';
import 'package:sportcred/network/post_rest_driver.dart';
import 'package:sportcred/post/post_page.dart';
import 'package:sportcred/profile/profile.dart';
import 'package:sportcred/sc_widget/blog_header.dart';
import 'package:sportcred/sc_widget/bottom_tool_area.dart';
import 'package:sportcred/sc_widget/flat_icon_button.dart';
import 'package:sportcred/sc_widget/foldable_text.dart';
import 'package:sportcred/tool_button/like_button.dart';
import 'package:sportcred/util/util.dart';
import 'package:sportcred/sign_in/auth.dart';

import 'comment_body.dart';

class PostInfo {
  final int pid;
  final int uid;
  final String content;
  int likeCount;
  bool liked;
  final int createTime;
  final List<String> pictures;
  final List<String> tags;

  PostInfo({
    @required this.pid,
    @required this.uid,
    @required this.content,
    @required this.likeCount,
    @required this.liked,
    @required this.createTime,
    @required this.pictures,
    @required this.tags
  });
}

class PostCard extends StatefulWidget {
  final PostInfo postInfo;

  PostCard({
    Key key,
    @required this.postInfo,
  }) : super(key: key);

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  Widget likeButton;
  final StreamController<int> _streamController = StreamController();

  _PostCardState();
  int replyCount = 0;
  bool liked = false;

  void updateCommentCount() {
    CommentRestDriver.instance.getComments(widget.postInfo.pid).then((List<CommentInfo> infos) {
      setState(() {
        replyCount = infos.length;
      });
    });
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void initLikeButton() {
    likeButton = LikeButton(
      id: widget.postInfo.uid,
      update: (int id) async {
        return mapToPostInfo(await PostRestDriver.instance.getPostContent(widget.postInfo.pid)).likeCount;
      },
      onPressed: (bool checked) async {
        if (checked) {
          await PostRestDriver.instance.cancelLikePost(widget.postInfo.pid);
        } else {
          await PostRestDriver.instance.likePost(widget.postInfo.pid);
        }

        return true;
      },
      getStatus: () async {
        return await PostRestDriver.instance.getLikeStatus(widget.postInfo.pid);
      },
      updateController: _streamController,
    );
  }

  @override
  void initState() {
    super.initState();
    initLikeButton();

    updateCommentCount();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlogHeader(
            userId: widget.postInfo.uid,
            onPressed: (id) => navi(context, ProfilePage(self: widget.postInfo.uid == Auth.instance.userId, userId: widget.postInfo.uid)),
            titleStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              fontFamily: 'AmazonEmber'
            ),
            size: 32,
            space: 8
          ),
          Container(
            margin: EdgeInsets.only(top: 12),
            child: FoldableText(
              text: widget.postInfo.content,
              maxLine: 3,
              style: TextStyle(fontSize: 16, color: Colors.blueGrey, fontFamily: 'AmazonEmber'),
            ),
          ),
          Container(
            child: Wrap(
              spacing: 8,
              runSpacing: 4,
              children: () {
                List<Widget> list = List();
                for (var it in widget.postInfo.tags) {
                  list.add(Chip(
                    label: amazonize(it),
                  ));
                }
                return list;
              }.call(),
            ),
          ),
          BottomToolArea(
            children: [
              FlatIconButton(
                onPressed: () async {
                  await PostRestDriver.instance.viewPost(widget.postInfo.pid);
                  navi(context, PostPage(postInfo: widget.postInfo)).then((value) {
                    updateCommentCount();
                    _streamController.add(0);
                  });
                },
                text: Text(
                  numberToCompactString(replyCount),
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontFamily: 'SFPro',
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.left,
                ),
                icon: Icon(Icons.chat_bubble, color: Colors.deepPurple),
                width: 130,
              ),
              likeButton,
            ],
          )
        ]
      )
    );
  }
}
