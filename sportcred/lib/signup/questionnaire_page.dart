import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sportcred/tool_button/back_button.dart';
import 'package:sportcred/sign_in/sign_in_page.dart';
import 'photo_upload_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuestionnairePage extends StatefulWidget {
  @override
  _QuestionnairePageState createState() => _QuestionnairePageState();
}


class _QuestionnairePageState extends State<QuestionnairePage> {
  bool _isLoading = false;

  List questions = ["Favorite sport?",
    "Age",
    "What sport would you like to know/learn about?",
    "Favorite sports team?"];

  Question3 selectedItem;
  List<Question3> options = <Question3>[Question3(1, "no history"),
                                        Question3(2, "recreational"),
                                        Question3(3, "high school"),
                                        Question3(4, "university"),
                                        Question3(5, "professional"),
  ];

  TextEditingController q1Controller = TextEditingController();
  TextEditingController q2Controller = TextEditingController();
  TextEditingController q4Controller = TextEditingController();
  TextEditingController q5Controller = TextEditingController();


  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.black38));
    return Scaffold(
        body: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () async {
              FocusScope.of(context).requestFocus(FocusNode());
            },
        child:Container(
          decoration: BoxDecoration(
              color: Colors.white
          ),
          child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : ListView(
            children: <Widget>[
              HeaderSection(),
              questionSection(),
              Container(//multiple choice question and dropdown menu
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                    children: [
                      Icon(Icons.arrow_drop_down_circle, color: Colors.black38),
                      SizedBox(width: 14,),
                      Text("Highest level of sport play", style: TextStyle(fontSize: 14),),
                    ]),
                    DropdownButton<Question3>(
                      hint: Text("Select item"),
                      value: selectedItem,
                      onChanged: (Question3 stateValue){
                        setState(() {
                          selectedItem = stateValue;
                        });
                      },
                      items: options.map((Question3 option){
                        return DropdownMenuItem<Question3>(
                          value: option,
                          child: Text(option.selection),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40.0),
              Row(
                children: [
                  GoBackButton("Login Page"),
                  nextStepButton("  Next Step", 0xff14A76C),
                ],
              )
            ],
          )
        ),
      ),
    );
  }

  Widget nextStepButton(txt, color) {
    return Container(
        width: MediaQuery.of(context).size.width*0.49,
        height: 40.0,
        padding: EdgeInsets.only(left: 5, right:33.0),
        child: RaisedButton(
          onPressed:  () {
            if (q1Controller.text == "" || q2Controller.text == "" ||
                q4Controller.text == "" || q5Controller.text == "" ||
                selectedItem == null) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Empty Form Field"),
                      content: SingleChildScrollView(
                          child: Text('Please answer the questions')
                      ),
                      actions: <Widget>[
                        FlatButton(
                            child: Text("OK"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            }
                        )
                      ],
                    );
                  }
              );
            }
            else {
              savePrefs();
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => PhotoUploadPage()),
              );
            }
          },
          color: Color(color),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(txt, style: TextStyle(color: Colors.white70)),
                Icon(Icons.arrow_forward_ios, color: Colors.white70,)
              ]
          ),

        )
    );
  }

  Widget questionSection() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 40.0),
        child: Column(
          children: <Widget>[
            Text("Questionnaire",
              style: TextStyle(
                color: Colors.black38,
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
            q1(),
            SizedBox(height: 15.0),
            q2(),
            SizedBox(height: 15.0),
            q4(),
            SizedBox(height: 15.0),
            q5(),
            SizedBox(height: 15.0),

          ],
        )

    );
  }

  Widget q1() {
    return TextFormField(
      controller: q1Controller,
      style: TextStyle(color: Colors.black38),
      decoration: InputDecoration(
        hintText: questions[0],
        hintStyle: TextStyle(color: Colors.black38, fontSize: 14),
        icon: Icon(Icons.border_color),
      ),
    );
  }

  Widget q2() {
    return TextFormField(
      controller: q2Controller,
      style: TextStyle(color: Colors.black38),
      decoration: InputDecoration(
        hintText: questions[1],
        hintStyle: TextStyle(color: Colors.black38, fontSize: 14),
        icon: Icon(Icons.border_color),
      ),
    );
  }

  Widget q4() {
    return TextFormField(
      controller: q4Controller,
      style: TextStyle(color: Colors.black38),
      decoration: InputDecoration(
        hintText: questions[2],
        hintStyle: TextStyle(color: Colors.black38, fontSize: 14),
        icon: Icon(Icons.border_color),
      ),
    );
  }

  Widget q5() {
    return TextFormField(
      controller: q5Controller,
      style: TextStyle(color: Colors.black38),
      decoration: InputDecoration(
        hintText: questions[3],
        hintStyle: TextStyle(color: Colors.black38, fontSize: 14),
        icon: Icon(Icons.border_color),
      ),
    );
  }

  savePrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString("q1", q1Controller.text);
    prefs.setString("q2", q2Controller.text);
    prefs.setString("q4", q4Controller.text);
    prefs.setString("q5", q5Controller.text);
    prefs.setString("q3", selectedItem.selection);
  }
}


class Question3{
  final int id;
  final String selection;

  const Question3(this.id,this.selection);
}
