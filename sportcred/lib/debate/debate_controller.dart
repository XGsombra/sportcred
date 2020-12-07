import 'package:sportcred/debate/article_card.dart';
import 'package:sportcred/network/RestConnectionError.dart';
import 'package:sportcred/network/packet.dart';

class DebateController {
  static final DebateController _instance = DebateController._internal();

  DebateController._internal();

  static DebateController get instance => _instance;

  Future<Map> getTopics(String accessToken) async {
    Packet packet = Packet(
      fields: {},
      files: {},
      endPoint: "/debate-and-analyze/home",
      auth: accessToken,
    );
    await packet.get();
    if (!packet.isSuccess){
      throw RestConnectionError();
    }
    return packet.responseBody;
  }

  Future<ArticleInfo> getPost(int postId) async {
    Packet packet = Packet (
      fields: {"postId": postId},
      files: {},
      endPoint: "/debate-and-analyze/post/$postId",
    );
    await packet.get();
    if(!packet.isSuccess){
      throw RestConnectionError();
    }
    return ArticleInfo(
        pid: packet.responseBody["postId"],
        uid: packet.responseBody["userId"],
        topicId: packet.responseBody["topicId"],
        content: packet.responseBody["content"],
        agreeRate: packet.responseBody["agreeRate"],
        rateCount: packet.responseBody["rateCount"],
        userAgreeRate: packet.responseBody["userAgreeRate"],
        topic: packet.responseBody["topic"],
        tier: packet.responseBody["tier"],
        createTime: packet.responseBody["createdTime"],
        pictures: packet.responseBody["pictures"]
    );
  }

  Future<ArticleInfo> getRandomArticle(int topicId, String accessToken) async {
    try{
      Packet packet = Packet(
          fields: {"topicId": topicId},
          files: {},
          auth: accessToken,
          endPoint: "/debate-and-analyze/random-post?topicId=$topicId"
      );
      await packet.get();
      return ArticleInfo(
          pid: packet.responseBody["postId"],
          uid: packet.responseBody["userId"],
          topicId: topicId,
          content: packet.responseBody["content"],
          agreeRate: packet.responseBody["agreeRate"],
          rateCount: packet.responseBody["rateCount"],
          userAgreeRate: packet.responseBody["userAgreeRate"],
          topic: packet.responseBody["topic"],
          tier: packet.responseBody["tier"],
          createTime: packet.responseBody["createdTime"],
          pictures: packet.responseBody["pictures"]
      );
    }
    catch (e) {
      return ArticleInfo(pid: 0, uid: 0, topicId: 0, content: "", agreeRate: "", rateCount: 0, userAgreeRate: 0, topic: "", tier: "", createTime: 0, pictures: null);
    }
  }

  Future<void> postAgreeRate (int agreeRate, int postId, String accessToken) async {
    Packet packet = Packet(
      fields: {
        "agreeRate": agreeRate
      },
      auth: accessToken,
      endPoint: "/debate-and-analyze/post/$postId/agree-rate");
    await packet.post();
    if (!packet.isSuccess) {
      throw RestConnectionError();
    }
  }

  Future<List> getUserPostIds(int userId, String accessToken) async {
    Packet packet = Packet(
      fields: {},
      files: {},
      endPoint: "/debate-and-analyze/post?userId=$userId",
      auth: accessToken,
    );
    await packet.get();
    if (!packet.isSuccess){
      throw RestConnectionError();
    }
    return packet.responseBody["postIds"];
  }
}