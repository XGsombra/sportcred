import 'package:flutter/material.dart';
import 'package:sportcred/network/comment_rest_driver.dart';
import 'package:sportcred/network/post_rest_driver.dart';
import 'package:sportcred/post/post_card.dart';
import 'package:sportcred/profile/profile.dart';
import 'package:sportcred/sc_widget/blog_header.dart';
import 'package:sportcred/sc_widget/bottom_tool_area.dart';
import 'package:sportcred/sc_widget/flat_icon_button.dart';
import 'package:sportcred/tool_button/like_button.dart';
import 'package:sportcred/sign_in/auth.dart';
import 'package:sportcred/util/util.dart';

import 'comment_body.dart';

class PostBody extends StatefulWidget {
  final PostInfo postInfo;
  final FocusNode focusNode;

  PostBody({
    @required this.focusNode,
    @required this.postInfo
  });

  @override
  PostBodyState createState() => PostBodyState();
}

class PostBodyState extends State<PostBody> {
  Widget likeButton;

  int replyCount = 0;

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
    );
  }

  @override
  void initState() {
    super.initState();
    CommentRestDriver.instance.getComments(widget.postInfo.pid).then((List<CommentInfo> infos) {
      setState(() {
        replyCount = infos.length;
      });
    });

    initLikeButton();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlogHeader(
                  userId: widget.postInfo.uid,
                  size: 36,
                  titleStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'AmazonEmber'
                  ),
                  onPressed: (int id) => navi(
                    context,
                    ProfilePage(self: widget.postInfo.uid == Auth.instance.userId, userId: widget.postInfo.uid)
                  ),
                  space: 12,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            width: double.infinity,
            color: Colors.grey.withOpacity(0.2),
            child: Text(
              widget.postInfo.content,
              style: TextStyle(fontSize: 18, color: Color(0xff666666), fontFamily: 'AmazonEmber'),
            ),
          ),
          widget.postInfo.pictures.length != 0 ? Container(
            // color: Colors.grey.withOpacity(0.2),
            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            child: GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              childAspectRatio: 1,
              children: widget.postInfo.pictures.map((e) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    image: DecorationImage(
                      image: NetworkImage(getImageEndpoint(e)),
                      fit: BoxFit.cover
                    ),
                  ),
                );
                // return Image.network(getImageEndpoint(e));
              }).toList()
            )
          ) : Container(),
          // Container(
          //   color: Colors.grey.withOpacity(0.2),
          //   height: widget.postInfo.pictures.length != 0 ? 8 : null,
          // ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: BottomToolArea(
              children: [
                FlatIconButton(
                  onPressed: () => widget.focusNode.requestFocus(),
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
                likeButton
              ]
            ),
          )
        ],
      ),
    );
  }
}