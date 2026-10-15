import 'package:emarket/features/items/domain/items.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
                  child: Icon(Icons.phone_android),
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
