import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/post_model.dart';

class FirestorePost {
  final CollectionReference _postCollection =
      FirebaseFirestore.instance.collection('post');
  Future<String> addPostToFirestore(PostModel postModel) async {
    var docSnapshot = await _postCollection.add(postModel.toJson());
    return docSnapshot.id;
  }

  Future<DocumentSnapshot> getPostFromFirestore(String pid) async {
    return await _postCollection.doc(pid).get();
  }
}
