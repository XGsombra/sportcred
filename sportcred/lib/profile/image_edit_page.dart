import 'package:flutter/material.dart';
import 'package:sportcred/network/packet.dart';
import 'package:sportcred/network/profile_friend_rest_driver.dart';
import 'package:sportcred/sign_in//auth.dart';
import 'package:sportcred/util/util.dart';

class ImageEditPage extends StatefulWidget {
  final int uid;

  ImageEditPage(@required this.uid);

  @override
  _ImageEditPageState createState() => _ImageEditPageState();
}

class _ImageEditPageState extends State<ImageEditPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // FlatButton(onPressed: () {  },
          // child: Text('asd'),)
        ],
      ),
    );
  }
}
