import 'dart:async';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportcred/debate/debate_controller.dart';
import 'package:sportcred/network/packet.dart';
import 'package:sportcred/profile/profile.dart';
import 'package:sportcred/sc_widget/blog_header.dart';
import 'package:sportcred/sign_in/auth.dart';
import 'package:sportcred/util/util.dart';
import 'package:sportcred/util/mock_widgets.dart';
import 'package:sportcred/sc_widget/bottom_tool_area.dart';
import 'package:sportcred/tool_button/like_button.dart';
import 'package:sportcred/tool_button/dislike_button.dart';
import 'article_card.dart';
import 'package:sportcred/post/post_create.dart';
import 'package:sportcred/post/comment_body.dart';
import 'package:sportcred/post/comment_card.dart';
import 'package:sportcred/post/comment_page.dart';
import 'analyze_create.dart';
import 'empty_article_page.dart';
import 'topic_page.dart';
import 'dart:convert';

class ArticlePage extends StatefulWidget {
  final ArticleInfo articleInfo;
  final String topic;

  ArticlePage({
    Key key,
    @required this.articleInfo,
    @required this.topic,
  }) : super(key: key);



  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {

  double sliderValue = 0;
  bool isRated = false;
  double avgRate = 0;

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
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text("Debate And Analyze", style: TextStyle(fontFamily: 'AmazonEmber')),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
            decoration: BoxDecoration(color: Colors.white70),
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlogHeader(
                      userId: Auth.instance.userId,
                      onPressed: (id) => navi(context, ProfilePage(self: widget.articleInfo.uid == Auth.instance.userId, userId: widget.articleInfo.uid)),
                      titleStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'AmazonEmber'
                      ),
                      size: 32,
                      space: 8
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Text("Topic: " + widget.topic),
                  ),
                  ArticleCard(articleInfo: widget.articleInfo,),
                  !isRated ? Row(
                    children: [
                      Container(
                          child: Row(
                            children: [
                              Text("Disagree"),
                              Slider(
                                value: this.sliderValue,
                                max: 100.0,
                                min: 0.0,
                                activeColor: Colors.blue,
                                inactiveColor: Colors.grey,
                                divisions: 10,
                                onChanged: (double val) {
                                  this.setState(() {
                                    this.sliderValue = val;
                                    print(this.sliderValue);
                                  });
                                },
                              ),
                              Text("Agree"),
                              IconButton(
                                  icon: Icon(Icons.check),
                                  onPressed: () async {
                                    SharedPreferences prefs = await SharedPreferences.getInstance();
                                    String accessToken = prefs.getString("accessToken");
                                    DebateController.instance.postAgreeRate(this.sliderValue.round(), widget.articleInfo.pid, accessToken);
                                    setState(() {
                                      isRated = true;
                                    });
                                  }
                              )
                            ],
                          )
                      ),
                    ],
                  ) : LinearPercentIndicator(
                    width: 300,
                    lineHeight: 20.0,
                    animation: true,
                    animationDuration: 1000,
                    percent: (double.parse(widget.articleInfo.agreeRate) * widget.articleInfo.rateCount + this.sliderValue.round()) / (widget.articleInfo.rateCount + 1)/ 100,
                    leading: Text("Disagree  "),
                    center: Text(
                      ((double.parse(widget.articleInfo.agreeRate) * widget.articleInfo.rateCount + this.sliderValue.round()) / (widget.articleInfo.rateCount + 1)).round().toString() + "%" + " on average",
                      style: TextStyle(fontSize: 14.0),
                    ),
                    trailing: Text("  Agree"),
                    linearStrokeCap: LinearStrokeCap.roundAll,
                    backgroundColor: Color(0xffd3d3d3),
                    progressColor: Colors.orange,
                  )
                  //CommentBody(key: UniqueKey(), streamController: StreamController(), commentinfo: ),
                ]
            )
        )
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: '0',
            onPressed: () => navi(context, AnalyzeCreate(topic: widget.topic, topicId: widget.articleInfo.topicId)),
            child: Icon(Icons.create),
            backgroundColor: Color(0xff14a76c),
          ),
          SizedBox(height: 40,),
          FloatingActionButton(
            heroTag: '1',
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              String accessToken = prefs.getString("accessToken");
              ArticleInfo articleInfo = await DebateController.instance.getRandomArticle(widget.articleInfo.topicId, accessToken);
              if (!isRated) {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text("Please rate this article."),
                    actions: <Widget>[
                      FlatButton(
                        child: Text("OK!"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  )
                );
              }
              else if(articleInfo.pid == 0) {
                Navigator.of(context).pop();
                navi(context, EmptyArticlePage(articleInfo: articleInfo, topic: widget.topic));
              }
              else {
                Navigator.of(context).pop();
                navi(context, ArticlePage(articleInfo: articleInfo, topic: widget.topic,));
              }
            },
            child: Icon(Icons.arrow_drop_down, size: 50,),
            backgroundColor: Color(0xffff0036),
          ),
        ],
      )
    );
  }
}