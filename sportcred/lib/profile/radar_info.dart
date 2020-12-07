import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sportcred/profile/profile.dart';
import 'package:sportcred/util/util.dart';

class RadarInfo {
  final int uid;
  final String avatarUrl;
  final String name;
  final double acsPoint;

  RadarInfo(this.uid, this.avatarUrl, this.name, this.acsPoint);
}

class RadarCards extends StatelessWidget {
  final RadarInfo radarinfo;
  RadarCards({
    Key key,
    @required this.radarinfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListTile(
      title: Text(
        radarinfo.name,
        style: TextStyle(fontStyle: FontStyle.italic, fontSize: 19),
      ),
      leading: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProfilePage(
                      self: false,
                      userId: this.radarinfo.uid,
                    )),
          );
        },
        child: CircleAvatar(
          backgroundImage: NetworkImage(getImageEndpoint(radarinfo.avatarUrl)),
        ),
      ),
      trailing: Text(
        "AcsPoints : ${this.radarinfo.acsPoint}",
        style: TextStyle(fontWeight: FontWeight.w500),
      ),
    );
  }
}
