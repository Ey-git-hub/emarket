import 'package:emarket/features/auth/providers/user_provider.dart';
import 'package:emarket/features/items/domain/catagory.dart';
import 'package:emarket/features/items/domain/condition.dart';
import 'package:emarket/features/items/domain/item_failure.dart';
import 'package:emarket/features/items/domain/item_status.dart';
import 'package:emarket/features/items/domain/items.dart';
import 'package:emarket/features/items/providers/items_provider.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class PostItemsScreen extends ConsumerStatefulWidget {
  const PostItemsScreen({super.key});

  @override
  ConsumerState<PostItemsScreen> createState() => _PostItemsScreenState();
}

class _PostItemsScreenState extends ConsumerState<PostItemsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  Catagory _catagory = Catagory.books;
  Condition _condition = Condition.brandNew;
  bool isLoading = false;
  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  Future<void> _post() async {
    if (_formKey.currentState!.validate()) {
      return;
    }
    setState(() {
      isLoading = true;
    });
    try {
      final user = await ref.read(currentUserProvider.future);
      if (user == null) {
        throw const ItemFailure('Your Profile is not ready .Please try  again');
      }
      final price = double.tryParse(
        _priceController.text.trim().replaceAll(',', ''),
      );
      if (price == null) return;
      final name = _nameController.text.trim();
      final description = _descriptionController.text.trim();
      final item = Item(
        id: '',
        sellerId: user.id,
        sellerName: user.name,
        name: name,
        price: price,
        category: _catagory,
        condition: _condition,
        status: ItemStatus.active,
        photoUrls: [],
        createdAt: DateTime.now(),
        description: description.isEmpty ? null : description,
      );
      await ref.read(itemRepositoryProvider).addItem(item);
      if (!mounted) return;
      context.pop();
    } on ItemFailure catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    } finally {
      if (mounted) setState(() => isLoading = false);
    }

    // context.push('/postItems');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Post Item')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _nameController,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              validator: (value) => value == null || value.trim().isEmpty
                  ? 'Please enter a name'
                  : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            //   validator: (value) => value == null || value.trim().isEmpty
            //       ? 'Please enter a description'
            //       : null,
            // ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _priceController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: InputDecoration(
                labelText: 'Price',
                prefixText: '',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              validator: (value) {
                final price = double.tryParse(value?.trim() ?? '');
                if (price == null || price <= 0) {
                  return 'Please enter a valid price';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField(
                    initialValue: _catagory,
                    decoration: InputDecoration(
                      labelText: 'Category',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    items: [
                      for (final catagory in Catagory.values)
                        DropdownMenuItem(
                          value: catagory,
                          child: Text(catagory.label),
                        ),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _catagory = value;
                        });
                      }
                    },
                  ),
                ),
                SizedBox(width: 30),
                Expanded(
                  child: DropdownButtonFormField(
                    initialValue: _condition,
                    decoration: InputDecoration(
                      labelText: 'Condition',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    items: [
                      for (final condition in Condition.values)
                        DropdownMenuItem(
                          value: condition,
                          child: Text(condition.label),
                        ),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _condition = value;
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 13),
            ElevatedButton(
              onPressed: isLoading ? null : _post,
              child: isLoading
                  ? SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Post Item'),
            ),
          ],
        ),
      ),
    );
  }
}
