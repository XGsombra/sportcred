import 'package:flutter_test/flutter_test.dart';
import 'package:sportcred/network/sub_comment_rest_driver.dart';

void main() {
  test('Test Get Sub-comment', () async {
    for (var it in (await SubCommentRestDriver.instance.getSubComment(1))) {
      print(it.commentId);
      print(it.content);
      print(it.userId);
      print(it.id);
    }
  });
}