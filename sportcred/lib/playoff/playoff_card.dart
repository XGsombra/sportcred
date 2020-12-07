import 'package:flutter/material.dart';
import 'package:sportcred/util/util.dart';




class PlayoffCard extends StatefulWidget {
  final String teamName;
  final String logoURI;

  PlayoffCard({
    Key key,
    @required this.teamName,
    @required this.logoURI,
  }): super(key: key);

  @override
  _PlayoffCardState createState() => _PlayoffCardState();
}

class _PlayoffCardState extends State<PlayoffCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width / 8 / 0.618,
      width: MediaQuery.of(context).size.width / 10,
      child: Column(
        children: [
          CircleAvatar(
            backgroundImage: widget.logoURI == "" ? null : NetworkImage(getImageEndpoint(widget.logoURI)),
            radius: MediaQuery.of(context).size.width / 10 / 2-1,
            backgroundColor: Colors.transparent,
          ),
          Text(widget.teamName),
        ],
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black38, width: 1)
      ),
    );
  }
}
