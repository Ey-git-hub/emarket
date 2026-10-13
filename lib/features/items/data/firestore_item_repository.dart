import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emarket/features/items/domain/item_failure.dart';
import 'package:emarket/features/items/domain/items.dart';
import 'package:emarket/features/items/domain/item_repository.dart';
import 'package:flutter/material.dart';

class FirestoreItemRepository implements ItemsRepository {
  FirestoreItemRepository(this._db);
  final FirebaseFirestore _db;
  CollectionReference<Map<String, dynamic>> get _items =>
      _db.collection('items');
  @override
  @override
  Future<void> addItem(Item item) async {
    try {
      await _items.add(item.toJson());
    } on FirebaseException catch (e) {
      debugPrint('addItem failed: ${e.code}');
      throw ItemFailure(_messageFor(e.code));
    }
  }

  String _messageFor(String code) {
    switch (code) {
      case 'permission-denied':
        return 'You do not have permission to do that.';
      case 'unavailable':
        return 'No connection. Please try again.';
      default:
        return 'Something went wrong. Please try again.';
    }
  }

  @override
  Stream<List<Item>> watchItems() {
    return _items
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => Item.fromJson(doc.id, doc.data()))
              .toList(),
        );
  }
}
