import 'dart:convert';

import '../network/packet.dart';

class Profile {
  String bio;
  var joinSince = new DateTime.utc(2018, 9, 13);
  int age;
  String username;
  String avatarUrl;
  String email;
  String favSport;
  String wantToKnowSport;
  String favoriteSportTeam;
  String levelOfSportPlay;
  bool followed;
  double acsPoint;

  Profile(
      {this.age,
      this.bio,
      this.avatarUrl,
      this.username,
      this.followed,
      this.email,
      this.favSport,
      this.wantToKnowSport,
      this.favoriteSportTeam,
      this.levelOfSportPlay,
      this.acsPoint});

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
        username: json['username'],
        email: json['email'],
        avatarUrl: json['avatarUrl'],
        favSport: json['favoriteSport'],
        favoriteSportTeam: json['favoriteSportTeam'],
        wantToKnowSport: json['wantToKnowSport'],
        levelOfSportPlay: json['levelOfSportPlay'],
        bio: json['bio'],
        followed: json['followed'],
        acsPoint: double.parse(json['acsPoint']));
  }
}
