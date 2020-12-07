import 'package:flutter/material.dart';
import 'package:sportcred/network/packet.dart';
import 'package:sportcred/network/profile_friend_rest_driver.dart';
import 'package:sportcred/sign_in//auth.dart';
import 'package:sportcred/util/util.dart';

class ProfileEditPage extends StatefulWidget {
  final String entry;
  final String field;
  final String oldValue;

  ProfileEditPage(
      {@required this.entry, @required this.oldValue, @required this.field});

  @override
  _ProfileEditPageState createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  final controller = TextEditingController();
  final focusNode = FocusNode();

  @override
  void initState() {
    controller.text = widget.oldValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: amazonize(widget.entry),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () async {
              try {
                await ProfileRestDriver.instance.putProfileUpdate(widget.field, controller.text);
                Navigator.of(context).pop(controller.text);
              } catch (e) {
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text('update failed'),
                ));
              }
            },
          )
        ],
      ),
      body: Column(
        children: [
          ListTile(
            title: TextField(
              autofocus: true,
              keyboardType: TextInputType.text,
              controller: controller,
              focusNode: focusNode,
              style: TextStyle(
                  color: Colors.black, fontSize: 18, fontFamily: 'AmazonEmber'),
              decoration: InputDecoration(
                hintText: "Enter your new attribute",
                // fillColor: Colors.grey,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                border: InputBorder.none,
              ),
              maxLines: 2,
            ),
          ),
          Divider()
          // FlatButton(onPressed: () {  },
          // child: Text('asd'),)
        ],
      ),
    );
  }
}
