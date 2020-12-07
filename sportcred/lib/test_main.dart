import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo',
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainPageState();
  }
}

class MainPageState extends State<MainPage> {
  int _currentIndex;
  List<Widget> _pages;

  List<BottomNavigationBarItem> getItems() {
    return [
      // BottomNavigationBarItem(icon: Icon(Icons.home), label: Text("Home")),
      // BottomNavigationBarItem(icon: Icon(Icons.adb), title: Text("Adb")),
      // BottomNavigationBarItem(icon: Icon(Icons.person), title: Text("Person")),
    ];
  }

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
    _pages = List()
      ..add(TabPage(
        title: "Test abc",
      ))
      ..add(Page2("第二页"))
      ..add(Page3("第三页"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        items: getItems(),
        onTap: onTabTapped,
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

class Page1 extends StatefulWidget {
  String _title;
  Page1(this._title);

  @override
  State<StatefulWidget> createState() {
    return Page1State();
  }
}

class Page1State extends State<Page1> with AutomaticKeepAliveClientMixin {
  int _count = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MaterialButton(
              child: Text(widget._title + ":点一下加1：$_count"),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return NewPage();
                }));
              },
            ),
            MaterialButton(
              child: Text("跳转"),
              color: Colors.pinkAccent,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return NewPage();
                }));
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: widget._title,
        child: Icon(Icons.add),
        onPressed: addAction,
      ),
    );
  }

  void addAction() {
    setState(() {
      _count++;
    });
  }
}

class Page2 extends StatefulWidget {
  String _title;
  Page2(this._title);

  @override
  State<StatefulWidget> createState() {
    return Page2State();
  }
}

class Page2State extends State<Page2> with AutomaticKeepAliveClientMixin {
  int _count = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(widget._title + ":点一下加1：$_count"),
            MaterialButton(
              child: Text("跳转"),
              color: Colors.pinkAccent,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return NewPage();
                }));
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: widget._title,
        child: Icon(Icons.add),
        onPressed: addAction,
      ),
    );
  }

  void addAction() {
    setState(() {
      _count++;
    });
  }
}

class Page3 extends StatefulWidget {
  String _title;
  Page3(this._title);

  @override
  State<StatefulWidget> createState() {
    return Page3State();
  }
}

class Page3State extends State<Page3> with AutomaticKeepAliveClientMixin {
  int _count = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(widget._title + ":点一下加1：$_count"),
            MaterialButton(
              child: Text("跳转"),
              color: Colors.pinkAccent,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return NewPage();
                }));
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: widget._title,
        child: Icon(Icons.add),
        onPressed: addAction,
      ),
    );
  }

  void addAction() {
    setState(() {
      _count++;
    });
  }
}

class NewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("新的界面"),
      ),
      body: Center(
        child: Text("我是一个新的界面"),
      ),
    );
  }
}

class TabPage extends StatefulWidget {
  TabPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  State<StatefulWidget> createState() {
    return TabPageState();
  }
}

class TabPageState extends State<TabPage> {
  List<String> _list = ['111111', '222222', '3333333'];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _list.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text("TabBar Status Test",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white)),
          centerTitle: true,
          bottom: TabBar(
            isScrollable: false,
            tabs: _list.map((String ss) {
              return Tab(text: ss);
            }).toList(),
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Page1('tab-第一页'),
            Page2('tab-第二页'),
            Page3('tab-第三页')
          ],
        ),
      ),
    );
  }
}
