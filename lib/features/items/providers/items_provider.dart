import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emarket/features/items/data/firestore_item_repository.dart';
import 'package:emarket/features/items/domain/item_repository.dart';
import 'package:emarket/features/items/domain/items.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final itemRepositoryProvider = Provider<ItemsRepository>((ref) {
  return FirestoreItemRepository(FirebaseFirestore.instance);
});
final itemStreamProvider=StreamProvider<List<Item>>((ref){
  return ref.watch(itemRepositoryProvider).watchItems();
});