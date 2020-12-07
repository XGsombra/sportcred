import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SampleWindow extends StatelessWidget {
  final String title;
  SampleWindow({this.title});
  @override
  Widget build(BuildContext contest) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title == null ? 'Sample Window' : title),
      ),
    );
  }
}

DecorationImage getDefaultDecorationImage() {
  return DecorationImage(
    image: NetworkImage('http://34.86.3.253:80/openCourtPosts/1/0.jpg'),
    fit: BoxFit.fill
  );
}

DecorationImage getDecorationImage(String uri) {
  return DecorationImage(
      image: NetworkImage(uri),
      fit: BoxFit.fill
  );
}