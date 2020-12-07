import 'package:flutter/material.dart';

class ArticleInfo {
  final int pid;
  final int uid;
  final int topicId;
  final String content;
  String agreeRate;
  int rateCount;
  int userAgreeRate;
  String topic;
  String tier;
  final int createTime;
  List<dynamic> pictures;

  ArticleInfo({
    @required this.pid,
    @required this.uid,
    @required this.topicId,
    @required this.content,
    @required this.agreeRate,
    @required this.rateCount,
    @required this.userAgreeRate,
    @required this.topic,
    @required this.tier,
    @required this.createTime,
    @required this.pictures
  });
}

class ArticleCard extends StatefulWidget {

  final ArticleInfo articleInfo;

  ArticleCard({
    Key key,
    @required this.articleInfo,
  }) : super(key: key);

  @override
  _ArticleCardState createState() => _ArticleCardState();
}

class _ArticleCardState extends State<ArticleCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: 20, left: 40, right: 20, bottom: 20),
          child: Text(
            widget.articleInfo.content,
            style: TextStyle(fontSize: 20),
          ),
        ),

      ],
    );
  }
}
