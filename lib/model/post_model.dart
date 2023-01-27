import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  late String postId, imageUrl, gifUrl;
  late DateTime uploadedAt;
  late int likesCount;
  late bool isOpened;
  late List<String> userIdList,
      stickerIdList,
      mentionIdList,
      tagIdList,
      diaryIdList;

  PostModel({
    required this.postId,
    required this.imageUrl,
    required this.gifUrl,
    required this.uploadedAt,
    required this.likesCount,
    required this.isOpened,
    required this.userIdList,
    required this.stickerIdList,
    required this.mentionIdList,
    required this.tagIdList,
    required this.diaryIdList,
  });

  PostModel.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
    postId = documentSnapshot.id;
    imageUrl = documentSnapshot['imageUrl'];
    gifUrl = documentSnapshot['gifUrl'];
    uploadedAt = documentSnapshot['uploadedAt'];
    likesCount = documentSnapshot['likesCount'];
    isOpened = documentSnapshot['isOpened'];
    userIdList = documentSnapshot['userIdList'];
    stickerIdList = documentSnapshot['stickerIdList'];
    mentionIdList = documentSnapshot['mentionIdList'];
    tagIdList = documentSnapshot['tagIdList'];
    diaryIdList = documentSnapshot['diaryIdList'];
  }

  PostModel.fromJson(Map<dynamic, dynamic> map) {
    postId = map['postId'];
    imageUrl = map['imageUrl'];
    gifUrl = map['gifUrl'];
    uploadedAt = map['uploadedAt'];
    likesCount = map['likesCount'];
    isOpened = map['isOpened'];
    userIdList = map['userIdList'];
    stickerIdList = map['stickerIdList'];
    mentionIdList = map['mentionIdList'];
    tagIdList = map['tagIdList'];
    diaryIdList = map['diaryIdList'];
  }

  Map<String, dynamic> toJson() {
    return {
      'postId': postId,
      'imageUrl': imageUrl,
      'gifUrl': gifUrl,
      'uploadedAt': uploadedAt,
      'likesCount': likesCount,
      'isOpened': isOpened,
      'userIdList': userIdList,
      'stickerIdList': stickerIdList,
      'mentionIdList': mentionIdList,
      'tagIdList': tagIdList,
      'diaryIdList': diaryIdList,
    };
  }
}
