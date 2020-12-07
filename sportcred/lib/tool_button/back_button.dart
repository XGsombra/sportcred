import 'package:flutter/material.dart';

class GoBackButton extends StatelessWidget {

  final String str;
  GoBackButton(this.str);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width *0.49,
      height: 40.0,
      padding: EdgeInsets.only(left: 40, right:5),

      child: RaisedButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.arrow_back_ios, color: Colors.white70,),
              Text(str, style: TextStyle(color: Colors.white70),)
            ]
          ),
          onPressed: (){
          Navigator.of(context).pop(true);
          },
          color: Color(0xffff652b),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0),)
        ),
    );
  }
}
