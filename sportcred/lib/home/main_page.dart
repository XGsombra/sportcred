import 'package:flutter/material.dart';
import 'package:sportcred/cache/cache.dart';
import 'package:sportcred/home/sc_app_bar.dart';
import 'package:sportcred/home/zone_page.dart';
import 'package:sportcred/profile/profile.dart';
import 'package:sportcred/sc_widget/score_ticker.dart';
import 'package:sportcred/util/mock_widgets.dart';
import 'package:sportcred/util/util.dart';

class MainPage extends StatefulWidget {
  @override
  MainPageState createState() => MainPageState();
}

const List<String> popUpMenu = ['Logout'];

class MainPageState extends State<MainPage> {
  List<Widget> pages;
  int curIdx = 0;
  bool canBeClosed = false;
  Map<String, Function> popUpMenuFunc;

  @override
  initState() {
    popUpMenuFunc = {
      'Logout': () {
        setState(() {
          canBeClosed = true;
        });
        PostPreviewCache.instance.clear();
        Navigator.pop(context);
      },
    };
    pages = [
      ZonePage(),
      ProfilePage(self: true, isWindow: false),
      WidgetsPage()
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return canBeClosed;
        },
        child: DefaultTabController(
            length: 3,
            child: Scaffold(
              appBar: AppBar(
                title: Text('SportCred',
                    style: TextStyle(fontFamily: 'AmazonEmber')),
                automaticallyImplyLeading: false,
                centerTitle: true,
                actions: [
                  PopupMenuButton(
                    onSelected: (value) {
                      popUpMenuFunc[value].call();
                    },
                    itemBuilder: (BuildContext context) {
                      return popUpMenu.map((String choice) {
                        return PopupMenuItem<String>(
                          value: choice,
                          child: Text(choice,
                              style: TextStyle(fontFamily: 'AmazonEmber')),
                        );
                      }).toList();
                    },
                    icon: Icon(Icons.more_vert),
                  )
                ],
                bottom: TabBar(
                  labelStyle: TextStyle(fontFamily: 'AmazonEmber'),
                  tabs: [
                    Tab(
                      text: 'The Zone',
                    ),
                    Tab(text: 'Profile'),
                    Tab(
                      text: 'Live',
                    )
                  ],
                ),
              ),
              // drawer: SCDrawer(),
              body: TabBarView(
                children: pages,
              ),
            )));
  }
}

class WidgetsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ScoreTicker(),
        Text(""),
      ],
    );
  }
}
