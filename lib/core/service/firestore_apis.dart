import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
// import "./firestore_content.dart";
import "./firestore_post.dart";
import "./firestore_user.dart";

class FirestoreApis {
  // API for Gallery View
  Future<Map<String, dynamic>> getUserByUid(String uid) async {
    return await FirestoreUser()
        .getUserFromFirestore(uid)
        .then((snapshot) => snapshot.data() as Map<String, dynamic>);
  }

  Future<Map<String, dynamic>> getPostByPid(String pid) async {
    return await FirestorePost()
        .getPostFromFirestore(pid)
        .then((snapshot) => snapshot.data() as Map<String, dynamic>);
  }

  Future<Map<String, dynamic>> getUserByUsername(String username) async {
    QuerySnapshot snapshot = await FirestoreUser().getUserByUsername(username);
    if (snapshot.size == 0) {
      return {};
    } else {
      return snapshot.docs[0].data() as Map<String, dynamic>;
    }
  }

  Future<List<Map<String, dynamic>>> getPostList(String username) async {
    final user = await getUserByUsername(username);
    List<Map<String, dynamic>> postList = [];
    if (user.isNotEmpty) {
      for (var postId in user["postIdList"]) {
        await FirestorePost().getPostFromFirestore(postId).then((snapshot) =>
            postList.add(snapshot.data() as Map<String, dynamic>));
      }
    }

    return postList;
  }

  Future<Map<String, List<dynamic>>> groupPostByUser(String username) async {
    Map<String, List<dynamic>> postGroup = {};
    Map<String, dynamic> user = await getUserByUsername(username);
    if (user.isNotEmpty) {
      for (var pid in user["postIdList"]) {
        Map<String, dynamic> post = await getPostByPid(pid);
        for (var uid in post["mentionIdList"]) {
          final nickname =
              await getUserByUid(uid).then((user) => user["nickname"]);
          if (!postGroup.containsKey(nickname)) {
            postGroup[nickname] = [post];
          } else {
            postGroup[nickname]!.add(post);
          }
        }
      }
    }

    return postGroup;
  }

  // API for Feed View
  Future<List<Map<String, dynamic>>> getFeedList() async {
    QuerySnapshot snapshot = await FirestorePost().getFeed();
    List<Map<String, dynamic>> feedPost = [];
    if (snapshot.size != 0) {
      for (var doc in snapshot.docs) {
        feedPost.add(doc.data() as Map<String, dynamic>);
      }
    }

    return feedPost;
  }

  // // API for Upload View
  // Future<bool> mentionValidator(String username) async {
  //   QuerySnapshot snapshot = await FirestoreUser().getUserByUsername(username);

  //   return snapshot.size != 0;
  // }

  // uploadPost(String pid) async {
  //   DocumentSnapshot postSnapshot =
  //       await FirestorePost().getPostFromFirestore(pid);
  //   final post = postSnapshot.data() as Map<String, dynamic>;
  //   for (var uid in post["mentionIdList"]) {
  //     DocumentSnapshot userSnapshot =
  //         await FirestoreUser().getUserFromFirestore(uid);
  //     final user = userSnapshot.data() as Map<String, dynamic>;
  //     user["pendingPostIdList"].add(post["pid"]);
  //   }
  // }
}
