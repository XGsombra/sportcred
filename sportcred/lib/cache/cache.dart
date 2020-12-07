import 'package:sportcred/network/post_rest_driver.dart';
import 'package:sportcred/post/post_card.dart';
import 'package:mutex/mutex.dart';

class PostPreviewCache {
  static final PostPreviewCache _instance = PostPreviewCache._internal();

  PostPreviewCache._internal();

  static PostPreviewCache get instance => _instance;

  List<PostInfo> previewWidgetInfo = List();

  Future<void> init() async {
    if (previewWidgetInfo.isEmpty)
      await refresh();
  }

  Future<void> refresh() async {
    PostRestDriver restDriver = PostRestDriver.instance;
    List<int> list = await restDriver.updateNewPost();
    for (var it in list) {
      var data = await restDriver.getPostContent(it);
      previewWidgetInfo.insert(0, PostInfo(
          pid: data['postId'],
          uid: data['userId'],
          content: data['content'],
          likeCount: data['likeCount'],
          liked: data['likeCondition'] == 'liked',
          createTime: data['createdTime'],
          pictures: new List<String>.from(data['pictures']),
          tags: new List<String>.from(data['tags'])
      ));
    }
  }

  void clear() {
    previewWidgetInfo.clear();
  }

  List<PostInfo> get postInfo => previewWidgetInfo;
}

class AvatarCache {
  static final AvatarCache _instance = AvatarCache._internal();
  AvatarCache._internal();
  static AvatarCache get instance => _instance;


  final lock = ReadWriteMutex();

  // Map uid to avatarUri
  Map<int, String> cache = {};

  bool hasAvatar(int uid) {
    lock.acquireRead();
    var ret = cache.containsKey(uid);
    lock.release();
    return ret;
  }

  String getAvatar(int uid) {
    lock.acquireRead();
    var ret = cache[uid];
    lock.release();
    return ret;
  }

  void setAvatar(int uid, String uri) {
    lock.acquireWrite();
    cache[uid] = uri;
    lock.release();
  }
}

class UsernameCache {
  static final UsernameCache _instance = UsernameCache._internal();
  UsernameCache._internal();
  static UsernameCache get instance => _instance;


  final lock = ReadWriteMutex();

  // Map uid to Username
  Map<int, String> cache = {};

  bool hasUsername(int uid) {
    lock.acquireRead();
    var ret = cache.containsKey(uid);
    lock.release();
    return ret;
  }

  String getUsername(int uid) {
    lock.acquireRead();
    var ret = cache[uid];
    lock.release();
    return ret;
  }

  void setUsername(int uid, String uri) {
    lock.acquireWrite();
    cache[uid] = uri;
    lock.release();
  }
}
