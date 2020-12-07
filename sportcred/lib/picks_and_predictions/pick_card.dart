import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:sportcred/picks_and_predictions/pick_controller.dart';


class PickCard extends StatefulWidget {
  final Map pickInfo;

  PickCard({
    Key key,
    @required this.pickInfo,
  }) : super(key: key);


  @override
  _PickCardState createState() => _PickCardState();
}

class _PickCardState extends State<PickCard> {

  @override
  Widget build(BuildContext context) {
    print(widget.pickInfo["answerIndex"]);
    return widget.pickInfo["userAnswerIndex"] != -1 ? Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            widget.pickInfo["content"],
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 10),
          LinearPercentIndicator(
            width: 350,
            lineHeight: 30.0,
            animation: true,
            animationDuration: 1000,
            percent: widget.pickInfo["optionSelectedNumber"][0] / (widget.pickInfo["optionSelectedNumber"][0] + widget.pickInfo["optionSelectedNumber"][1]),
            center: Text(
              widget.pickInfo["options"][0] + " " + widget.pickInfo["optionSelectedNumber"][0].toString() + " votes  "
                  + (100 * widget.pickInfo["optionSelectedNumber"][0] / (widget.pickInfo["optionSelectedNumber"][0] + widget.pickInfo["optionSelectedNumber"][1])).roundToDouble().toString() + "%",
              style: TextStyle(fontSize: 16.0),
            ),
            trailing: widget.pickInfo["answerIndex"] == 0 ? Icon(Icons.star, color: Color(0xffffd700),): null,
            linearStrokeCap: LinearStrokeCap.butt,
            backgroundColor: Color(0xffd3d3d3),
            progressColor: widget.pickInfo["userAnswerIndex"] == 0 ? Colors.red: Colors.orange,
          ),
          SizedBox(height: 10),
          LinearPercentIndicator(
            width: 350,
            lineHeight: 30.0,
            animation: true,
            animationDuration: 1000,
            percent: widget.pickInfo["optionSelectedNumber"][1] / (widget.pickInfo["optionSelectedNumber"][0] + widget.pickInfo["optionSelectedNumber"][1]),
            center: Text(
              widget.pickInfo["options"][1] + " " + widget.pickInfo["optionSelectedNumber"][1].toString() + " votes  "
                  + (100 * widget.pickInfo["optionSelectedNumber"][1] / (widget.pickInfo["optionSelectedNumber"][0] + widget.pickInfo["optionSelectedNumber"][1])).roundToDouble().toString() + "%",
              style: TextStyle(fontSize: 16.0),
            ),
            trailing: widget.pickInfo["answerIndex"] == 1 ? Icon(Icons.star, color: Color(0xffffd700),): null,
            linearStrokeCap: LinearStrokeCap.butt,
            backgroundColor: Color(0xffd3d3d3),
            progressColor: widget.pickInfo["userAnswerIndex"] == 1 ? Colors.red: Colors.orange,
          )
        ],
      ),
    ) : Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            widget.pickInfo["content"],
            style: TextStyle(fontSize: 20),
          ),
          RaisedButton(
            child: Text(widget.pickInfo["options"][0]),
            onPressed: () => showConfirm(context, 0, widget.pickInfo["options"][0])
          ),
          RaisedButton(
            child: Text(widget.pickInfo["options"][1]),
            onPressed: () => showConfirm(context, 1, widget.pickInfo["options"][1])
          )
        ],
      ),
    );
  }


  showConfirm (BuildContext context, int index, String choiceSelected) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Pick your team for today's game"),
          content: SingleChildScrollView(
              child: Text('Are you sure you want to pick ' + choiceSelected + '?')
          ),
          actions: <Widget>[
            FlatButton(
                child: Text("Cancel"),
                onPressed: () {
                  Navigator.of(context).pop();
                }
            ),
            FlatButton(
                child: Text("Yes!"),
                onPressed: () async {
                  await PickController.instance.postSelection(widget.pickInfo["id"], index);
                  Navigator.of(context).pop();
                  setState(() {
                    widget.pickInfo["userAnswerIndex"] = index;
                    if (index == 0) {
                      widget.pickInfo["optionSelectedNumber"][0] += 1;
                    }
                    else widget.pickInfo["optionSelectedNumber"][1] += 1;
                  });
                }
            )
          ],
        );
      });

  }
}
