import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportcred/network/RestConnectionError.dart';
import 'package:sportcred/profile/profile_factory.dart';
import 'package:sportcred/sign_in/auth.dart';

import 'packet.dart';

Future<Profile> loadJsonProfile(int userId) async {
  String token = Auth.instance.accessToken;
  int userIdSelf = Auth.instance.userId;
  Packet packet = Packet(
      fields: {},
      endPoint: '/user/${userId == -1 ? userIdSelf : userId}/profile',
      auth: token);
  await packet.get();

  if (packet.isSuccess) {
    return Profile.fromJson(packet.body);
  } else {
    throw RestConnectionError();
  }
}
