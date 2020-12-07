import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sportcred/network/coop_rest_driver.dart';
import 'package:sportcred/network/solo_rest_driver.dart';
import 'package:sportcred/trivia/coop.dart';
import 'package:sportcred/trivia/solo.dart';
import 'package:sportcred/util/util.dart';

class Trivia extends StatefulWidget {
  final FirebaseApp app;
  Trivia({this.app});

  @override
  _TriviaState createState() => _TriviaState();
}

class _TriviaState extends State<Trivia> {
  final db = FirebaseDatabase.instance;
  final TextEditingController _textEditingController = TextEditingController();

  DatabaseReference soloRef;

  @override
  void initState() {
    final FirebaseDatabase database = FirebaseDatabase(app: widget.app);
    soloRef = database.reference().child('Solo');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dbRef = db.reference();

    return Scaffold(
      appBar: AppBar(
        title: amazonize('Gaming'),
        centerTitle: true,
      ),
      body: Container(
        child: ListView(
          children: [
            ListTile(
              title: Text("Solo Game", style: TextStyle(fontSize: 24)),
              trailing: IconButton(
                icon: Icon(Icons.arrow_forward_sharp),
                onPressed: () async {
                  navi(context, Solo(
                    triviaQuestionList: await SoloRestDriver.instance.getTriviaQuestionList())
                  );
                },
              ),
            ),
            ListTile(
              title: Text("Multiplayer", style: TextStyle(fontSize: 24)),
              trailing: IconButton(
                icon: Icon(Icons.arrow_forward_sharp),
                onPressed: () async {
                  navi(context, Coop(
                    coopRoomInfo: await CoopRestDriver.instance.getCoopRoomInfo(),
                  ));
                },
              ),
            )
          ],
        ),
      ),
    );
    // return Scaffold(
    //   appBar: AppBar(),
    //   body: Container(
    //     child: Flex(
    //       direction: Axis.vertical,
    //       children: [
    //         Flexible(
    //           child: TextField(
    //             controller: _textEditingController,
    //           ),
    //         ),
    //         Flexible(
    //           child: FlatButton.icon(
    //             onPressed: () {
    //               dbRef
    //                   .child('Solo')
    //                   .push()
    //                   .child('Trivia')
    //                   .set(_textEditingController.text)
    //                   .asStream();
    //               _textEditingController.clear();
    //             },
    //             icon: Icon(Icons.upload_file),
    //             label: amazonize("Upload"),
    //           ),
    //         ),
    //         Flexible(
    //           flex: 3,
    //           child: FirebaseAnimatedList(
    //             itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
    //               return ListTile(title: Text(snapshot.value['Trivia']));
    //             },
    //             query: soloRef,
    //           ),
    //         )
    //       ],
    //     ),
    //   ),
    // );
  }
}