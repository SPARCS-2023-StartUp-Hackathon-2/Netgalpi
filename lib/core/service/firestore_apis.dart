import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import "package:get/get.dart";
import "./firestore_content.dart";
import "./firestore_post.dart";
import "./firestore_user.dart";

import "../../model/post_model.dart";
import "../../model/user_model.dart";
import "../../model/content_model.dart";

class FirestoreApis {
  final postModelApi = FirestorePost();
  final userApi = FirestoreUser();
  final contentApi = FirestoreContent();

  // API for Gallery View
  Future<List<PostModel>> getPostList(String username) async {
    UserModel? user = await FirestoreUser().getUserByUsername(username);
    List<PostModel> postList = [];
    if (user != null) {
      for (var postId in user.postIdList) {
        postList.add(await FirestorePost().getPostFromFirestore(postId));
      }
    }
    postList.sort((a, b) => b.uploadedAt.compareTo(a.uploadedAt));

    return postList;
  }

  Future<Map<String, List<PostModel>>> groupPostByUser(String username) async {
    Map<String, List<PostModel>> postGroup = {};
    UserModel? user = await FirestoreUser().getUserByUsername(username);
    if (user != null) {
      for (var pid in user.postIdList) {
        PostModel post = await FirestorePost().getPostFromFirestore(pid);
        for (var uid in post.mentionIdList) {
          UserModel mentionedUser =
              await FirestoreUser().getUserFromFirestore(uid);
          final nickname = mentionedUser.nickname;
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
  Future<List<PostModel>> getFeedList() async {
    return await FirestorePost().getFeed();
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
