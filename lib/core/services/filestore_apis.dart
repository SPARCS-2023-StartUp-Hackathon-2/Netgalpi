import 'package:cloud_firestore/cloud_firestore.dart';
import '../../model/post_model.dart';
import '../../model/user_model.dart';
import '../../model/content_model.dart';
import "./filestore_content.dart";
import "./filestore_post.dart";
import "./filestore_user.dart";

class FirestoreApis {
  final CollectionReference _postCollection =
      FirebaseFirestore.instance.collection('post');
  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('user');
  final CollectionReference _contentCollection =
      FirebaseFirestore.instance.collection('content');

  getPostList(String username) async {
    QuerySnapshot snapshot = await FirestoreUser().getUserByUsername(username);
    if (snapshot.size == 0) {
      return null;
    } else {
      var data = snapshot.docs[0].data() as Map<String, dynamic>;
      return data["postIdList"];
    }
  }

  groupPostByUser(String username) async {
    QuerySnapshot snapshot = await FirestoreUser().getUserByUsername(username);
    if (snapshot.size == 0) {
      return null;
    } else {
      Map<String, List<Map<String, dynamic>>> postGroup = {};
      for (var doc in snapshot.docs) {
        var post = doc.data() as Map<String, dynamic>;
        for (var user in post["mentionIdList"]) {
          if (!postGroup.containsKey(user)) {
            postGroup[user] = [post];
          } else {
            postGroup[user]!.add(post);
          }
        }
      }

      return postGroup;
    }
  }

  getPhotoUrl(String pid) async {}
}
