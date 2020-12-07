import 'package:flutter/cupertino.dart';
import 'package:sportcred/network/packet.dart';
import 'package:sportcred/post/sub_comment_card.dart';

import 'RestConnectionError.dart';

class SubCommentRestDriver {
  static final SubCommentRestDriver _instance = SubCommentRestDriver._internal();

  SubCommentRestDriver._internal();

  static SubCommentRestDriver get instance => _instance;

  Future<void> submitSubComment(int commentId, String content, int commentToUserId) async {
    Packet packet = Packet(
        fields: {
          'commentId': commentId,
          'content': content,
          'commentToUserId': commentToUserId
        },
        endPoint: '/open-court/subcomment'
    );
    await packet.post();
    if (!packet.isSuccess) {
      throw RestConnectionError();
    }
  }

  Future<List<SubCommentInfo>> getSubComment(int commentId) async {
    Packet packet = Packet(
      fields: {
        'commentId': commentId
      },
      endPoint: '/open-court/subcomment'
    );
    await packet.get();
    if (!packet.isSuccess) {
      throw RestConnectionError();
    }
    
    return List.from(packet.body['subcomments']).map((e) {
      return SubCommentInfo(
        id: e['id'],
        commentId: e['commentId'],
        userId: e['userId'],
        commentToUserId: e['commentToUserId'],
        content: e['content'],
        createdTime: e['createdTime'],
        likeCount: e['likeCount'],
        liked: e['liked'] == 'liked'
      );
    }).toList();
  }
}