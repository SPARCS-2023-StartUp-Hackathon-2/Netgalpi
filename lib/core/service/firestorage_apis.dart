import 'package:firebase_storage/firebase_storage.dart';
import 'package:file/file.dart';

final storageRef = FirebaseStorage.instance.ref();
Reference imagesRef = storageRef.child("image");
Reference videoRef = storageRef.child("vedio");
Reference postRef = imagesRef.child("post");
Reference contentRef = imagesRef.child("ref");

class FireStorage {
  Future<String> uploadPostImg(File file) async {
    try {
      await postRef.putFile(file);

      return await postRef.getDownloadURL();
    } on FirebaseException catch (e) {
      print("error:");
      return "";
    }
  }

  Future<String> uploadContentImg(File file) async {
    try {
      await contentRef.putFile(file);

      return await contentRef.getDownloadURL();
    } on FirebaseException catch (e) {
      print("error:");
      return "";
    }
  }

  Future<String> uploadVideo(File file) async {
    try {
      await videoRef.putFile(file);

      return await videoRef.getDownloadURL();
    } on FirebaseException catch (e) {
      print("error:");
      return "";
    }
  }
}
