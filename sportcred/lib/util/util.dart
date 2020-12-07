import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sportcred/post/post_card.dart';

Future<dynamic> navi(BuildContext context, Widget widget) async {
  return await Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

Color getPrimaryColor(BuildContext context) {
  return Theme.of(context).primaryColor;
}

Text amazonize(String s) {
  return Text(s, style: TextStyle(fontFamily: 'AmazonEmber'));
}

String numberToCompactString(int num) {
  List<String> level = [
    '', 'K', 'M', 'B'
  ];
  int id = 0;
  while (num >= 1000) {
    id++;
    num ~/= 1000;
  }
  return num.toString() + level[id];
}

String getEndpoint(String endPoint) {
  return 'http://34.86.3.253:8080' + endPoint;
}

String getImageEndpoint(String endPoint) {
  return 'http://34.86.3.253:80' + endPoint;
}

PostInfo mapToPostInfo(Map<String, dynamic> data) {
  return PostInfo(
    pid: data['postId'],
    uid: data['userId'],
    content: data['content'],
    likeCount: data['likeCount'],
    liked: data['likeCondition'] == 'liked',
    createTime: data['createdTime'],
    pictures: new List<String>.from(data['pictures'])
  );
}