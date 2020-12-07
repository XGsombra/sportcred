import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:sportcred/picks_and_predictions/pick_controller.dart';

class PredictionCard extends StatefulWidget {
  final Map pickInfo;

  PredictionCard({
    Key key,
    @required this.pickInfo,
  }) : super(key: key);


  @override
  _PredictionCardState createState() => _PredictionCardState();
}

class _PredictionCardState extends State<PredictionCard> {


  void updateVoteNumber () {

  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();

    updateVoteNumber();
  }

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
            percent: widget.pickInfo["optionSelectedNumber"][0] /
                (widget.pickInfo["optionSelectedNumber"][0] + widget.pickInfo["optionSelectedNumber"][1]
                    + widget.pickInfo["optionSelectedNumber"][2] + widget.pickInfo["optionSelectedNumber"][3]),
            center: Text(
              widget.pickInfo["options"][0] + " " + widget.pickInfo["optionSelectedNumber"][0].toString() + " votes  "
                  + (100 * widget.pickInfo["optionSelectedNumber"][0] /
                  (widget.pickInfo["optionSelectedNumber"][0] + widget.pickInfo["optionSelectedNumber"][1]
                      + widget.pickInfo["optionSelectedNumber"][2] + widget.pickInfo["optionSelectedNumber"][3])).roundToDouble().toString() + "%",
              style: TextStyle(fontSize: 16.0),
            ),
            trailing: widget.pickInfo["answerIndex"] == 0 ? Icon(Icons.star, color: Color(0xffffd700)): null,
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
            percent: widget.pickInfo["optionSelectedNumber"][1] /
                (widget.pickInfo["optionSelectedNumber"][0] + widget.pickInfo["optionSelectedNumber"][1]
                    + widget.pickInfo["optionSelectedNumber"][2] + widget.pickInfo["optionSelectedNumber"][3]),
            center: Text(
              widget.pickInfo["options"][1] + " " + widget.pickInfo["optionSelectedNumber"][1].toString() + " votes  "
                  + (100 * widget.pickInfo["optionSelectedNumber"][1] /
                  (widget.pickInfo["optionSelectedNumber"][0] + widget.pickInfo["optionSelectedNumber"][1]
                      + widget.pickInfo["optionSelectedNumber"][2] + widget.pickInfo["optionSelectedNumber"][3])).roundToDouble().toString() + "%",
              style: TextStyle(fontSize: 16.0),
            ),
            trailing: widget.pickInfo["answerIndex"] == 1 ? Icon(Icons.star, color: Color(0xffffd700)): null,
            linearStrokeCap: LinearStrokeCap.butt,
            backgroundColor: Color(0xffd3d3d3),
            progressColor: widget.pickInfo["userAnswerIndex"] == 1 ? Colors.red: Colors.orange,
          ),
          SizedBox(height: 10),
          LinearPercentIndicator(
            width: 350,
            lineHeight: 30.0,
            animation: true,
            animationDuration: 1000,
            percent: widget.pickInfo["optionSelectedNumber"][2] /
                (widget.pickInfo["optionSelectedNumber"][0] + widget.pickInfo["optionSelectedNumber"][1]
                    + widget.pickInfo["optionSelectedNumber"][2] + widget.pickInfo["optionSelectedNumber"][3]),
            center: Text(
              widget.pickInfo["options"][2] + " " + widget.pickInfo["optionSelectedNumber"][2].toString() + " votes  "
                  + (100 * widget.pickInfo["optionSelectedNumber"][2] /
                  (widget.pickInfo["optionSelectedNumber"][0] + widget.pickInfo["optionSelectedNumber"][1]
                      + widget.pickInfo["optionSelectedNumber"][2] + widget.pickInfo["optionSelectedNumber"][3])).roundToDouble().toString() + "%",
              style: TextStyle(fontSize: 16.0),
            ),
            trailing: widget.pickInfo["answerIndex"] == 2 ? Icon(Icons.star, color: Color(0xffffd700)): null,
            linearStrokeCap: LinearStrokeCap.butt,
            backgroundColor: Color(0xffd3d3d3),
            progressColor: widget.pickInfo["userAnswerIndex"] == 2 ? Colors.red: Colors.orange,
          ),
          SizedBox(height: 10),
          LinearPercentIndicator(
            width: 350,
            lineHeight: 30.0,
            animation: true,
            animationDuration: 1000,
            percent: widget.pickInfo["optionSelectedNumber"][3] /
                (widget.pickInfo["optionSelectedNumber"][0] + widget.pickInfo["optionSelectedNumber"][1]
                    + widget.pickInfo["optionSelectedNumber"][2] + widget.pickInfo["optionSelectedNumber"][3]),
            center: Text(
              widget.pickInfo["options"][3] + " " + widget.pickInfo["optionSelectedNumber"][3].toString() + " votes  "
                  + (100 * widget.pickInfo["optionSelectedNumber"][3] /
                  (widget.pickInfo["optionSelectedNumber"][0] + widget.pickInfo["optionSelectedNumber"][1]
                      + widget.pickInfo["optionSelectedNumber"][2] + widget.pickInfo["optionSelectedNumber"][3])).roundToDouble().toString() + "%",
              style: TextStyle(fontSize: 16.0),
            ),
            trailing: widget.pickInfo["answerIndex"] == 3 ? Icon(Icons.star, color: Color(0xffffd700)): null,
            linearStrokeCap: LinearStrokeCap.butt,
            backgroundColor: Color(0xffd3d3d3),
            progressColor: widget.pickInfo["userAnswerIndex"] == 3 ? Colors.red: Colors.orange,
          ),
          SizedBox(height: 10),
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
          ),
          RaisedButton(
              child: Text(widget.pickInfo["options"][2]),
              onPressed: () => showConfirm(context, 2, widget.pickInfo["options"][2])
          ),
          RaisedButton(
              child: Text(widget.pickInfo["options"][3]),
              onPressed: () => showConfirm(context, 3, widget.pickInfo["options"][3])
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
            title: Text("Prediction"),
            content: SingleChildScrollView(
                child: Text('Are you sure you want to pick ' + choiceSelected + ' for the award?')
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
                    if (index == 0) widget.pickInfo["optionSelectedNumber"][0] += 1;
                    else if (index == 1) widget.pickInfo["optionSelectedNumber"][1] += 1;
                    else if (index == 2) widget.pickInfo["optionSelectedNumber"][2] += 1;
                    else if (index == 3) widget.pickInfo["optionSelectedNumber"][3] += 1;
                  });
                }
              )
            ],
          );
        });

  }
}
