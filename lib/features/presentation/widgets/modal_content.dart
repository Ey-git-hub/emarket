import 'package:emarket/features/items/domain/catagory.dart';
import 'package:flutter/material.dart';

class ModalContent extends StatelessWidget {
  const ModalContent({
    super.key,
    required this.onCategorySelected,
  });

  final ValueChanged<Catagory> onCategorySelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Filter Items',
          style: TextStyle(fontWeight: FontWeight.w300, fontSize: 19),
        ),
        ...[
          (Catagory.books, Icons.book_sharp),
          (Catagory.electronics, Icons.desktop_mac),
          (Catagory.clothing, Icons.checkroom),
          (Catagory.furniture, Icons.chair),
          (Catagory.stationary, Icons.document_scanner),
          (Catagory.other, Icons.category),
        ].map(
          (category) => ListTile(
            onTap: () {
              onCategorySelected(category.$1);
              Navigator.pop(context);
            },
            leading: CircleAvatar(child: Icon(category.$2)),
            title: Text(category.$1.label),
            // trailing: const Icon(Icons.chevron_right),
          ),
        ),
      ],
    );
  }
}
