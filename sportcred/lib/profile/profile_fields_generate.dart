import 'package:flutter/cupertino.dart';


Widget buildFields(String fields, String ans,TextStyle _q, TextStyle _a){
  return Row(
    children: <Widget>[
      Expanded(
        child: Container(
          margin: EdgeInsets.only(
            left: 20,
          ),
          child: Text(fields,

              style: _q),
        ),
      ),
      Expanded(
        child: Container(
          margin: EdgeInsets.only(right: 20),
          child: Text(
            ans,
            style: _a,
            textAlign: TextAlign.end,
          ),
        ),
      ),
    ],
  );
}