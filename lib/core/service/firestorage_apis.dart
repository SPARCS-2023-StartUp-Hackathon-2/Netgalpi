import 'package:firebase_storage/firebase_storage.dart';
import 'package:file/file.dart';

final storageRef = FirebaseStorage.instance.ref();
Reference imagesRef = storageRef.child("image");
Reference videoRef = storageRef.child("vedio");
Reference postRef = imagesRef.child("post");
Reference contentRef = imagesRef.child("ref");

class FireStorage {
  Future<String> uploadPostImg(File file, String pid) async {
    try {
      await postRef.child(pid).putFile(file);

      return await postRef.getDownloadURL();
    } on FirebaseException catch (e) {
      print("error: $e");
      return "";
    }
  }

  Future<String> uploadContentImg(File file, String cid) async {
    try {
      await contentRef.child(cid).putFile(file);

      return await contentRef.getDownloadURL();
    } on FirebaseException catch (e) {
      print("error: $e");
      return "";
    }
  }

  Future<String> uploadVideo(File file, String pid) async {
    try {
      await videoRef.child(pid).putFile(file);

      return await videoRef.getDownloadURL();
    } on FirebaseException catch (e) {
      print("error: $e");
      return "";
    }
  }
}
