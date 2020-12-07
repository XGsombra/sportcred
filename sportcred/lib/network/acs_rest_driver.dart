import 'package:sportcred/network/RestConnectionError.dart';
import 'package:sportcred/network/packet.dart';
import 'package:sportcred/profile/acs_page.dart';
import 'package:sportcred/util/util.dart';

class ACSRestDriver {
  static final ACSRestDriver _instance = ACSRestDriver._internal();

  ACSRestDriver._internal();

  static ACSRestDriver get instance => _instance;

  Future<ACSInfoList> getACSInfoListAll(int uid, String path) async {
    Packet packet =
        Packet(fields: {}, endPoint: '/user/$uid/acs-history?module=$path');

    await packet.get();
    if (!packet.isSuccess) {
      throw RestConnectionError();
    }

    // print(packet.body);

    return ACSInfoList(packet.body['acsHistory']);
  }
}
