import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emarket/features/auth/domain/app_user.dart';
import 'package:emarket/features/auth/domain/auth_failure.dart';
import 'package:emarket/features/auth/domain/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

class FirestoreAuthRepository implements AuthRepository {
  FirestoreAuthRepository(this._db, this._auth);
  final FirebaseFirestore _db;
  final FirebaseAuth _auth;
  @override
  Stream<String?> authStateChanges() {
    return _auth.authStateChanges().map((user) => user?.uid);
  }

  @override
  Future<void> signIn({required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw AuthFailure(_messageFor(e.code));
    }
  }

  @override
  Future<void> signOut() async {
    await _auth.signOut();
  }

  @override
  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      final uid = credential.user?.uid;
      if (uid == null) {
        throw AuthFailure('Could not create account');
      }
      await _db
          .collection('users')
          .doc(uid)
          .set(
            AppUser(
              id: uid,
              name: name.trim(),
              createdAt: DateTime.now(),
            ).toJson(),
          );
    } on FirebaseAuthException catch (e) {
      throw AuthFailure(_messageFor(e.code));
    } on FirebaseException catch (e) {
      debugPrint('signUp profile write failed: ${e.code}');
      throw const AuthFailure(
        'Account created, but saving your profile failed. Please try again.',
      );
    }
  }

  String _messageFor(String code) {
    switch (code) {
      case 'email-already-in-use':
        return 'This email is already registered.';
      case 'weak-password':
        return 'Password is too weak. Use at least 6 characters.';
      case 'invalid-email':
        return 'Please enter a valid email address.';
      case 'invalid-credential':
      case 'user-not-found':
      case 'wrong-password':
        return 'Incorrect email or password.';
      case 'network-request-failed':
        return 'No internet connection. Please try again.';
      case 'too-many-requests':
        return 'Too many attempts. Please wait and try again.';
      default:
        return 'Something went wrong. Please try again.';
    }
  }
}

