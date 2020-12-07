import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mutex/mutex.dart';
import 'package:sportcred/network/coop_rest_driver.dart';
import 'package:sportcred/sc_widget/action_alert.dart';
import 'package:sportcred/sign_in/auth.dart';
import 'package:sportcred/trivia/solo.dart';
import 'package:sportcred/util/util.dart';

class CoopRoomInfo {
  int roomId;
  TriviaQuestionList triviaQuestionList;
  CoopRoomInfo(Map<String, dynamic> data) {
    print(Auth.instance.userId);
    triviaQuestionList = TriviaQuestionList(data);
    roomId = data['roomId'];
  }
}

class Coop extends StatefulWidget {
  final CoopRoomInfo coopRoomInfo;
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  Coop({
    this.coopRoomInfo
  });

  @override
  _CoopState createState() => _CoopState();
}

class _CoopState extends State<Coop> {
  Mutex _mutex = Mutex();
  DatabaseReference _reference;
  DatabaseReference _room;
  int roomId;
  bool gameStarted = false;
  bool processing = true;

  int currentIdx = 0;

  int points = 0;
  int opponentPoints = 0;

  // True indicates game is ended normally
  // False indicates game ended because your opponent left the game
  bool endingState = true;

  // Whether some players send the answer
  bool submitted = false;
  // Whether this player sent the answer
  bool transmitted = false;
  int winner = 0;
  int secRemain = 10;
  int clickedIdx = -1;
  Timer _timer;

  @override
  void setState(fn) {
    if (mounted)
      super.setState(fn);
  }

  void loginFirebase() {
    _room.child('people').set(ServerValue.increment(1));
  }

  void waitForGameToStart() {
    _room.child('people').onValue.listen((event) {
      _mutex.acquire();
      if (event.snapshot.value == 2 && !gameStarted) {
        setState(() {
          gameStarted = true;
        });
        initTimer();
      }
      _mutex.release();
    });
  }

  void submitWrongAnswer() {
    _room.child('submitted').set(ServerValue.increment(1));
    setState(() {
      transmitted = true;
    });
  }

  void submitCorrectAnswer() {
    _room.child('winner').runTransaction((mutableData) async {
      mutableData.value = mutableData.value == 0 ? Auth.instance.userId : mutableData.value;
      return mutableData;
    });

    // _room.child('submitted').set(ServerValue.increment(1));
    setState(() {
      transmitted = true;
    });
  }

  void resetGame() {
    _room.child('submitted').set(0);
    _room.child('winner').set(0);
    setState(() {
      clickedIdx = -1;
      secRemain = 10;
      transmitted = false;
      submitted = false;
      winner = 0;
    });
  }

  void initTimer() {
    _timer = Timer.periodic(
        Duration(seconds: 1), (Timer timer) => setState(() {
          if (secRemain >= 1) {
            secRemain--;
          } else {
            if (processing) {
              secRemain = 3;
            } else {
              currentIdx++;
              if (currentIdx >= widget.coopRoomInfo.triviaQuestionList.length) {
                _timer.cancel();
              }
              resetGame();
            }
            processing = !processing;
          }
        })
    );
  }

  Color getButtonColor(int curIdx, int clickedIdx, int correctIdx) {
    if (curIdx == correctIdx)
      return !processing ? Colors.greenAccent : null;
    if (curIdx == clickedIdx)
      return transmitted || !processing ? Colors.redAccent : null;
    return null;
  }

  void initGameBoard() {
    _room.child('submitted').set(0);
    _room.child('winner').set(0);
  }

  void listenGameState() {
    _room.onChildChanged.listen((event) {
      _mutex.acquire();

      if (event.snapshot.key == 'winner' &&
          winner == 0 && event.snapshot.value != 0) {
        setState(() {
          winner = event.snapshot.value;
          if (winner == Auth.instance.userId) {
            points++;
          } else {
            opponentPoints++;
          }
          secRemain = 3;
          processing = false;
        });
      }

      if (event.snapshot.key == 'submitted' && event.snapshot.value == 2) {
        setState(() {
          winner = 0;
          secRemain = 3;
          processing = false;
        });
      }

      if (gameStarted && event.snapshot.key == 'people' && event.snapshot.value < 2) {
        setState(() {
          _timer.cancel();
          endingState = false;
          currentIdx = widget.coopRoomInfo.triviaQuestionList.length;
        });
      }

      _mutex.release();
    });
  }

  @override
  void initState() {
    _reference = widget._database.reference();
    roomId = widget.coopRoomInfo.roomId;
    _room = _reference.child('Coop').child(roomId.toString());

    loginFirebase();
    waitForGameToStart();
    initGameBoard();
    listenGameState();

    super.initState();
  }

  Widget getEndingPage(bool endingState) {
    if (endingState)
      return Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'You got $points points',
              style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'AmazonEmber'
              ),
            ),
            Text(
              'Opponent got $opponentPoints points',
              style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'AmazonEmber'
              ),
            ),
            Text(
              points == opponentPoints
                  ? 'It is a tie'
                  : (points > opponentPoints ? 'You win!' : 'You lose'),
              style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'AmazonEmber'
              ),
            )
          ],
        )
    );
    return Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Your opponent left the game',
              style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'AmazonEmber'
              ),
            ),
            Text(
              'You win',
              style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'AmazonEmber'
              ),
            )
          ],
        )
    );
  }

  List<Widget> generateButtons(List<String> answers, int correctIdx) {
    List<Widget> buttons = List();
    for (int i = 0; i < answers.length; i++) {
      buttons.add(
        Container(
            color: getButtonColor(i, clickedIdx, correctIdx),
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
              onTap: !transmitted ? () {
                setState(() {
                  if (processing) {
                    clickedIdx = i;
                    if (clickedIdx == correctIdx) {
                      processing = false;
                      submitCorrectAnswer();
                    } else {
                      submitWrongAnswer();
                    }
                  }
                });
              } : null,
            )),
      );
    }
    return buttons;
  }

  String getDialogOfChoice(int clickedIdx, int correctIdx) {
    if (!processing) {
      if (winner == 0)
        return 'No One Get The Correct Answer!';
      if (winner == Auth.instance.userId)
        return 'You Won For This Question!';
      return 'Sorry, You Lose it';
    }

    // Not finish processing
    if (clickedIdx == -1)
      return 'Time Used Up!';
    if (clickedIdx == correctIdx)
      return 'Correct!';
    return 'Incorrect!';
  }

  Widget getQuestionnaire(int index) {
    if (index >= widget.coopRoomInfo.triviaQuestionList.length) {
      return getEndingPage(endingState);
    }
    TriviaQuestion question = widget.coopRoomInfo.triviaQuestionList.questions[index];
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

  Widget getWidget() {
    if (gameStarted)
      return getQuestionnaire(currentIdx);
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(),
          Container(height: 10),
          Text('Waiting For Players To Join', style: TextStyle(
            fontSize: 20
          ))
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (currentIdx >= widget.coopRoomInfo.triviaQuestionList.length)
          return true;

        if (await showActionAlertDialog('Do you want to quit the game ?', context, yes: 'Yes', no: 'No')) {
          _room.child('people').set(ServerValue.increment(-1));
          if (!gameStarted) {
            CoopRestDriver.instance.cancelGameSearching();
          } else {

          }
          return true;
        }
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: amazonize(currentIdx < widget.coopRoomInfo.triviaQuestionList.length
              ? 'Problem ${currentIdx + 1}'
              : 'End'),
          centerTitle: true,
        ),
        body: Container(
          child: getWidget()
        ),
      )
    );
  }
}
