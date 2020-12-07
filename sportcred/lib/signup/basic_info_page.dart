import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sportcred/sign_in/sign_in_page.dart';
import 'package:sportcred/signup/questionnaire_page.dart';
import 'package:sportcred/tool_button/back_button.dart';
import 'package:sportcred/network/packet.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../network/packet.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState ();
}

class _SignUpPageState extends State<SignUpPage> {

  bool _clickable = true;
  bool _emailDuplicate = false;
  bool _usernameDuplicate = false;
  bool passMatch = true;

  var result;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  TextEditingController _confirmPassController = TextEditingController();
  String email;
  String username;
  String password;
  String confirmPassword;

  @override
  Widget build(BuildContext context) {
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
            child: ListView(
              children: <Widget>[
                HeaderSection(),
                infoSection(),
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

  Container infoSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40.0),
      child: Column(
        children: <Widget>[
          textEmail(),
          SizedBox(height: 30.0),
          textUsername(),
          SizedBox(height: 30.0),
          passwordField(),
          SizedBox(height:10.0),
          confirmField(),
        ],
      ),
    );
  }

  TextFormField textEmail() {
    return TextFormField(
      controller: _emailController,
      style:TextStyle(color: Colors.black38),
      decoration: InputDecoration(
          hintText: "Email",
          hintStyle: TextStyle(color: Colors.black38),
          icon:Icon(Icons.email)
      ),
    );
  }

  TextFormField textUsername() {
    return TextFormField(
      controller: _usernameController,
      style:TextStyle(color: Colors.black38),
      decoration: InputDecoration(
          hintText: "Username",
          hintStyle: TextStyle(color: Colors.black38),
          icon:Icon(Icons.assignment_ind)
      ),
    );
  }

  TextFormField passwordField() {
    return TextFormField(
      controller: _passController,
      obscureText: true,
      style: TextStyle(color: Colors.black38),
      decoration: InputDecoration(
          hintText: "Password",
          hintStyle: TextStyle(color: Colors.black38),
          icon:Icon(Icons.lock)
      ),
    );
  }

  TextFormField confirmField() {
    return TextFormField(
      controller: _confirmPassController,
      obscureText: true,
      style: TextStyle(color: Colors.black38),
      decoration: InputDecoration(
          hintText: "Confirm your password",
          hintStyle: TextStyle(color: Colors.black38),
          icon: Icon(null)
      ),
    );
  }

  Container nextStepButton(String txt, int color) {
    return Container(
        width: MediaQuery.of(context).size.width*0.49,
        height: 40.0,
        padding: EdgeInsets.only(left: 5, right:33.0),
        child: RaisedButton(
          onPressed: () async{
            if (_emailController.text=='' && _usernameController.text=='' &&
                _passController.text=='' && _confirmPassController.text==''){
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Empty Form Field"),
                      content: SingleChildScrollView(
                          child: Text('Please enter all required fields')
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
              try {
                Packet packet = Packet(
                  fields: {
                    "email": _emailController.text,
                    "username": _usernameController.text
                  },
                  files: {},
                  endPoint: "/user/email-username-existence?email=${_emailController
                      .text}&username=${_usernameController.text}"
                );
                await packet.get();

                print(packet.responseBody["emailExists"]);
                print(packet.responseBody["usernameExists"]);
                if (packet.body != null && packet.body["emailExists"] ||
                    packet.body["usernameExists"]) {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Duplicate Email/Username"),
                          content: SingleChildScrollView(
                              child: Text(
                                  'This email/username has been used, please enter another email/username')
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
                else if (_passController.text != _confirmPassController.text) {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Password Not Matching"),
                          content: SingleChildScrollView(
                              child: Text('Please confirm your password')
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
                  saveInfo();
                  Navigator.push(context,
                    MaterialPageRoute(
                        builder: (context) => QuestionnairePage()),
                  );
                }
              }
              catch (e) {
                print(e);
              }
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
                Icon(Icons.arrow_forward_ios, color: Colors.white70)
              ]
          ),

        )
    );
  }


  saveInfo() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("email", _emailController.text);
    prefs.setString("username", _usernameController.text);
    prefs.setString("password", _passController.text);
  }

}





