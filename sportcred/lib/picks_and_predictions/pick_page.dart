import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sportcred/picks_and_predictions/prediction_page.dart';
import 'package:sportcred/playoff/playoff_brackets.dart';
import 'package:sportcred/playoff/playoff_controller.dart';
import 'package:sportcred/util/util.dart';
import 'pick_controller.dart';
import 'daily_pick.dart';


class PickPage extends StatefulWidget {
  final List pickInfo;
  final List predictionInfo;

  PickPage({
    Key key,
    @required this.pickInfo,
    @required this.predictionInfo,
  }): super(key: key);

  @override
  _PickPageState createState() => _PickPageState();
}

class _PickPageState extends State<PickPage> {
  int curIdx = 0;
  List<Widget> pages;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Picks and Predictions', style: TextStyle(fontFamily: 'AmazonEmber')),
            centerTitle: true,
            actions: [
              FlatButton(
                onPressed: () async {
                  List gameInfo = await PlayoffController.instance.getGames();
                  print(gameInfo[0]);
                  navi(context, Playoff(gameInfo: gameInfo,));
                },
                child: Text("Playoff", style: TextStyle(color: Colors.white, fontFamily: 'AmazonEmber'),),
              )
            ],
            bottom: TabBar(
              labelStyle: TextStyle(fontFamily: 'AmazonEmber'),
              tabs: [
                Tab(
                  text: 'Daily Picks',
                ),
                Tab(text: 'Predictions'),

              ],
            ),
          ),

          // drawer: SCDrawer(),
          body: TabBarView(
            children: pages,
          ),
        ));
  }

  @override
  void initState() {
    super.initState();
    pages = [
      DailyPickPage(pickInfo: widget.pickInfo),
      PredictionPage(predictionInfo: widget.predictionInfo)
    ];
  }



}
