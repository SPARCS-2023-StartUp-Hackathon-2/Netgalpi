import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  late List<String> postIdList, pendingPostIdList;
  late String username, nickname, token;
  String? userId;

  UserModel({
    this.userId,
    required this.username,
    required this.nickname,
    required this.postIdList,
    required this.pendingPostIdList,
  });

  UserModel.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
    userId = documentSnapshot.id;
    username = documentSnapshot['username'];
    nickname = documentSnapshot['nickname'];
    postIdList = documentSnapshot['postIdList'];
    pendingPostIdList = documentSnapshot['pendingPostIdList'];
  }

  UserModel.fromJson(Map<dynamic, dynamic> map) {
    userId = map['userId'];
    username = map['username'];
    nickname = map['nickname'];
    postIdList = map['postIdList'];
    pendingPostIdList = map['pendingPostIdList'];
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'username': username,
      'nickname': nickname,
      'postIdList': postIdList,
      'pendingPostIdList': pendingPostIdList,
    };
  }
}
