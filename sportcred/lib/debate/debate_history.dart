import 'package:flutter/material.dart';
import 'package:sportcred/debate/pre_article_card.dart';
import 'dart:convert';

import 'package:sportcred/debate/topic_page.dart';



class DebateHistory extends StatefulWidget {
  final List articles;

  DebateHistory({
    Key key,
    @required this.articles
  }) : super(key: key);

  @override
  _DebateHistoryState createState() => _DebateHistoryState();
}

class _DebateHistoryState extends State<DebateHistory> {
  final ScrollController controller = ScrollController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
            "Debate And Analyze", style: TextStyle(fontFamily: 'AmazonEmber')),
        centerTitle: true,
      ),
      body: Container(
          color: Colors.white,
          child: Scrollbar(
            controller: controller,
            child: ListView.separated(
              controller: controller,
              itemCount: widget.articles.length,
              itemBuilder: (context, index) {
                return ArticlePreviewCard(articleInfo: widget.articles[index], topic: widget.articles[index].topic,);
              },
              separatorBuilder: (context, index) => Divider(),
            ),
          )
      ),
    );
  }
}
