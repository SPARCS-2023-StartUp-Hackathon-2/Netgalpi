import 'package:cloud_firestore/cloud_firestore.dart';

class StickerModel {
  late String stickerId, stickerUrl;
  late int xPos, yPos;

  StickerModel({
    required this.stickerId,
    required this.stickerUrl,
    required this.xPos,
    required this.yPos,
  });

  StickerModel.fromDocumentSnapshot(
      {required DocumentSnapshot documentSnapshot}) {
    stickerId = documentSnapshot.id;
    stickerUrl = documentSnapshot['stickerUrl'];
    xPos = documentSnapshot['xPos'];
    yPos = documentSnapshot['yPos'];
  }

  StickerModel.fromJson(Map<dynamic, dynamic> map) {
    stickerId = map['stickerId'];
    stickerUrl = map['stickerUrl'];
    xPos = map['xPos'];
    yPos = map['yPos'];
  }

  Map<String, dynamic> toJson() {
    return {
      'stickerId': stickerId,
      'stickerUrl': stickerUrl,
      'xPos': xPos,
      'yPos': yPos,
    };
  }
}
