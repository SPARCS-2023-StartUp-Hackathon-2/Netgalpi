import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
// import "./filestore_content.dart";
import "./filestore_post.dart";
import "./filestore_user.dart";

class FirestoreApis {
  // API for Gallery View
  Future<String> getPostList(String username) async {
    QuerySnapshot snapshot = await FirestoreUser().getUserByUsername(username);
    if (snapshot.size == 0) {
      return "";
    } else {
      var data = snapshot.docs[0].data() as Map<String, dynamic>;
      return data["postIdList"];
    }
  }

  Future<Map<String, List<Map<String, dynamic>>>> groupPostByUser(
      String username) async {
    QuerySnapshot snapshot = await FirestoreUser().getUserByUsername(username);
    Map<String, List<Map<String, dynamic>>> postGroup = {};
    if (snapshot.size != 0) {
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
    }

    return postGroup;
  }

  // API for Feed View
  Future<List<String>> getFeedList() async {
    QuerySnapshot snapshot = await FirestorePost().getFeed();
    List<String> feedPost = [];
    if (snapshot.size != 0) {
      for (var doc in snapshot.docs) {
        feedPost.add(doc.id);
      }
    }

    return feedPost;
  }

  // API for Upload View
  Future<bool> mentionValidator(String username) async {
    QuerySnapshot snapshot = await FirestoreUser().getUserByUsername(username);

    return snapshot.size != 0;
  }

  uploadPost(String pid) async {
    DocumentSnapshot postSnapshot =
        await FirestorePost().getPostFromFirestore(pid);
    final post = postSnapshot.data() as Map<String, dynamic>;
    for (var uid in post["mentionIdList"]) {
      DocumentSnapshot userSnapshot =
          await FirestoreUser().getUserFromFirestore(uid);
      final user = userSnapshot.data() as Map<String, dynamic>;
      user["pendingPostIdList"].add(post["pid"]);
    }
  }
}
