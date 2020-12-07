import 'package:flutter/material.dart';

class FocusController {
  Key _key;

  void releaseFocus() {
    _key = null;
  }

  bool hasFocus(Key key) => _key == key;

  void focus(Key key) {
    _key = key;
  }
}
