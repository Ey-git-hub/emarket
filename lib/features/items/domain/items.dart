import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emarket/features/items/domain/condition.dart';
import 'package:emarket/features/items/domain/item_status.dart';
import 'package:emarket/features/items/domain/catagory.dart';

// import 'package:flutter/foundation.dart';

class Item {
  Item({
    required this.id,
    required this.sellerId,
    required this.sellerName,
    required this.name,
    required this.price,
    required this.category,
    required this.condition,
    required this.status,
    required this.photoUrls,
    required this.createdAt,
    this.description,
  });
  final String id;
  final String sellerId;
  final String sellerName;
  final String name;
  final double price;
  final Catagory category;
  final Condition condition;
  final ItemStatus status;
  final List<String> photoUrls;
  final DateTime createdAt;
  final String? description;

  Item copyWith({
    String? id,
    String? sellerId,
    String? sellerName,
    String? name,
    double? price,
    Catagory? category,
    Condition? condition,
    ItemStatus? status,
    List<String>? photoUrls,
    DateTime? createdAt,
    String? description,
  }) {
    return Item(
      id: id ?? this.id,
      sellerId: sellerId ?? this.sellerId,
      sellerName: sellerName ?? this.sellerName,
      name: name ?? this.name,
      price: price ?? this.price,
      category: category ?? this.category,
      condition: condition ?? this.condition,
      status: status ?? this.status,
      photoUrls: photoUrls ?? this.photoUrls,
      createdAt: createdAt ?? this.createdAt,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sellerId': sellerId,
      'sellerName': sellerName,
      'name': name,
      'price': price,
      'catagory': category.name,
      'condition': condition.name,
      'status': status.name,
      'photoUrls': photoUrls,
    'createdAt': FieldValue.serverTimestamp(),
      'description': description,
    };
  }

  factory Item.fromJson(String id, Map<String, dynamic> json) {
    return Item(
      id: id,
      sellerId: json['sellerId'] as String,
      sellerName: json['sellerName'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      category: Catagory.values.byName(json['catagory'] as String),
      condition: Condition.values.byName(json['condition'] as String),
      status: ItemStatus.values.byName(json['status'] as String),
      photoUrls: List<String>.from(json['photoUrls'] as List? ?? const []),
      createdAt: (json['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      description: json['description'] as String?,
    );
  }
}
