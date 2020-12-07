import 'package:flutter/material.dart';
import 'package:sportcred/sign_in/sign_in_page.dart';

void main() => runApp(SportCred());

class SportCred extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SportCred',
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: LoginPage());
  }
}
