import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sportcred/playoff/playoff_card.dart';
import 'playoff_controller.dart';

import 'paint.dart';

class Playoff extends StatefulWidget {
  final List gameInfo;

  Playoff({
    @required this.gameInfo
  });

  @override
  _PlayoffState createState() => _PlayoffState();
}

class _PlayoffState extends State<Playoff> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      leading: BackButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      title: Text("Playoff Brackets", style: TextStyle(fontFamily: 'AmazonEmber')),
      centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PlayoffCard(teamName: widget.gameInfo[0]["options"][0], logoURI: widget.gameInfo[0]["logos"][0],),
                PlayoffCard(teamName: widget.gameInfo[0]["options"][1], logoURI: widget.gameInfo[0]["logos"][1],),
                PlayoffCard(teamName: widget.gameInfo[1]["options"][0], logoURI: widget.gameInfo[1]["logos"][0],),
                PlayoffCard(teamName: widget.gameInfo[1]["options"][1], logoURI: widget.gameInfo[1]["logos"][1],),
                PlayoffCard(teamName: widget.gameInfo[2]["options"][0], logoURI: widget.gameInfo[2]["logos"][0],),
                PlayoffCard(teamName: widget.gameInfo[2]["options"][1], logoURI: widget.gameInfo[2]["logos"][1],),
                PlayoffCard(teamName: widget.gameInfo[3]["options"][0], logoURI: widget.gameInfo[3]["logos"][0],),
                PlayoffCard(teamName: widget.gameInfo[3]["options"][1], logoURI: widget.gameInfo[3]["logos"][1],),
              ],
            ),
            CustomPaint(
                size: Size(MediaQuery.of(context).size.width,40),
                painter: MyPainter()
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of((context)).size.width * 0.06),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PlayoffCard(teamName: widget.gameInfo[8]["options"][0], logoURI: widget.gameInfo[8]["logos"][0],),
                  PlayoffCard(teamName: widget.gameInfo[8]["options"][1], logoURI: widget.gameInfo[8]["logos"][1],),
                  PlayoffCard(teamName: widget.gameInfo[9]["options"][0], logoURI: widget.gameInfo[9]["logos"][0],),
                  PlayoffCard(teamName: widget.gameInfo[9]["options"][1], logoURI: widget.gameInfo[9]["logos"][1],),
                ],
              ),
            ),
            CustomPaint(
                size: Size(MediaQuery.of(context).size.width,40),
                painter: MyPainter2()
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of((context)).size.width * 0.182),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PlayoffCard(teamName: widget.gameInfo[12]["options"][0], logoURI: widget.gameInfo[12]["logos"][0],),
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      image: DecorationImage(
                        image: AssetImage("assets/western.png"),
                      )
                    ),
                  ),
                  PlayoffCard(teamName: widget.gameInfo[12]["options"][1], logoURI: widget.gameInfo[12]["logos"][1],),
                ],
              ),
            ),
            CustomPaint(
                size: Size(MediaQuery.of(context).size.width,40),
                painter: MyPainter3()
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of((context)).size.width * 0.364),
              child: PlayoffCard(teamName: widget.gameInfo[14]["options"][0], logoURI: widget.gameInfo[14]["logos"][0],),
            ),
            CustomPaint(
                size: Size(MediaQuery.of(context).size.width,20),
                painter: MyPainter4()
            ),
            Container(
              padding: EdgeInsets.only(left: 105, right: MediaQuery.of((context)).size.width * 0.363),
              child: Row(
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                          image: AssetImage("assets/cup.png"),
                        )
                    ),
                  ),
                  PlayoffCard(
                    teamName: widget.gameInfo[14]["options"][widget.gameInfo[14]["answerIndex"]],
                    logoURI: widget.gameInfo[14]["logos"][widget.gameInfo[14]["answerIndex"]],),
                ],
              )
            ),
            CustomPaint(
                size: Size(MediaQuery.of(context).size.width,20),
                painter: MyPainter4()
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of((context)).size.width * 0.364),
              child: PlayoffCard(teamName: widget.gameInfo[14]["options"][1], logoURI: widget.gameInfo[14]["logos"][1],),
            ),
            CustomPaint(
                size: Size(MediaQuery.of(context).size.width,40),
                painter: MyPainter5()
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of((context)).size.width * 0.182),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PlayoffCard(teamName: widget.gameInfo[13]["options"][0], logoURI: widget.gameInfo[13]["logos"][0],),
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                          image: AssetImage("assets/eastern.png"),
                        )
                    ),
                  ),
                  PlayoffCard(teamName: widget.gameInfo[13]["options"][1], logoURI: widget.gameInfo[13]["logos"][1],),
                ],
              ),
            ),
            CustomPaint(
                size: Size(MediaQuery.of(context).size.width,40),
                painter: MyPainter6()
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of((context)).size.width * 0.06),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PlayoffCard(teamName: widget.gameInfo[10]["options"][0], logoURI: widget.gameInfo[10]["logos"][0],),
                  PlayoffCard(teamName: widget.gameInfo[10]["options"][1], logoURI: widget.gameInfo[10]["logos"][1],),
                  PlayoffCard(teamName: widget.gameInfo[11]["options"][0], logoURI: widget.gameInfo[11]["logos"][0],),
                  PlayoffCard(teamName: widget.gameInfo[11]["options"][1], logoURI: widget.gameInfo[11]["logos"][1],),
                ],
              ),
            ),
            CustomPaint(
                size: Size(MediaQuery.of(context).size.width,40),
                painter: MyPainter7()
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PlayoffCard(teamName: widget.gameInfo[4]["options"][0], logoURI: widget.gameInfo[4]["logos"][0],),
                PlayoffCard(teamName: widget.gameInfo[4]["options"][1], logoURI: widget.gameInfo[4]["logos"][1],),
                PlayoffCard(teamName: widget.gameInfo[5]["options"][0], logoURI: widget.gameInfo[5]["logos"][0],),
                PlayoffCard(teamName: widget.gameInfo[5]["options"][1], logoURI: widget.gameInfo[5]["logos"][1],),
                PlayoffCard(teamName: widget.gameInfo[6]["options"][0], logoURI: widget.gameInfo[6]["logos"][0],),
                PlayoffCard(teamName: widget.gameInfo[6]["options"][1], logoURI: widget.gameInfo[6]["logos"][1],),
                PlayoffCard(teamName: widget.gameInfo[7]["options"][0], logoURI: widget.gameInfo[7]["logos"][0],),
                PlayoffCard(teamName: widget.gameInfo[7]["options"][1], logoURI: widget.gameInfo[7]["logos"][1],),
              ],
            ),
          ],
        )
      ),
    );
  }
}
