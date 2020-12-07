import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sportcred/network/packet.dart';
import 'package:sportcred/profile/radar_info.dart';
import 'package:sportcred/profile/profile_factory.dart';
import 'package:sportcred/sign_in/auth.dart';

import 'RestConnectionError.dart';

class ProfileInfo {
  final String username;
  final String email;
  final String favoriteSport;
  final int age;
  final String wantToKnowSport;
  final String favoriteSportTeam;
  final String levelOfSportPlay;
  final String avatarUrl;

  ProfileInfo(
      {@required this.username,
      @required this.email,
      @required this.favoriteSport,
      @required this.age,
      @required this.wantToKnowSport,
      @required this.favoriteSportTeam,
      @required this.levelOfSportPlay,
      @required this.avatarUrl});
}

class ProfileRestDriver {
  static final ProfileRestDriver _instance = ProfileRestDriver._internal();

  ProfileRestDriver._internal();

  static ProfileRestDriver get instance => _instance;

  Future<ProfileInfo> getProfile(int uid) async {
    Packet packet = Packet(fields: {}, endPoint: '/user/$uid/profile/');
    await packet.get();
    if (!packet.isSuccess) {
      throw RestConnectionError();
    }
    var t = ProfileInfo(
        username: packet.responseBody['username'],
        email: packet.responseBody['email'],
        favoriteSport: packet.responseBody['favoriteSport'],
        age: packet.responseBody['age'],
        wantToKnowSport: packet.responseBody['wantToKnowSport'],
        favoriteSportTeam: packet.responseBody['favoriteSportTeam'],
        levelOfSportPlay: packet.responseBody['levelOfSportPlay'],
        avatarUrl: packet.responseBody['avatarUrl']);
    return t;
  }

  Future<List<RadarInfo>> getRadarInfo() async {
    List<int> uids;
    List<RadarInfo> radarInfos = [];
    Packet packet;
    String token = Auth.instance.accessToken;
    int userId = Auth.instance.userId;
    packet =
        Packet(fields: {}, endPoint: '/user/$userId/followed', auth: token);
    await packet.get();
    if (!packet.isSuccess) {
      throw RestConnectionError();
    }
    uids = packet.body['userList'].cast<int>();
    for (int i = 0; i < uids.length; i++) {
      packet =
          Packet(fields: {}, endPoint: '/user/${uids[i]}/profile', auth: token);
      await packet.get();
      if (!packet.isSuccess) {
        throw RestConnectionError();
      }
      var t = RadarInfo(uids[i], packet.body['avatarUrl'],
          packet.body['username'], double.parse(packet.body['acsPoint']));
      radarInfos.add(t);
    }
    radarInfos.sort((b, a) {
      return a.acsPoint.compareTo(b.acsPoint);
    });
    return radarInfos;
  }

  Future<dynamic> postFollow(int userId) async {
    String token = Auth.instance.accessToken;
    Packet packet;
    packet = Packet(fields: {}, endPoint: '/user/$userId/follow', auth: token);
    await packet.post();
    if (!packet.isSuccess) {
      throw RestConnectionError();
    }
  }

  Future<dynamic> deleteFollow(int userId) async {
    String token = Auth.instance.accessToken;
    Packet packet;
    packet = Packet(fields: {}, endPoint: '/user/$userId/follow', auth: token);
    await packet.delete();
    if (!packet.isSuccess) {
      throw RestConnectionError();
    }
  }

  Future<dynamic> putProfileUpdate(String field, String value) async {
    Packet packet;
    int userId = Auth.instance.userId;
    String token = Auth.instance.accessToken;
    packet = Packet(
        fields: {field: value}, endPoint: '/user/$userId/profile', auth: token);
    await packet.put();
    if (!packet.isSuccess) {
      throw RestConnectionError();
    }
  }

  Future<dynamic> putProfile(Profile profile) async {
    int userId = Auth.instance.userId;
    String token = Auth.instance.accessToken;
    Packet packet = Packet(fields: {
      'favoriteSport': profile.favSport,
      'age': profile.age,
      'bio': profile.bio,
      'wantToKnowSport': profile.wantToKnowSport,
      'favoriteSportTeam': profile.favoriteSportTeam,
      'levelOfSportPlay': profile.levelOfSportPlay,
    }, endPoint: '/user/$userId/profile', auth: token);
    await packet.put();
    if (!packet.isSuccess) {
      throw RestConnectionError();
    }
  }

  Future<dynamic> putProfileAvatar(String path) async {
    String token = Auth.instance.accessToken;
    int userId = Auth.instance.userId;
    Packet packet = Packet(fields: {}, files: {
      'avatar': [path]
    }, endPoint: '/user/$userId/profile', auth: token);
    await packet.put();
    if (!packet.isSuccess) {
      throw RestConnectionError();
    }
  }
}
