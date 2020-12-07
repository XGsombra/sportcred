import 'package:sportcred/network/RestConnectionError.dart';
import 'package:sportcred/network/packet.dart';
import 'package:sportcred/post/post_card.dart';
import 'package:sportcred/storage/post_storage.dart';
import 'package:sportcred/util/util.dart';

class PostRestDriver {

  static final PostRestDriver _instance = PostRestDriver._internal();

  PostRestDriver._internal();

  static PostRestDriver get instance => _instance;

  Future<List<int>> updateNewPost() async {
    Packet packet = Packet(
        fields: {},
        endPoint: '/open-court/new-posts'
    );
    await packet.get();
    if (!packet.isSuccess) {
      throw RestConnectionError();
    }
    return new List<int>.from(packet.responseBody['postIds']);
  }

  Future<Map<String, dynamic>> getPostContent(int pid) async {
    Packet packet = Packet(
        fields: {},
        endPoint: '/open-court/post/$pid'
    );
    await packet.get();
    if (!packet.isSuccess) {
      throw RestConnectionError();
    }
    return packet.responseBody;
  }

  Future<bool> getLikeStatus(int pid) async {
    PostInfo postInfo = mapToPostInfo(await getPostContent(pid));
    return postInfo.liked;
  }

  Future<void> likePost(int pid) async {
    Packet packet = Packet(
      fields: {},
      endPoint: '/open-court/post/$pid/like'
    );
    await packet.post();
    if (!packet.isSuccess) {
      throw RestConnectionError();
    }
  }

  Future<void> cancelLikePost(int pid) async {
    Packet packet = Packet(
        fields: {},
        endPoint: '/open-court/post/$pid/like'
    );
    await packet.delete();
    if (!packet.isSuccess) {
      throw RestConnectionError();
    }
  }

  Future<void> unlikePost(int pid) async {
    Packet packet = Packet(
        fields: {},
        endPoint: '/open-court/post/$pid/unlike'
    );
    await packet.post();
    if (!packet.isSuccess) {
      throw RestConnectionError();
    }
  }

  Future<void> cancelUnlikePost(int pid) async {
    Packet packet = Packet(
        fields: {},
        endPoint: '/open-court/post/$pid/unlike'
    );
    await packet.delete();
    if (!packet.isSuccess) {
      throw RestConnectionError();
    }
  }

  Future<void> viewPost(int pid) async {
    Packet packet = Packet(
        fields: null,
        endPoint: '/open-court/post/$pid/view'
    );
    await packet.post();
  }
}