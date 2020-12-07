import 'package:flutter/material.dart';

class ScoreTicker extends StatefulWidget {
  final Duration animationDuration, backDuration;

  ScoreTicker({
    this.animationDuration: const Duration(milliseconds: 16000),
    this.backDuration: const Duration(milliseconds: 1),
  });

  @override
  _ScoreTickerState createState() => _ScoreTickerState();
}

class _ScoreTickerState extends State<ScoreTicker> {
  ScrollController scrollController;
  List<ScoreTickerMatch> matches;

  @override
  void initState() {
    scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback(scroll);
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Row(
        children: [
          ScoreTickerMatch(
            ScoreTickerSymbol.nba,
            "Denver",
            "97",
            ScoreTickerStatus.fourth,
            "108",
            "Utah",
          ),
          ScoreTickerMatch(
            ScoreTickerSymbol.nba,
            "Magic",
            "-",
            ScoreTickerStatus("DEC 11", "7 pm."),
            "-",
            "Hawks",
          ),
          ScoreTickerMatch(
            ScoreTickerSymbol.nba,
            "Knicks",
            "-",
            ScoreTickerStatus("DEC 11", "7 pm."),
            "-",
            "Pistons",
          ),
          ScoreTickerMatch(
            ScoreTickerSymbol.nba,
            "Rockets",
            "-",
            ScoreTickerStatus("DEC 11", "8 pm."),
            "-",
            "Bulls",
          ),
          ScoreTickerMatch(
            ScoreTickerSymbol.nba,
            "Denver",
            "97",
            ScoreTickerStatus.fourth,
            "108",
            "Utah",
          ),
        ],
      ),
      scrollDirection: Axis.horizontal,
      controller: scrollController,
    );
  }

  void scroll(_) async {
    while (scrollController.hasClients) {
      await Future.delayed(Duration(milliseconds: 1));
      if (scrollController.hasClients)
        await scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: widget.animationDuration,
          curve: Curves.linear,
        );
      await Future.delayed(Duration(milliseconds: 1));
      if (scrollController.hasClients)
        await scrollController.animateTo(
          0.0,
          duration: widget.backDuration,
          curve: Curves.linear,
        );
    }
  }
}

class ScoreTickerSymbol extends StatelessWidget {
  final Icon icon;
  final Text text;
  static const ScoreTickerSymbol nba = ScoreTickerSymbol(
    Icon(Icons.sports_basketball),
    Text(
      "NBA",
    ),
  );

  const ScoreTickerSymbol(this.icon, this.text);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        icon,
        Center(child: text),
      ],
    );
  }
}

class ScoreTickerStatus extends StatelessWidget {
  final String status;
  final String subStatus;

  static const fourth = ScoreTickerStatus("4th", "12:34");
  ScoreTickerStatus.future(String subS)
      : status = "EST.",
        this.subStatus = subS;

  const ScoreTickerStatus(
    this.status,
    this.subStatus,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          status,
          style: TextStyle(
            fontSize: 20,
            color: Colors.orange[700],
          ),
        ),
        Text(
          subStatus,
          style: TextStyle(
            fontSize: 12,
            color: Colors.green[400],
          ),
        ),
      ],
    );
  }
}

class ScoreTickerMatch extends StatelessWidget {
  final ScoreTickerSymbol symbol;
  final String home;
  final String away;
  final ScoreTickerStatus status;
  final String homeScore;
  final String awayScore;
  ScoreTickerMatch(
    this.symbol,
    this.home,
    this.homeScore,
    this.status,
    this.awayScore,
    this.away,
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(20),
      //decoration: ,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          symbol,
          Center(
            child: Text(
              home,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 24,
              ),
            ),
          ),
          Center(
            child: Text(
              homeScore.toString(),
              style: TextStyle(
                color: Colors.red[800],
                fontSize: 24,
              ),
            ),
          ),
          Center(
            child: status,
          ),
          Center(
            child: Text(
              awayScore.toString(),
              style: TextStyle(
                color: Colors.red[800],
                fontSize: 24,
              ),
            ),
          ),
          Center(
            child: Text(
              away,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
