import 'dart:isolate';

import 'package:flutter/cupertino.dart';
import 'package:sportcred/network/packet.dart';
import 'package:sportcred/network/RestConnectionError.dart';
import 'package:sportcred/sign_in/auth.dart';


class PickController {
  static final PickController _instance = PickController._internal();

  PickController._internal();

  static PickController get instance => _instance;

  Future<List> getPickInfo(String type) async {
    Packet packet = Packet(
      auth: Auth.instance.accessToken,
      endPoint: '/pick-prediction/topic?type=' + type
    );
    await packet.get();
    if (!packet.isSuccess) {
      throw RestConnectionError();
    }
    return packet.responseBody["pickPredictions"];
  }

  Future<void> postSelection(int id, int answerIndex) async {
    Packet packet = Packet(
      fields: {
        "answerIndex": answerIndex
      },
      files: {},
      auth: Auth.instance.accessToken,
      endPoint: "/pick-prediction/topic/$id/user-answer"
    );
    await packet.post();
    if (!packet.isSuccess) {
      throw RestConnectionError();
    }
  }

  Future<List> getPicks (String accessToken) async {
    Packet packet = Packet(
      fields: {},
      files: {},
      endPoint: "/pick-prediction/pick",
      auth: accessToken,
    );
    await packet.get();
    if (!packet.isSuccess) {
      throw RestConnectionError();
    }
    return packet.responseBody["pickPredictionTopicList"];
  }

  Future<List> getPredictions (String accessToken) async {
    Packet packet = Packet(
      fields: {},
      files: {},
      endPoint: "/pick-prediction/predictions",
      auth: accessToken,
    );
    await packet.get();
    if (!packet.isSuccess) {
      throw RestConnectionError();
    }
    return packet.responseBody["pickPredictionTopicList"];
  }

  Future<Map> getCount(int ppid) async {
    Packet packet = Packet(
      fields: {
        "ppid": ppid
      },
      files: {},
      endPoint: "/pick-prediction/user/count/$ppid",
    );
    await packet.get();
    if (!packet.isSuccess) throw RestConnectionError();
    return packet.responseBody;

  }

  Future<String> getAnswer(int ppid) async {
    Packet packet = Packet(
      fields: {
        "ppid": ppid
      },
      files: {},
      endPoint: "/pick-prediction/user/answer"
    );
    await packet.get();
    if (!packet.isSuccess) throw RestConnectionError();
    return packet.responseBody["answer"];
  }


}