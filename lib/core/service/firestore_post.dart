import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/post_model.dart';

class FirestorePost {
  final CollectionReference _postCollection =
      FirebaseFirestore.instance.collection('post');
  Future<String> addPostToFirestore(PostModel postModel) async {
    return await _postCollection
        .add(postModel.toJson())
        .then((docRef) => docRef.id);
  }

  updatePostToFireStore(PostModel newPostModel) async {
    return await _postCollection
        .doc(newPostModel.postId)
        .update(newPostModel.toJson());
  }

  Future<PostModel> getPostFromFirestore(String pid) async {
    DocumentSnapshot post = await _postCollection.doc(pid).get();
    return PostModel.fromDocumentSnapshot(documentSnapshot: post);
  }

  Future<List<PostModel>> getFeed() async {
    QuerySnapshot feeds =
        await _postCollection.where("isOpened", isEqualTo: true).get();
    if (feeds.size == 0) {
      return [];
    } else {
      List<PostModel> feedList = [];
      for (var doc in feeds.docs) {
        feedList.add(PostModel.fromDocumentSnapshot(documentSnapshot: doc));
      }
      return feedList;
    }
  }
}
