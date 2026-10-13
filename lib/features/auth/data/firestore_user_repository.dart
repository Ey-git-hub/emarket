import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emarket/features/auth/domain/app_user.dart';
import 'package:emarket/features/auth/domain/user_repository.dart';

class FirestoreUserRepository implements UserRepository {
  FirestoreUserRepository(this._db);
  final FirebaseFirestore _db;
  @override
  Stream<AppUser?> watchUser(String uid) {
    return _db.collection('users').doc(uid).snapshots().map((doc) {
      final data = doc.data();
      if (data == null) return null;
      return AppUser.fromJson(doc.id, data);
    });
  }
}
