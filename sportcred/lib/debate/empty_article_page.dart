import 'package:flutter/material.dart';
import 'package:sportcred/util/util.dart';
import 'analyze_create.dart';
import 'article_card.dart';


class EmptyArticlePage extends StatefulWidget {
  final ArticleInfo articleInfo;
  final String topic;

  EmptyArticlePage({
    Key key,
    @required this.articleInfo,
    @required this.topic,
  }) : super(key: key);

  @override
  _EmptyArticlePageState createState() => _EmptyArticlePageState();
}

class _EmptyArticlePageState extends State<EmptyArticlePage> {
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
            child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 50,),
                  Row(
                    children: <Widget>[
                      Expanded(
                          child: Text(
                            'There is no unrated article',
                            style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic, color: Colors.black38),
                            textAlign: TextAlign.center,
                          )
                      )
                    ],
                  )
                ]
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
          ],
        )
    );
  }
}
