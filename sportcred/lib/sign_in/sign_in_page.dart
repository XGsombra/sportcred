import 'package:flutter/cupertino.dart';
import 'package:sportcred/sign_in/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sportcred/debate/topic_page.dart';
import 'package:sportcred/home/zone_page.dart';
import 'package:sportcred/sign_in/auth.dart';
import 'package:sportcred/util/mock_widgets.dart';
import 'package:sportcred/network/packet.dart';
import 'package:sportcred/home/main_page.dart';
import 'package:sportcred/signup/basic_info_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home/main_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
  bool _rememberMe = false;

  TextEditingController idController = TextEditingController();
  TextEditingController pwController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent));
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () async {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
            decoration: BoxDecoration(
                color: Colors.white
            ),
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : ListView(
              children: <Widget>[
                HeaderSection(),
                textSection(),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: <Widget>[
                //     rememberMe(),
                //     ForgotPw(),
                //   ],
                // ),
                signInButton(),
                GoToSignUp(),
              ],
            )
        ),
      )
    );
  }


  Container rememberMe(){
    return Container(
        padding: EdgeInsets.only(left: 30.0),
        child: Row(
            children:<Widget>[
              Theme(
                  data: ThemeData(unselectedWidgetColor: Colors.black38),
                  child: Checkbox(
                    value:_rememberMe,
                    checkColor: Colors.green,
                    activeColor: Colors.white,
                    onChanged: (value) {
                      setState(() {
                        _rememberMe = value;
                      });
                    },
                  )
              ),
              Text(
                'Remember me',
                style:TextStyle(
                    color: Colors.black38
                ),
              )
            ]
        )
    );
  }

  Widget signInButton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40.0,
      margin: EdgeInsets.only(top: 30.0),
      padding: EdgeInsets.symmetric(horizontal:20.0),
      child: RaisedButton(
        onPressed: () async {
          try {
            Packet packet = Packet(
              fields: {
                "id": idController.text,
                "password": pwController.text
              },
              files: {},
              endPoint: "/user/authentication"
            );
            await packet.post(getBody: true);

            if (packet.isSuccess != null && packet.isSuccess) {
              saveToken(packet.body['accessToken'], packet.body['userId']);
              idController.clear();
              pwController.clear();
              FocusScope.of(context).requestFocus(FocusNode());
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => MainPage()),
              );
            }
            else {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Wrong username or password"),
                      content: SingleChildScrollView(
                          child: Text('Please enter a correct username and password')
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
          }
          catch(e) {
            print("Wrong username or password.");
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("Wrong username or password"),
                  content: SingleChildScrollView(
                    child: Text('Please enter a correct username and password')
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
        },
        color: Color(0xffff652f),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        child:Text("Sign In", style: TextStyle(color: Colors.white70)),
      ),
    );
  }

  Widget textSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      margin:EdgeInsets.only(top:30.0),
      child: Column(
        children: <Widget>[
          idField("Email/username", Icons.assignment_ind),
          SizedBox(height: 30.0),
          passField("Password", Icons.lock),
        ],
      ),
    );
  }

  Widget idField(title, icon) {
    return TextFormField(
      controller: idController,
      style:TextStyle(color: Colors.black38),
      decoration: InputDecoration(
          hintText: title,
          hintStyle: TextStyle(color: Colors.black38),
          icon:Icon(icon)
      ),
    );
  }

  Widget passField(title, icon) {
    return TextFormField(
      controller: pwController,
      style:TextStyle(color: Colors.black38),
      obscureText: true,
      decoration: InputDecoration(
          hintText: title,
          hintStyle: TextStyle(color: Colors.black38),
          icon:Icon(icon)
      ),
    );
  }

  saveToken(token, id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString("accessToken", token);
    await sharedPreferences.setInt("userId", id);
    await Auth.instance.getAuth();
  }
}

class HeaderSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 80.0),
      child: Image(
          image: AssetImage('assets/logo1.png')
      ),
    );
  }
}



class ForgotPw extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerRight,
        child: FlatButton(
            onPressed: () => print('Forgot Password Button Pressed'),
            padding: EdgeInsets.only(right: 30.0),
            child: Text(
                'Forgot Password?',
                style: TextStyle(
                  color: Colors.black38,
                )
            )
        )
    );
  }
}

class GoToSignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40.0,
      margin: EdgeInsets.only(top: 30.0),
      padding: EdgeInsets.symmetric(horizontal:20.0),
      child: RaisedButton(
        onPressed:  (){
          Navigator.push(context,
            MaterialPageRoute(builder: (context) => SignUpPage()),
          );
        },
        color: Color(0xff14a76c),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        child:Text("Sign Up", style: TextStyle(color: Colors.white70)),
      ),
    );
  }
}

