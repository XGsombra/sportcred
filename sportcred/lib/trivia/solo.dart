import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sportcred/network/solo_rest_driver.dart';
import 'package:sportcred/sc_widget/action_alert.dart';
import 'package:sportcred/util/util.dart';

class TriviaQuestion {
  final String question;
  final List<String> answers;
  final int correctIdx;

  TriviaQuestion({
    this.question,
    this.answers,
    this.correctIdx
  });
}

class TriviaQuestionList {
  List<TriviaQuestion> questions;
  int length;
  TriviaQuestionList(Map<String, dynamic> data) {
    questions = List();
    for (var it in data['questionSet']) {
      List<String> lst = List();
      for (var ele in it['answers'])
        lst.add(ele);
      questions.add(TriviaQuestion(
        question: it['question'],
        answers: lst,
        correctIdx: it['correctAnswerIndex']
      ));
    }
    length = questions.length;
  }
}

class Solo extends StatefulWidget {
  final TriviaQuestionList triviaQuestionList;

  Solo({
    this.triviaQuestionList
  });

  @override
  _SoloState createState() => _SoloState();
}

class _SoloState extends State<Solo> {
  int points = 0;
  bool processing = true;

  int secRemain = 14;
  int currentIdx = 0;
  int clickedIdx = -1;

  @override
  void initState() {
    Timer.periodic(
      Duration(seconds: 1),
        (Timer timer) => setState(() {
          if (secRemain >= 1) {
            secRemain--;
          } else {
            if (processing) {
              secRemain = 3;
            } else {
              clickedIdx = -1;
              secRemain = 14;
              currentIdx++;
              if (currentIdx == widget.triviaQuestionList.length) {
                SoloRestDriver.instance.submitTriviaSoloResult(points);
              }
            }
            processing = !processing;
          }
        })
    );
    super.initState();
  }

  Color getButtonColor(int curIdx, int clickedIdx, int correctIdx) {
    if (curIdx == correctIdx)
      return Colors.greenAccent;
    if (curIdx == clickedIdx)
      return Colors.redAccent;
    return null;
  }

  List<Widget> generateButtons(List<String> answers, int correctIdx) {
    List<Widget> buttons = List();
    for (int i = 0; i < answers.length; i++) {
      buttons.add(
        Container(
          color: !processing ? getButtonColor(i, clickedIdx, correctIdx) : null,
          child: ListTile(
            title: Center(
              child: Text(
                answers[i],
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'AmazonEmber'
                ),
              ),
            ),
            onTap: () {
              if (processing) {
                setState(() {
                  clickedIdx = i;
                  secRemain = 3;
                  processing = false;
                });
                points += i == correctIdx ? 1 : -1;
              }
            },
          )),
        );
    }
    return buttons;
  }

  String getDialogOfChoice(int clickedIdx, int correctIdx) {
    if (clickedIdx == -1)
      return 'Time Used Up!';
    if (clickedIdx == correctIdx)
      return 'Correct!';
    return 'Incorrect!';
  }

  Widget getEndingPage() {
    return Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Solo Game Finished! You got',
              style: TextStyle(
                fontSize: 24,
                fontFamily: 'AmazonEmber'
              ),
            ),
            Text(
              '$points points!',
              style: TextStyle(
                fontSize: 24,
                fontFamily: 'AmazonEmber'
              ),
            )
          ],
        )
    );
  }

  Widget getQuestionnaire(int index) {
    if (index >= widget.triviaQuestionList.length) {
      return getEndingPage();
    }
    TriviaQuestion question = widget.triviaQuestionList.questions[index];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          height: 300,
          child: Text(question.question, style: TextStyle(
            fontSize: 22,
            fontFamily: 'AmazonEmber'
          )),
        ),
        Container(
          height: 10,
          color: Colors.grey.withOpacity(0.25),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: generateButtons(question.answers, question.correctIdx),
        ),
        Container(
          height: 10,
          color: Colors.grey.withOpacity(0.25),
        ),
        Container(
          alignment: Alignment.bottomCenter,
          margin: EdgeInsets.symmetric(vertical: 20),
          child: Text(
            processing
              ? '$secRemain sec remain'
              : getDialogOfChoice(clickedIdx, question.correctIdx),
            style: TextStyle(
              fontSize: 18,
              fontFamily: 'Monaco'
            ),
          ),
        ),
      ],
    );
  }

  @override
  void setState(fn) {
    if (mounted)
      super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (currentIdx >= widget.triviaQuestionList.length)
          return true;
        if (await showActionAlertDialog('Do you want to quit the game ?', context, yes: 'Yes', no: 'No')) {
          return true;
        }
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: amazonize(currentIdx < widget.triviaQuestionList.length
            ? 'Solo ${currentIdx + 1}'
            : 'End'),
          centerTitle: true,
          // automaticallyImplyLeading: currentIdx >= widget.triviaQuestionList.length,
        ),
        body: Container(
          child: getQuestionnaire(currentIdx)
        ),
      )
    );
  }
}