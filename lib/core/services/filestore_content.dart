import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/content_model.dart';

class FirestoreContent {
  final CollectionReference _contentCollection =
      FirebaseFirestore.instance.collection('content');
  Future<String> addContentToFirestore(ContentModel contentModel) async {
    final docSnapshot = await _contentCollection.add(contentModel.toJson());
    return docSnapshot.id;
  }

  Future<DocumentSnapshot> getContentFromFirestore(String cid) async {
    return await _contentCollection.doc(cid).get();
  }
}
