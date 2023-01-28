import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/user_model.dart';

class FirestoreUser {
  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('user');
  addUserToFirestore(UserModel userModel) async {
    await _userCollection.doc(userModel.userId).set(userModel.toJson());
  }

  Future<UserModel> getUserFromFirestore(String uid) async {
    DocumentSnapshot user = await _userCollection.doc(uid).get();
    return UserModel.fromDocumentSnapshot(documentSnapshot: user);
  }

  Future<UserModel?> getUserByUsername(String username) async {
    QuerySnapshot users =
        await _userCollection.where("username", isEqualTo: username).get();
    if (users.size == 0) {
      return null;
    } else {
      return UserModel.fromDocumentSnapshot(documentSnapshot: users.docs[0]);
    }
  }
}
