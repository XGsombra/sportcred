import 'package:flutter_test/flutter_test.dart';
import 'package:sportcred/storage/post_storage.dart';

void main() {
  test('pid storage without duplication', () async {
    var pidStore = PostStorage.instance;
    await pidStore.clearData();
    await pidStore.updatePid(['1', '2', '3']);
    expect(pidStore.pid, ['1', '2', '3']);
  });

  test('pid storage with duplication', () async {
    var pidStore = PostStorage.instance;
    await pidStore.updatePid(['1', '2', '3']);
    await pidStore.updatePid(['1', '2', '3']);
    expect(pidStore.pid, ['1', '2', '3']);
  });
}