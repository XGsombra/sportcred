import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportcred/cache/cache.dart';
import 'package:sportcred/debate/article_card.dart';
import 'package:sportcred/debate/topic_page.dart';
import 'package:sportcred/debate/debate_controller.dart';
import 'package:sportcred/picks_and_predictions/pick_controller.dart';
import 'package:sportcred/picks_and_predictions/pick_page.dart';
import 'package:sportcred/playoff/playoff_brackets.dart';
import 'package:sportcred/post/post_card.dart';
import 'package:sportcred/post/post_create.dart';
import 'package:sportcred/trivia/trivia.dart';
import 'package:sportcred/util/util.dart';
import 'package:sportcred/util/mock_widgets.dart';

class ZonePage extends StatefulWidget {
  @override
  _ZonePageState createState() => _ZonePageState();
}

class _ZonePageState extends State<ZonePage> {
  final ScrollController controller = ScrollController();
  var length = 0;
  List<PostInfo> cards = List<PostInfo>();
  var _previewWidgets = PostPreviewCache.instance;

  void updateWidget() {}

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
    _previewWidgets.init().then((value) {
      setState(() {
        cards = _previewWidgets.postInfo;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          color: Colors.white,
          child: RefreshIndicator(
            // controller: controller,
            onRefresh: () async {
              await _previewWidgets.refresh();
              setState(() {
                cards = _previewWidgets.postInfo;
              });
            },
            child: ListView.separated(
              controller: controller,
              itemCount: cards.length,
              itemBuilder: (context, index) {
                return PostCard(key: UniqueKey(), postInfo: cards[index]);
              },
              separatorBuilder: (context, index) => Divider(),
            ),
          )
        ),
        floatingActionButton: Stack(
          children: [
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  child: FloatingActionButton(
                    heroTag: '0',
                    onPressed: () async {
                      var success = await navi(context, PostCreate());
                      // _previewWidgets.refresh().then((value) {
                      //   setState(() {
                      //     cards = _previewWidgets.postInfo;
                      //   });
                      // });
                      if (success ?? false) {
                        Scaffold.of(context).showSnackBar(
                          SnackBar(content: amazonize('Post Successfully Transmitted!'))
                        );
                      }
                    },
                    child: Icon(Icons.create),
                    backgroundColor: Color(0xff14a76c),
                  )),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                child: SpeedDial(
                  backgroundColor: Colors.red,
                  closeManually: false,
                  child: Icon(Icons.more),
                  curve: Curves.easeIn,
                  children: [
                    SpeedDialChild(
                        onTap: () => navi(context, Trivia()),
                        backgroundColor: Colors.deepPurple,
                        label: 'Trivia',
                        child: Icon(Icons.whatshot)),
                    // child: Icon(Icons.whatshot)),
                    SpeedDialChild(
                      onTap: () async {
                        List picks = await PickController.instance.getPickInfo('pick');
                        List predictions = await PickController.instance.getPickInfo("prediction");
                        navi(context,
                          PickPage(
                            pickInfo: picks,
                            predictionInfo: predictions));
                      },
                      backgroundColor: Colors.green,
                      label: 'Picks',
                      child: Icon(Icons.track_changes)),
                    SpeedDialChild(
                        backgroundColor: Colors.blue,
                        label: 'Analyze',
                        child: Icon(Icons.data_usage),
                        onTap: () async {
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          Map<String, dynamic> topicFromServer = await DebateController.instance.getTopics(prefs.getString("accessToken"));
                          TopicInfo info = TopicInfo(tier: topicFromServer["tier"], topics: topicFromServer["topics"]);
                          print(info.topics.toString());
                          ArticleInfo article1 =
                            info.topics[0]["popularAnalyzeId"] == 0 ? ArticleInfo(
                                pid: 0,
                                uid: 0,
                                topicId: 0,
                                content: "",
                                agreeRate: "",
                                rateCount: 0,
                                userAgreeRate: 0,
                                topic: "",
                                tier: "",
                                createTime: 0,
                                pictures: [""]) : await DebateController.instance.getPost(info.topics[0]["popularAnalyzeId"]);
                          ArticleInfo article2 =
                            info.topics[1]["popularAnalyzeId"] == 0 ? ArticleInfo(
                                pid: 0,
                                uid: 0,
                                topicId: 0,
                                content: "",
                                agreeRate: "",
                                rateCount: 0,
                                userAgreeRate: 0,
                                topic: "",
                                tier: "",
                                createTime: 0,
                                pictures: [""]) : await DebateController.instance.getPost(info.topics[1]["popularAnalyzeId"]);
                          ArticleInfo article3 =
                            info.topics[2]["popularAnalyzeId"] == 0 ? ArticleInfo(
                                pid: 0,
                                uid: 0,
                                topicId: 0,
                                content: "",
                                agreeRate: "",
                                rateCount: 0,
                                userAgreeRate: 0,
                                topic: "",
                                tier: "",
                                createTime: 0,
                                pictures: [""]) : await DebateController.instance.getPost(info.topics[2]["popularAnalyzeId"]);
                          navi(context, TopicPage(topicInfo: info, article1: article1, article2: article2, article3: article3,));
                        },
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
