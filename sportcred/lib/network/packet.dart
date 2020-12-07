import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:sportcred/sign_in/auth.dart';
import 'package:sportcred/util/util.dart';

class Packet {
  String auth;
  final Map<String, dynamic> fields;
  final Map<String, List<String>> files;
  final String endPoint;

  Map<String, dynamic> responseBody;
  bool isSuccessful;

  Packet({
    @required this.fields,
    this.files,
    this.auth = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJpZCI6MX0.p19yi39nBEifh4WFyk3YMfYWxzBHzNf6k1z3f8rhgLE",
    @required this.endPoint
  });

  Future<void> get() async {
    Dio dio = Dio();
    // dio.options.headers['Authorization'] = auth;
    dio.options.headers['Authorization'] = Auth.instance.accessToken;
    Response response = await dio.get(
      getEndpoint(endPoint),
      queryParameters: fields
    );
    isSuccessful = response.statusCode == 200;
    responseBody = response.data;
    // print(response.data);
  }

  Future<void> post({bool getBody = false}) async {

    Dio dio = Dio();
    // dio.options.headers['Authorization'] = auth;
    dio.options.headers['Authorization'] = Auth.instance.accessToken;
    FormData formData = FormData.fromMap({
      'data': jsonEncode(fields)
    });
    if (files != null) {
      for (var entry in files.keys) {
        for (var f in files[entry]) {
          formData.files.addAll([
            MapEntry(entry, await MultipartFile.fromFile(f))
          ]);
        }
      }
    }
    try {
      Response response = await dio.post(getEndpoint(endPoint), data: formData);
      isSuccessful = response.statusCode == 200;
      if (getBody)
        responseBody = response.data;
    } catch (e) {
      print('POST ${getEndpoint(endPoint)}');
    }
  }

  Future<void> put({bool getBody = false}) async {

    Dio dio = Dio();
    // dio.options.headers['Authorization'] = auth;
    dio.options.headers['Authorization'] = Auth.instance.accessToken;
    FormData formData = FormData.fromMap({
      'data': jsonEncode(fields)
    });
    if (files != null) {
      for (var entry in files.keys) {
        for (var f in files[entry]) {
          formData.files.addAll([
            MapEntry(entry, await MultipartFile.fromFile(f))
          ]);
        }
      }
    }
    Response response = await dio.put(getEndpoint(endPoint), data: formData);
    isSuccessful = response.statusCode == 200;
    if (getBody)
      responseBody = response.data;
  }

  Future<void> delete() async {
    Dio dio = Dio();
    dio.options.headers['Authorization'] = Auth.instance.accessToken;
    try {
      Response response = await dio.delete(
          getEndpoint(endPoint)
      );
      isSuccessful = response.statusCode == 200;
    } catch (e) {
      print('DELETE ${getEndpoint(endPoint)}');
    }
  }

  bool get isSuccess => isSuccessful;
  Map<String, dynamic> get body => responseBody;
}
