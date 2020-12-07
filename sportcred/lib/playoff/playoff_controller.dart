import 'package:flutter/material.dart';
import 'package:sportcred/network/RestConnectionError.dart';
import 'package:sportcred/network/packet.dart';
import 'package:sportcred/sign_in/auth.dart';

class PlayoffController {
  static final PlayoffController _instance = PlayoffController._internal();

  PlayoffController._internal();

  static PlayoffController get instance => _instance;

  Future<List> getGames() async {
    Packet packet = Packet(
      fields: {},
      files: {},
      auth: Auth.instance.accessToken,
      endPoint: "/pick-prediction/topic?type=playoff"
    );
    await packet.get();
    if(!packet.isSuccess) {
      throw RestConnectionError();
    }
    return packet.responseBody["pickPredictions"];
  }
}