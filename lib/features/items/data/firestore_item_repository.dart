import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emarket/features/items/domain/items.dart';
import 'package:emarket/features/items/domain/items_repository.dart';

class FirestoreItemRepository implements ItemsRepository {
  FirestoreItemRepository(this._db);
  final FirebaseFirestore _db;
  CollectionReference<Map<String, dynamic>> get _items =>
      _db.collection('items');
  @override
  Future<void> addItem(Item item) async {
    await _items.add(item.toJson());
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
