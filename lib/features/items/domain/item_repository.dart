import 'package:emarket/features/items/domain/items.dart';

abstract class ItemsRepository {
  Stream<List<Item>> watchItems();
  Future<void> addItem(Item item);
}