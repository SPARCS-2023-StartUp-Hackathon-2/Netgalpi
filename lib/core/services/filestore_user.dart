import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/user_model.dart';

class FirestoreUser {
  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('user');
  addUserToFirestore(UserModel userModel) async {
    await _userCollection.doc(userModel.userId).set(userModel.toJson());
  }

  Future<DocumentSnapshot> getUserFromFirestore(String uid) async {
    return await _userCollection.doc(uid).get();
  }
}
