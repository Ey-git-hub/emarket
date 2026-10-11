// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Stream<String?> authStateChanges();
  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  });
  Future<void> signIn({required String email, required String password});
  Future<void> signOut();
}



