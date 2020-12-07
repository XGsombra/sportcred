import 'package:sportcred/network/packet.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth {
  int userId;
  String accessToken;

  static final Auth _instance = Auth._internal();

  Auth._internal();

  static Auth get instance => _instance;

  getAuth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString("accessToken");
    userId = prefs.getInt("userId");
  }
}
