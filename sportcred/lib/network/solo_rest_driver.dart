import 'package:sportcred/network/packet.dart';
import 'package:sportcred/trivia/solo.dart';

import 'RestConnectionError.dart';

class SoloRestDriver {
  static final SoloRestDriver _instance = SoloRestDriver._internal();

  SoloRestDriver._internal();

  static SoloRestDriver get instance => _instance;

  Future<TriviaQuestionList> getTriviaQuestionList() async {
    Packet packet = Packet(
        fields: {},
        endPoint: '/trivia/solo/question-set'
    );
    await packet.get();
    return  TriviaQuestionList(packet.body);
  }

  Future<void> submitTriviaSoloResult(int points) async {
    Packet packet = Packet(
      fields: {
        'correctAnswerNumber': points
      },
      endPoint: '/trivia/solo/result'
    );
    await packet.post();
    if (!packet.isSuccess) {
      throw RestConnectionError();
    }
  }
}