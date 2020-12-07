import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  test('get new post id', () async {
    Dio dio = Dio();
    String jString = jsonEncode({
      "email": "neoclear@outlook.com",
      "username": 'NeoClear',
      "password": '114514',
      'favoriteSport': 'PinPong',
      'age': 20,
      'wantToKnowSport': 'CS',
      'favoriteSportTeam': 'KT',
      'levelOfSportPlay': '0',
      // 'avatar': await MultipartFile.fromFile(, filename: "avatar.jpg")
    });
    FormData formData = FormData.fromMap({
      'data': jString,
      'avatar': await MultipartFile.fromFile("./text.txt", filename: "upload.txt")
    });
    Response response = await dio.post("/user", data: formData);
    print(response.statusCode);
  });

  test('clear cache', () async {
    (await SharedPreferences.getInstance()).clear();
  });
}