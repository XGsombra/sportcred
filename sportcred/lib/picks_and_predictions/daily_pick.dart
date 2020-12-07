import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportcred/network/packet.dart';
import 'package:sportcred/picks_and_predictions/pick_card.dart';
import 'pick_controller.dart';


class DailyPickPage extends StatefulWidget {
  final List pickInfo;

  DailyPickPage({
    @required this.pickInfo
  });
  @override
  _DailyPickPageState createState() => _DailyPickPageState();
}

class _DailyPickPageState extends State<DailyPickPage> {
  final ScrollController controller = ScrollController();
  SharedPreferences prefs;

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Colors.white,
          child: Scrollbar(
            controller: controller,
            child: ListView.separated(
              controller: controller,
              itemCount: widget.pickInfo.length,
              itemBuilder: (context, index) {
                return PickCard(
                    pickInfo: widget.pickInfo[index]);
              },
              separatorBuilder: (context, index) => Divider(),
            ),
          )
      ),
    );
  }
}