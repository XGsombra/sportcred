import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportcred/network/packet.dart';
import 'package:sportcred/picks_and_predictions/prediction_card.dart';


class PredictionPage extends StatefulWidget {
  final List predictionInfo;

  PredictionPage({
    Key key,
    @required this.predictionInfo,
  }): super(key: key);


  @override
  _PredictionPageState createState() => _PredictionPageState();
}

class _PredictionPageState extends State<PredictionPage> {

  final ScrollController controller = ScrollController();

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
              itemCount: widget.predictionInfo.length,
              itemBuilder: (context, index) {
                return PredictionCard(
                  pickInfo: widget.predictionInfo[index]);
                },
              separatorBuilder: (context, index) => Divider(),
            ),
          )
      ),
    );
  }
}


//
// List<PredictionInfo> card = [
//   PredictionInfo(
//       predictionId: 1,
//       title: "Who will be 2019-2020 NBA MVP",
//       choice1: "Giannis Antetokounmpo",
//       choice2: "LeBron James",
//       choice3: "James Harden",
//       choice4: "Damian Lillard",
//       choice1Count: 0,
//       choice2Count: 0,
//       choice3Count: 0,
//       choice4Count: 0,
//       totalCount: 0,
//       voted: false,
//       choiceSelected: 0,
//       result: 1,
//       deadline: DateTime(2020, 11, 17, 11, 59, 59)
//   ),
//   PredictionInfo(
//       predictionId: 2,
//       title: "Who will be 2019-2020 NBA Rookie Of the Year",
//       choice1: "Ja Morant",
//       choice2: "Kendrick Nunn",
//       choice3: "Brandon Clarke",
//       choice4: "Zion Williamson",
//       choice1Count: 0,
//       choice2Count: 0,
//       choice3Count: 0,
//       choice4Count: 0,
//       totalCount: 0,
//       voted: false,
//       choiceSelected: 0,
//       result: 1,
//       deadline: DateTime(2020, 11, 17, 11, 59, 59)
//   ),
// ];