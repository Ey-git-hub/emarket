import 'package:flutter/material.dart';

class ModalContent extends StatelessWidget {
  const ModalContent({super.key});

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
          ('Books', Icons.book_sharp),
          ('Electronics', Icons.desktop_mac),
          ('Clothing', Icons.checkroom),
          ('Furniture',Icons.chair),
          ('Stationery',Icons.document_scanner)
        ].map(
          (category) => ListTile(
            onTap: () {},
            leading: CircleAvatar(child: Icon(category.$2)),
            title: Text(category.$1),
            // trailing: const Icon(Icons.chevron_right),
          ),
        ),
      ],
    );
  }
}
