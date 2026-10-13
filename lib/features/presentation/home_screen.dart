import 'package:emarket/features/auth/providers/auth_provider.dart';
import 'package:emarket/features/auth/providers/user_provider.dart';
import 'package:emarket/features/items/presentation/widgets/item_card.dart';
import 'package:emarket/features/items/providers/items_provider.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemsAsync = ref.watch(itemStreamProvider);
    final userAsync = ref.watch(currentUserProvider);
    // final items=ref.watch(itemStreamProvider);
    final noContent = Center(child: Text('No items for now'));
    return Scaffold(
      appBar: AppBar(
        title: Text('eMarket'),
        actions: [
          TextButton(
            onPressed: () {
              ref.read(authRepositoryProvider).signOut();
            },
            child: Text('Signout'),
          ),
          ElevatedButton(
            onPressed: () {
              context.push('/postItem');
            },
            child: Text('addItem'),
          ),
        ],
      ),
      body: itemsAsync.when(
        data: (item) {
          return GridView.builder(
            itemCount: item.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) {
              final i = item[index];
              return ItemCard(item: i,);
            },
          );
        },
        error: (error, stack) =>
            Center(child: Text('Error occured displaying items')),
        loading: () =>
            const Center(child: CircularProgressIndicator(strokeWidth: 4)),
      ),
    );
  }
}
