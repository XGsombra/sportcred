// Copyright 2019 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'dart:async';
import 'dart:collection';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:sportcred/sign_in/sign_in_page.dart';
import 'package:sportcred/network/packet.dart';

class PhotoUploadPage extends StatefulWidget {
  PhotoUploadPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _PhotoUploadPageState createState() => _PhotoUploadPageState();
}

class _PhotoUploadPageState extends State<PhotoUploadPage> {
  PickedFile _imageFile;
  dynamic _pickImageError;


  String _retrieveDataError;
  LinkedHashMap<Widget, File> images = LinkedHashMap();

  final ImagePicker _picker = ImagePicker();



  Widget _previewImage() {
    final Text retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_imageFile != null) {
      if (kIsWeb) {
        // Why network?
        // See https://pub.dev/packages/image_picker#getting-ready-for-the-web-platform
        return Image.network(_imageFile.path);
      } else {
        return Image.file(File(_imageFile.path));
      }
    } else if (_pickImageError != null) {
      return Text(
        'Pick image error: $_pickImageError',
        textAlign: TextAlign.center,
      );
    } else {
      return const Text(
        'You have not yet picked an image.',
        textAlign: TextAlign.center,
      );
    }
  }

  Future<void> retrieveLostData() async {
    final LostData response = await _picker.getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _imageFile = response.file;
      });
    } else {
      _retrieveDataError = response.exception.code;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: !kIsWeb && defaultTargetPlatform == TargetPlatform.android
            ? FutureBuilder<void>(
          future: retrieveLostData(),
          builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return const Text(
                  'You have not yet picked an image.',
                  textAlign: TextAlign.center,
                );
              case ConnectionState.done:
                return _previewImage();
              default:
                if (snapshot.hasError) {
                  return Text(
                    'Pick image/video error: ${snapshot.error}}',
                    textAlign: TextAlign.center,
                  );
                } else {
                  return const Text(
                    'You have not yet picked an image.',
                    textAlign: TextAlign.center,
                  );
                }
            }
          },
        )
            : _previewImage(),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () async {
              try {
                final pickedFile = await _picker.getImage(
                  source: ImageSource.gallery,
                  maxWidth: 400,
                  maxHeight: 400,
                  imageQuality: 100,
                );
                setState(() {
                  _imageFile = pickedFile;
                });
              } catch (e) {
                setState(() {
                  _pickImageError = e;
                });
              }
            },
            heroTag: 'image0',
            tooltip: 'Pick Image from gallery',
            child: const Icon(Icons.photo_library),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: FloatingActionButton(
              onPressed: () async {
                try {
                  final pickedFile = await _picker.getImage(
                    source: ImageSource.camera,
                    maxWidth: 800,
                    maxHeight: 800,
                    imageQuality: 100,
                  );
                  setState(() {
                    _imageFile = pickedFile;
                  });
                } catch (e) {
                  setState(() {
                    _pickImageError = e;
                  });
                }
              },
              heroTag: 'image1',
              tooltip: 'Take a Photo',
              child: const Icon(Icons.camera_alt),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: FloatingActionButton(
              onPressed: () {
                postInfo();
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },

              child: const Icon(Icons.check),
            ),
          ),
        ],
      ),
    );
  }

  postInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      Packet packet = Packet(
          fields: {
            "email": prefs.getString("email"),
            "username": prefs.getString("username"),
            "password": prefs.getString("password"),
            "favoriteSport": prefs.getString("q1"),
            "age": prefs.getString("q2"),
            "wantToKnowSport": prefs.getString("q4"),
            "favoriteSportTeam": prefs.getString("q5"),
            "levelOfSportPlay": prefs.getString("q3")
          },
          files: {"avatar": [_imageFile.path]},
          endPoint: "/user"
      );
      print(prefs.getString("email"));
      print(prefs.getString("username"));
      await packet.post();
      if (packet.isSuccess != null && packet.isSuccess) {
        showDialog(
            context: context,
            builder: (context) {
              Future.delayed(Duration(seconds: 5), () {
                Navigator.of(context).pop(true);
              });
              return AlertDialog(
                title: Text('Title'),
              );
            }
        );

        Navigator.push(context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      }
    }
    catch (e) {
      print(e);
      if(_imageFile==null){
        showDialog(context: context, builder: (context) {
          return AlertDialog(
            title: Text("Please upload your avatar"),
            actions: <Widget>[
              FlatButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }
              )
            ],
          );
        });
      }
    }
  }

  Text _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }
}