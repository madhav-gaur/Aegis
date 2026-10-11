import 'package:aegis/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepo {
  final firestore = FirebaseFirestore.instance;
  Future<UserModel?> getCurrentUser(String uid) async {
    final doc = await firestore.collection('users').doc(uid).get();

    if (!doc.exists) return null;
    return UserModel.fromJson(doc.data()!);
  }
}
