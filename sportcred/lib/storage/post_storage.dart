import 'dart:collection';

import 'package:shared_preferences/shared_preferences.dart';

class PostStorage {

  static final String updateTimeKey = 'pid_last_update_time';
  static final String pidKey = 'pid';

  List<String> pidList;

  PostStorage._internal();

  static final PostStorage _instance = PostStorage._internal();

  static PostStorage get instance => _instance;
  List<String> get pid => pidList;

  Future<void> updatePid(List<String> newPid) async {

    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (!preferences.containsKey(pidKey)) {
      preferences.setStringList(pidKey, []);
    }

    if (pidList == null) {
      pidList = preferences.getStringList('pid');
    }

    pidList.addAll(newPid);
    pidList = LinkedHashSet<String>.from(pidList).toList();
    preferences.setStringList(pidKey, pidList);
    preferences.setInt(updateTimeKey, 0);
    // clearData();
    // preferences.clear();
  }

  Future<void> clearData() async {
    await (await SharedPreferences.getInstance()).setStringList(pidKey, []);
  }

  Future<int> get pidLastUpdateTime async {
    if (!(await SharedPreferences.getInstance()).containsKey(updateTimeKey)) {
      (await SharedPreferences.getInstance()).setInt(updateTimeKey, 0);
    }
    return (await SharedPreferences.getInstance()).getInt(updateTimeKey);
  }

  Future<void> updatePidLastUpdateTime() async {
    (await SharedPreferences.getInstance()).setInt(updateTimeKey, 0);
  }
}