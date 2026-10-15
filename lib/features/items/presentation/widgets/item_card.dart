import 'package:emarket/features/items/domain/items.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({super.key, required this.item});
  final Item item;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        context.push('/itemdetails', extra: item);
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                color: theme.colorScheme.surfaceContainerHighest,
                child: const Icon(Icons.phone, size: 40),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleMedium,
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${item.price.toStringAsFixed(2)} Birr',
                          style: theme.textTheme.titleSmall?.copyWith(
                            color: theme.colorScheme.primary,
                          ),
                          maxLines: 1,
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          item.category.label,
                          style: theme.textTheme.bodySmall,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
