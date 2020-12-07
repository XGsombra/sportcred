import 'package:sportcred/network/packet.dart';
import 'package:sportcred/trivia/coop.dart';

class CoopRestDriver {
  static final CoopRestDriver _instance = CoopRestDriver._internal();

  CoopRestDriver._internal();

  static CoopRestDriver get instance => _instance;

  Future<CoopRoomInfo> getCoopRoomInfo() async {
    Packet packet = Packet(
        fields: {},
        endPoint: '/trivia/head-to-head/new-match'
    );
    await packet.get();
    return CoopRoomInfo(packet.body);
  }

  Future<void> cancelGameSearching() async {
    Packet packet = Packet(
      fields: {}, endPoint: '/trivia/head-to-head/new-match'
    );
    await packet.delete();
  }
}