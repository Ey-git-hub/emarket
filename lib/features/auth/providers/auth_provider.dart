import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emarket/features/auth/data/firebase_auth_repository.dart';
// import 'package:emarket/features/auth/domain/app_user.dart';
import 'package:emarket/features/auth/domain/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => FirestoreAuthRepository(
    FirebaseFirestore.instance,
    FirebaseAuth.instance,
  ),
);
final authStateProvider=StreamProvider<String?>((ref){
return ref.watch(authRepositoryProvider).authStateChanges();
});