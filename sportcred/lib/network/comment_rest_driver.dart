import 'package:sportcred/network/packet.dart';
import 'package:sportcred/post/comment_body.dart';

import 'RestConnectionError.dart';

class CommentRestDriver {
  static final CommentRestDriver _instance = CommentRestDriver._internal();

  CommentRestDriver._internal();

  static CommentRestDriver get instance => _instance;

  Future<void> submitComment(int pid, String content) async {
    Packet packet = Packet(
      fields: {
          "postId": pid,
          "content": content
      },
      endPoint: '/open-court/comment'
    );
    await packet.post();
    if (!packet.isSuccess) {
      throw RestConnectionError();
    }
  }

  Future<List<CommentInfo>> getComments(int pid) async {
    Packet packet = Packet(
        fields: {
          'postId': pid
        },
        endPoint: '/open-court/comment'
    );
    await packet.get();
    if (!packet.isSuccess) {
      throw RestConnectionError();
    }
    return List.from(packet.body['commentList']).map((e) {
      return CommentInfo(
        cid: e['id'],
        pid: e['postId'],
        commenter: e['userId'],
        content: e['content'],
        time: e['createdTime'],
        likeCount: e['likeCount']
      );
    }).toList();
  }
}