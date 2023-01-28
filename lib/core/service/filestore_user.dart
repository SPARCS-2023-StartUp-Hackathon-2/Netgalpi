import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/user_model.dart';

class FirestoreUser {
  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('user');
  Future<String> addUserToFirestore(UserModel userModel) async {
    final docSnapshot = await _userCollection.add(userModel.toJson());
    return docSnapshot.id;
  }

  Future<QuerySnapshot> getUserByUsername(String username) async {
    return await _userCollection.where("username", isEqualTo: username).get();
  }

  Future<DocumentSnapshot> getUserFromFirestore(String uid) async {
    return await _userCollection.doc(uid).get();
  }
}
