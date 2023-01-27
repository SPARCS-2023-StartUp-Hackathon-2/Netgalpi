import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  late String postId, imageUrl, gifUrl, title, writerId;
  late DateTime uploadedAt;
  late int likesCount;
  late bool isOpened;
  late List<String> mentionIdList, likerIdList, contentIdList;

  PostModel({
    required this.postId,
    required this.imageUrl,
    required this.gifUrl,
    required this.title,
    required this.isOpened,
    required this.writerId,
    required this.mentionIdList,
    required this.likerIdList,
    required this.contentIdList,
    this.likesCount = 0,
    uploadedAt,
  }) : uploadedAt = uploadedAt ?? DateTime.now();

  PostModel.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
    postId = documentSnapshot.id;
    imageUrl = documentSnapshot['imageUrl'];
    gifUrl = documentSnapshot['gifUrl'];
    title = documentSnapshot['title'];
    uploadedAt = documentSnapshot['uploadedAt'];
    isOpened = documentSnapshot['isOpened'];
    likesCount = documentSnapshot['likesCount'];
    writerId = documentSnapshot['writerId'];
    mentionIdList = documentSnapshot['mentionIdList'];
    likerIdList = documentSnapshot['likerIdList'];
    contentIdList = documentSnapshot['contentIdList'];
  }

  PostModel.fromJson(Map<dynamic, dynamic> map) {
    postId = map['postId'];
    imageUrl = map['imageUrl'];
    gifUrl = map['gifUrl'];
    title = map['title'];
    uploadedAt = map['uploadedAt'];
    isOpened = map['isOpened'];
    likesCount = map['likesCount'];
    writerId = map['writerId'];
    mentionIdList = map['mentionIdList'];
    likerIdList = map['likerIdList'];
    contentIdList = map['contentIdList'];
  }

  Map<String, dynamic> toJson() {
    return {
      'postId': postId,
      'imageUrl': imageUrl,
      'gifUrl': gifUrl,
      'title': title,
      'uploadedAt': uploadedAt,
      'isOpened': isOpened,
      'likesCount': likesCount,
      'writerId': writerId,
      'mentionIdList': mentionIdList,
      'likerIdList': likerIdList,
      'contentIdList': contentIdList,
    };
  }
}
