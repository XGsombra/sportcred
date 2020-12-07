import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sportcred/network/comment_rest_driver.dart';
import 'package:sportcred/post/comment_body.dart';
import 'package:sportcred/post/post_body.dart';
import 'package:sportcred/post/post_card.dart';
import 'package:sportcred/util/util.dart';

class PostPage extends StatefulWidget {
  final PostInfo postInfo;

  PostPage({@required this.postInfo});

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final ScrollController _scrollController = ScrollController();
  final StreamController<Key> _streamController = StreamController.broadcast();
  List<CommentInfo> commentInfo = List<CommentInfo>();
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _textEditingController = TextEditingController();
  bool isEmpty = true;

  @override
  void initState() {
    super.initState();
    getComments();
  }

  void getComments() {
    CommentRestDriver.instance.getComments(widget.postInfo.pid).then((List<CommentInfo> infos) {
      setState(() {
        commentInfo = infos;
      });
    });
  }

  Future<void> submitComment(String content) async {
    await CommentRestDriver.instance.submitComment(widget.postInfo.pid, content);
    getComments();
    print('-------------------HERE---------------------');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post', style: TextStyle(fontFamily: 'AmazonEmber')),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () {
          setState(() => _streamController.add(null));
          _focusNode.unfocus();
        },
        behavior: HitTestBehavior.translucent,
        child: Container(
          color: Colors.grey.withOpacity(0.2),
          child: Scrollbar(
            controller: _scrollController,
            child: Column(
              children: [
                Flexible(
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: commentInfo.length * 2 + 1,
                    itemBuilder: (BuildContext context, int index) {
                      if (index == 0)
                        return PostBody(postInfo: widget.postInfo, focusNode: _focusNode);
                      else if (index == 1)
                        return Container(height: 10);
                      return index % 2 == 0 ? CommentBody(
                        key: UniqueKey(),
                        streamController: _streamController,
                        commentInfo: commentInfo[index ~/ 2 - 1]
                      ) : Divider(height: 0);
                    },
                  ),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    // height: isReply ? null : 0,
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
                              hintText: 'Enter Reply',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(left: 10, top: 10, bottom: 10)
                            ),
                            style: TextStyle(fontFamily: 'AmazonEmber', fontSize: 18),
                          ),
                        ),
                        GestureDetector(
                          onTap: !isEmpty ? () async {
                            _scrollController.animateTo(
                                _scrollController.position.maxScrollExtent,
                                duration: Duration(milliseconds: 150),
                                curve: Curves.bounceIn
                            );
                            await submitComment(_textEditingController.text);
                            _textEditingController.clear();
                            _focusNode.unfocus();
                            setState(() {
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
            )
          )
        )
      )
    );
  }
}