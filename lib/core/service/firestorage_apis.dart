import 'package:firebase_storage/firebase_storage.dart';
import 'package:file/file.dart';
import 'dart:math';

final storageRef = FirebaseStorage.instance.ref();
Reference imagesRef = storageRef.child("image");
Reference videoRef = storageRef.child("vedio");
Reference postRef = imagesRef.child("post");
Reference contentRef = imagesRef.child("ref");

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();
String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

class FireStorage {
  Future<String> uploadPostImg(File file) async {
    try {
      String filename = getRandomString(15);
      Reference postImgRef = postRef.child(filename);
      await postImgRef.putFile(file);

      return await postImgRef.getDownloadURL();
    } on FirebaseException catch (e) {
      print("error: $e");
      return "";
    }
  }

  Future<String> uploadContentImg(File file) async {
    try {
      String filename = getRandomString(15);
      Reference contentImgRef = contentRef.child(filename);
      await contentImgRef.putFile(file);

      return await contentImgRef.getDownloadURL();
    } on FirebaseException catch (e) {
      print("error: $e");
      return "";
    }
  }

  Future<String> uploadVideo(File file) async {
    try {
      String filename = getRandomString(15);
      Reference postVideoRef = contentRef.child(filename);
      await postVideoRef.putFile(file);

      return await postVideoRef.getDownloadURL();
    } on FirebaseException catch (e) {
      print("error: $e");
      return "";
    }
  }
}
