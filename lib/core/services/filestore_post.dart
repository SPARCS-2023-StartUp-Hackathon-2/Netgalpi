import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/post_model.dart';

class FirestorePost {
  final CollectionReference _postCollection =
      FirebaseFirestore.instance.collection('post');
  addPostToFirestore(PostModel postModel) async {
    await _postCollection.doc(postModel.postId).set(postModel.toJson());
  }

  Future<DocumentSnapshot> getPostFromFirestore(String pid) async {
    return await _postCollection.doc(pid).get();
  }
}
