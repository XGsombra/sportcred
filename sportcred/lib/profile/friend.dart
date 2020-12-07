import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sportcred/profile/radar_info.dart';
import 'package:sportcred/network/profile_friend_rest_driver.dart';
import 'package:sportcred/profile/profile_factory.dart';

class FriendView extends StatefulWidget {
  final Profile profile;
  const FriendView({Key key, this.profile}) : super(key: key);
  @override
  _FriendViewState createState() => _FriendViewState();
}

class _FriendViewState extends State<FriendView> {
  @override
  void initState() {
    super.initState();
    futureradarInfos = ProfileRestDriver.instance.getRadarInfo();
  }

  Future<List<RadarInfo>> futureradarInfos;
  List<int> radar;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Radar"),
        ),
        body: FutureBuilder(
            future: futureradarInfos,
            builder: (context, AsyncSnapshot<List<RadarInfo>> snapshot) {
              List<RadarInfo> radarInfos;
              if (snapshot.hasData) {
                radarInfos = snapshot.data;
                return ListView.builder(
                    itemCount: radarInfos.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(children: <Widget>[
                        RadarCards(radarinfo: radarInfos[index]),
                        Divider(
                          color: Colors.grey.withOpacity(0.3),
                          thickness: 2,
                        )
                      ]);
                    });
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}
