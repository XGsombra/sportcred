import 'package:flutter/material.dart';
import 'package:sportcred/util/util.dart';
import 'package:intl/intl.dart';

class ACSInfo {
  final int time;
  final double changeAmount;
  final String moduleName;
  final String description;

  ACSInfo(
      {@required this.time,
      @required this.changeAmount,
      @required this.moduleName,
      @required this.description});
}

class ACSInfoList {
  List<ACSInfo> acsInfoList;
  ACSInfoList(List<dynamic> list) {
    acsInfoList = List();
    for (var it in list) {
      acsInfoList.add(ACSInfo(
          time: it['time'],
          changeAmount: double.parse(it['changeAmount']),
          moduleName: it['module'],
          description: it['description']));
    }
  }
}

class ACSPage extends StatelessWidget {
  final ACSInfoList acsInfoList;

  final TextStyle _textTitle =
      TextStyle(fontWeight: FontWeight.w400, fontSize: 19);

  final TextStyle _textSub = TextStyle(fontSize: 15, fontFamily: 'AmazonEmber');

  final TextStyle _textChanges =
      TextStyle(fontSize: 24, fontFamily: 'AmazonEmber');

  ACSPage({@required this.acsInfoList});

  Widget getACSModuleWidget(ACSInfo info) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Text(info.moduleName, style: _textTitle),
          subtitle: Text(
              info.description +
                  '\n' +
                  '${DateFormat.yMMMEd().format(DateTime.fromMillisecondsSinceEpoch(info.time))}',
              style: _textSub),
          trailing: Text(
              '${info.changeAmount > 0 ? '+' : ''}${info.changeAmount}',
              style: _textChanges),
          isThreeLine: true,
          onTap: () {},
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: amazonize('ACS History'),
          centerTitle: true,
        ),
        body: ListView(
            children: acsInfoList.acsInfoList
                .map((e) => getACSModuleWidget(e))
                .toList()));
  }
}
