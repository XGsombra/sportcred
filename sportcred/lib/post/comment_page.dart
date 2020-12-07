import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sportcred/network/sub_comment_rest_driver.dart';
import 'package:sportcred/post/comment_body.dart';
import 'package:sportcred/post/comment_card.dart';
import 'package:sportcred/post/sub_comment_card.dart';
import 'package:sportcred/util/util.dart';

class CommentPage extends StatefulWidget {
  final CommentInfo commentInfo;

  CommentPage({
    @required this.commentInfo
  });

  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textEditingController = TextEditingController();
  final StreamController<Key> _streamController = StreamController.broadcast();
  final StreamController<int> _replyToController = StreamController(sync: true);
  final FocusNode _focusNode = FocusNode();
  int _replyTo;
  bool isEmpty = true;

  List<SubCommentInfo> subCommentInfo = List<SubCommentInfo>();

  @override
  initState() {
    super.initState();
    getSubComments();
  }

  Future<void> submitSubComments(String content) async {
    await SubCommentRestDriver.instance.submitSubComment(widget.commentInfo.cid, content, _replyTo);
    getSubComments();
  }

  void getSubComments() {
    SubCommentRestDriver.instance.getSubComment(widget.commentInfo.cid).then((infos) {
      setState(() {
        subCommentInfo = infos;
      });
    });
  }

  _CommentPageState() {
    _replyToController.stream.listen((event) {
      setState(() {
        _replyTo = event;
      });
      if (event != null && !_focusNode.hasFocus) {
        print("Requested for a focus");
        FocusScope.of(context).requestFocus(_focusNode);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: amazonize('Comment'),
        centerTitle: true,
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          _streamController.add(null);
          _replyToController.add(null);
          _focusNode.unfocus();
          setState(() {
            _replyTo = null;
          });
        },
        child: Container(
          color: Colors.grey.withOpacity(0.2),
          child: Column(
            children: [
              Flexible(
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: subCommentInfo.length * 2 + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0)
                      return CommentCard(
                        key: UniqueKey(),
                        streamController: _streamController,
                        replyToController: _replyToController,
                        cid: widget.commentInfo.cid,
                        uid: widget.commentInfo.commenter,
                        focusNode: _focusNode,
                        comment: widget.commentInfo.content,
                      );
                    else if (index == 1)
                      return Divider(height: 5);
                    else
                      return index % 2 == 0 ? SubCommentCard(
                        key: UniqueKey(),
                        streamController: _streamController,
                        subCommentInfo: subCommentInfo[index ~/ 2 - 1],
                        replyToController: _replyToController,
                        focusNode: _focusNode,
                      ) : Divider(height: 0);
                  },
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                // left: 0,
                // bottom: 0,
                child: Container(
                  height: _replyTo == null ? 0 : null,
                  width: MediaQuery.of(context).size.width,
                  color: Color(0xffcccccc),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: TextField(
                          onChanged: (String content) {
                            setState(() {
                              isEmpty = content.isEmpty;
                            });
                          },
                          controller: _textEditingController,
                          textInputAction: TextInputAction.newline,
                          focusNode: _focusNode,
                          minLines: 1,
                          maxLines: 4,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            hintText: _replyTo == null ? 'Enter Reply' : ('Reply To ' + _replyTo.toString()),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(left: 10, top: 10, bottom: 10)
                          ),
                          style: TextStyle(fontFamily: 'AmazonEmber', fontSize: 18),
                        ),
                      ),
                      GestureDetector(
                        onTap: _replyTo != null ? () {
                          _scrollController.animateTo(
                            _scrollController.position.maxScrollExtent,
                            duration: Duration(milliseconds: 100),
                            curve: Curves.bounceIn
                          );
                          submitSubComments(_textEditingController.text);
                          _textEditingController.clear();
                          _focusNode.unfocus();
                          setState(() {
                            _replyTo = null;
                            isEmpty = true;
                          });
                        } : null,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Icon(
                            Icons.near_me,
                            size: 30,
                            color: isEmpty ? Colors.grey : getPrimaryColor(context)
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ]
          ),
        )
      ),
    );
  }
}