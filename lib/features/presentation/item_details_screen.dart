import 'package:emarket/features/items/domain/items.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ItemDetailsScreen extends StatelessWidget {
  const ItemDetailsScreen({super.key, required this.item});
  final Item item;
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(), body: Center(child: Text(item.name)));
  }
}
