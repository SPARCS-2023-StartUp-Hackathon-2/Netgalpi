import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/content_model.dart';

class FirestoreContent {
  final CollectionReference _contentCollection =
      FirebaseFirestore.instance.collection('content');

  Future<String> addContentToFirestore(ContentModel contentModel) async {
    DocumentReference ref = await _contentCollection.add(contentModel.toJson());
    ContentModel initContent = await getContentFromFirestore(ref.id);
    initContent.contentId = ref.id;
    ref.update(initContent.toJson());

    return ref.id;
  }

  updateContentToFirestore(ContentModel newContentModel) async {
    return await _contentCollection
        .doc(newContentModel.contentId)
        .update(newContentModel.toJson());
  }

  Future<ContentModel> getContentFromFirestore(String cid) async {
    DocumentSnapshot content = await _contentCollection.doc(cid).get();
    return ContentModel.fromDocumentSnapshot(documentSnapshot: content);
  }

  Future<List<ContentModel>> getContentsFromPid(String pid) async {
    QuerySnapshot contents =
        await _contentCollection.where("contentPostId", isEqualTo: pid).get();
    if (contents.size == 0) {
      return [];
    } else {
      List<ContentModel> feedList = [];
      for (var doc in contents.docs) {
        feedList.add(ContentModel.fromDocumentSnapshot(documentSnapshot: doc));
      }
      return feedList;
    }
  }
}
