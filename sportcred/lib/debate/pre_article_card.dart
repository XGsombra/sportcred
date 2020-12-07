import 'package:flutter/material.dart';
import 'package:sportcred/profile/profile.dart';
import 'package:sportcred/sc_widget/blog_header.dart';
import 'package:sportcred/sign_in/auth.dart';
import 'package:sportcred/util/util.dart';
import 'package:sportcred/util/mock_widgets.dart';
import 'package:sportcred/sc_widget/foldable_text.dart';
import 'article_card.dart';


class ArticlePreviewCard extends StatefulWidget {
  final ArticleInfo articleInfo;
  final String topic;

  ArticlePreviewCard({
    Key key,
    @required this.articleInfo,
    @required this.topic,
  }) : super(key: key);


  @override
  _ArticlePreviewCardState createState() => _ArticlePreviewCardState();
}

class _ArticlePreviewCardState extends State<ArticlePreviewCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        color: Colors.white,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlogHeader(
                  userId: widget.articleInfo.uid,
                  onPressed: (id) => navi(context, ProfilePage(self: widget.articleInfo.uid == Auth.instance.userId, userId: widget.articleInfo.uid)),
                  titleStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'AmazonEmber'
                  ),
                  size: 32,
                  space: 8
              ),
              Text("Topic: " + widget.topic),
              Container(
                margin: EdgeInsets.only(top: 12),
                child: FoldableText(
                  text: widget.articleInfo.content,
                  maxLine: 3,
                  style: TextStyle(fontSize: 16, color: Colors.blueGrey, fontFamily: 'AmazonEmber'),
                ),
              ),
            ]
        )
    );
  }
}
