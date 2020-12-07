import 'package:flutter/material.dart';
import 'package:sportcred/util/util.dart';

Future<bool> showActionAlertDialog(String message, BuildContext context, {String yes = 'Continue', String no = 'Cancel'}) async {
  return (await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: amazonize('Warning'),
        content: amazonize(message),
        actions: <Widget>[
          new FlatButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop(false); // dismisses only the dialog and returns false
            },
            child: amazonize(no),
          ),
          FlatButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop(true); // dismisses only the dialog and returns true
            },
            child: amazonize(yes),
          ),
        ],
      );
    },
  )) ?? false;
}