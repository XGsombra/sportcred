
import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportcred/debate/debate_controller.dart';
import 'package:sportcred/debate/pre_article_card.dart';
import 'article_card.dart';
import 'package:sportcred/util/util.dart';
import 'package:sportcred/sc_widget/blog_header.dart';
import 'package:sportcred/sc_widget/foldable_text.dart';
import 'package:sportcred/util/mock_widgets.dart';
import 'article_page.dart';
import 'debate_history.dart';

import '../network/packet.dart';
import 'empty_article_page.dart';

class TopicInfo {
  final String tier;
  final List<dynamic> topics;

  TopicInfo({
    this.tier,
    this.topics
  });
}

class TopicPage extends StatefulWidget {
  final TopicInfo topicInfo;
  final ArticleInfo article1;
  final ArticleInfo article2;
  final ArticleInfo article3;
  TopicPage({
    Key key,
    @required this.topicInfo,
    @required this.article1,
    @required this.article2,
    @required this.article3,
  }) : super(key: key);


  @override
  _TopicPageState createState() => _TopicPageState();
}

class _TopicPageState extends State<TopicPage> {

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
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: (){Navigator.of(context).pop();},
        ),
        title: Text("Select Debate Topic", style: TextStyle(fontFamily: 'AmazonEmber')),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            textColor: Colors.white,
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                int userId = prefs.getInt("userId");
                String accessToken = prefs.getString("accessToken");
                List ids = await DebateController.instance.getUserPostIds(userId, accessToken);
                List articles = List();
                for (int id in ids) {
                  ArticleInfo article = await DebateController.instance.getPost(id);
                  articles.add(article);
                }
                navi(context, DebateHistory(articles: articles));

              },
              child: Text("History"),
            shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
          )

        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget> [
                    Container(
                      child: Column(
                        children: [
                          Row(
                              children: [
                                Text("Today's topics for ", style: TextStyle(fontSize: 20),),
                                Text(widget.topicInfo.tier, style: TextStyle(fontSize: 25, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),)
                              ]
                          ),
                        ],
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 50.0),
                    ),
                    topicCard(1, widget.topicInfo.topics[0]["topic"]),
                    topicCard(2, widget.topicInfo.topics[1]["topic"]),
                    topicCard(3, widget.topicInfo.topics[2]["topic"]),
                  ],
                )
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text("Top Rated Articles", style: TextStyle(fontSize: 18),),
            ),
            ArticlePreviewCard(articleInfo: widget.article1, topic: widget.topicInfo.topics[0]["topic"],),
            Divider(height: 5,),
            ArticlePreviewCard(articleInfo: widget.article2, topic: widget.topicInfo.topics[1]["topic"],),
            Divider(height: 5,),
            ArticlePreviewCard(articleInfo: widget.article3, topic: widget.topicInfo.topics[2]["topic"],),
          ],
        ),
      )
    );
  }

  Card topicCard(int number, String text){
    return Card(
        child: ListTile(
          onTap: (){
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: Text("Are you sure you want to debate on this topic for today?"),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Cancel"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  FlatButton(
                    child: Text("Yes!"),
                    onPressed: () async {
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      String accessToken = prefs.getString("accessToken");
                      Navigator.of(context).pop();
                      print(widget.topicInfo.topics[number - 1]["id"]);
                      ArticleInfo articleInfo = await DebateController.instance.getRandomArticle(widget.topicInfo.topics[number - 1]["id"], accessToken);
                      if (articleInfo.pid == 0) navi(context, EmptyArticlePage(articleInfo: articleInfo, topic: text));
                      else navi(context, ArticlePage(articleInfo: articleInfo, topic: text,));
                    }
                  )
                ],
              )
            );
          },
          leading: Text(
            number.toString(),
            style: TextStyle(
                fontSize: 30,fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                      blurRadius: 10,
                      color: Colors.black38,
                      offset: Offset(5,5)
                  )
                ]
            ),
          ),
          title: Text(text, style: TextStyle(fontSize: 15),),
          trailing: Icon(Icons.keyboard_arrow_right),
          //contentPadding: EdgeInsets.only(left: 30, top:10,),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),)
    );
  }
}

