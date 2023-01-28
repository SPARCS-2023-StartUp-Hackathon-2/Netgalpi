import 'package:cloud_firestore/cloud_firestore.dart';

class ContentModel {
  String? contentId;
  late String contentPostId, contentImgUrl, contentText, writerId, uploadedAt;

  ContentModel({
    required this.contentId,
    required this.contentPostId,
    required this.contentImgUrl,
    required this.contentText,
    required this.uploadedAt,
    required this.writerId,
  });

  ContentModel.fromDocumentSnapshot(
      {required DocumentSnapshot documentSnapshot}) {
    contentId = documentSnapshot.id;
    contentPostId = documentSnapshot['contentPostId'];
    contentImgUrl = documentSnapshot['contentImgUrl'];
    contentText = documentSnapshot['contentText'];
    uploadedAt = documentSnapshot['uploadedAt'];
    writerId = documentSnapshot['writerId'];
  }

  ContentModel.fromJson(Map<dynamic, dynamic> map) {
    contentId = map['contentId'];
    contentPostId = map['contentPostId'];
    contentImgUrl = map['contentImgUrl'];
    contentText = map['contentText'];
    uploadedAt = map['uploadedAt'];
    writerId = map['writerId'];
  }

  Map<String, dynamic> toJson() {
    return {
      'contentId': contentId,
      'contentPostId': contentPostId,
      'contentImgUrl': contentImgUrl,
      'contentText': contentText,
      'uploadedAt': uploadedAt,
      'writerId': writerId,
    };
  }
}
