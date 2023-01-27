import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  late List<String> postIdList;
  late String userId, username, realname, token, joinDate;

  UserModel({
    required this.userId,
    required this.username,
    required this.token,
    required this.realname,
    required this.joinDate,
    required this.postIdList,
  });

  UserModel.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
    userId = documentSnapshot.id;
    username = documentSnapshot['username'];
    realname = documentSnapshot['realname'];
    joinDate = documentSnapshot['joinDate'];
    token = documentSnapshot['token'];
    postIdList = documentSnapshot['postIdList'];
  }

  UserModel.fromJson(Map<dynamic, dynamic> map) {
    userId = map['userId'];
    username = map['username'];
    realname = map['realname'];
    joinDate = map['joinDate'];
    postIdList = map['postIdList'];
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'username': username,
      'realname': realname,
      'joinDate': joinDate,
      'postIdList': postIdList,
    };
  }
}
