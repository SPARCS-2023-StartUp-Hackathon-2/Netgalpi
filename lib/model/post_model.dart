import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  String? postId;
  late String imageUrl, mp4Url, title, writerId, uploadedAt;
  late int likesCount;
  late bool isOpened;
  late List<dynamic> mentionIdList, likerIdList, contentIdList;

  PostModel({
    required this.postId,
    required this.imageUrl,
    required this.mp4Url,
    required this.title,
    required this.isOpened,
    required this.writerId,
    required this.uploadedAt,
    required this.mentionIdList,
    required this.likerIdList,
    required this.contentIdList,
    this.likesCount = 0,
  });

  PostModel.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
    postId = documentSnapshot['postId'];
    imageUrl = documentSnapshot['imageUrl'];
    mp4Url = documentSnapshot['mp4Url'];
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
    mp4Url = map['mp4Url'];
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
      'mp4Url': mp4Url,
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
