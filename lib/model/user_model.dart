import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  late List<String> postIdList;
  late String username, nickname, token;
  String? userId;

  UserModel({
    this.userId,
    required this.username,
    required this.nickname,
    required this.token,
    required this.postIdList,
  });

  UserModel.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
    userId = documentSnapshot.id;
    username = documentSnapshot['username'];
    nickname = documentSnapshot['nickname'];
    token = documentSnapshot['token'];
    postIdList = documentSnapshot['postIdList'];
  }

  UserModel.fromJson(Map<dynamic, dynamic> map) {
    userId = map['userId'];
    username = map['username'];
    nickname = map['nickname'];
    postIdList = map['postIdList'];
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'username': username,
      'nickname': nickname,
      'postIdList': postIdList,
    };
  }
}
