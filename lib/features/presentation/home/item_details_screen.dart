import 'dart:convert';

import 'package:emarket/features/items/domain/items.dart';
import 'package:flutter/material.dart';

class ItemDetailsScreen extends StatelessWidget {
  const ItemDetailsScreen({super.key, required this.item});
  final Item item;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.shopping_cart)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 500,
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(18),
                    ),
                  ),
                  child: item.photoUrls.isEmpty
                      ? const Icon(Icons.image_not_supported, size: 48)
                      : Image.memory(
                          base64Decode(item.photoUrls.first),
                          width: double.infinity,
                          height: 500,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.broken_image, size: 48),
                        ),
                ),
                // Image.network('https://picsum.photos',width: 500,height: 500,),
                Positioned(
                  bottom: 8,
                  left: 8,
                  right: 8,
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            item.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Text(
                          "${item.price} Birr",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            Card(
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  children: [
                    if (item.description != null &&
                        item.description!.isNotEmpty)
                      Text(
                        item.description!,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Text('Seller Name: ${item.sellerName}'),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: Text('Contact'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
