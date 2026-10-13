import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emarket/features/auth/data/firestore_user_repository.dart';
import 'package:emarket/features/auth/domain/app_user.dart';
import 'package:emarket/features/auth/domain/user_repository.dart';
import 'package:emarket/features/auth/providers/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userRepositoryProvider=Provider<UserRepository>(
  (ref)=>FirestoreUserRepository(FirebaseFirestore.instance)
);
final currentUserProvider=StreamProvider<AppUser?>(
  (ref){
    final uid=ref.watch(authStateProvider).value;
    if(uid==null) return Stream.value(null);
    return ref.watch(userRepositoryProvider).watchUser(uid);
  }
);