import 'package:emarket/features/auth/providers/auth_provider.dart';
import 'package:emarket/features/auth/providers/user_provider.dart';
import 'package:emarket/features/items/presentation/widgets/item_card.dart';
import 'package:emarket/features/items/providers/items_provider.dart';
import 'package:emarket/features/presentation/widgets/modal_content.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});
  @override
  ConsumerState<HomeScreen> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final _searchController = TextEditingController();
  String _query = '';
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final itemsAsync = ref.watch(itemStreamProvider);
    // final userAsync = ref.watch(currentUserProvider);
    // final noContent = Center(child: Text('No items for now'));
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'eMarket',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search items',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: _query.isEmpty
                          ? null
                          : IconButton(
                              onPressed: () {
                                _searchController.clear();
                                setState(() {
                                  _query = '';
                                });
                              },
                              icon: const Icon(Icons.clear),
                            ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(28),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Theme.of(context)
                          .colorScheme
                          .surfaceContainerHighest,
                    ),
                    onChanged: (value) => setState(() {
                      _query = value.trim().toLowerCase();
                    }),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    showDragHandle: true,
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    builder: (context) {
                      return FractionallySizedBox(
                        heightFactor: 0.6,
                        child: Padding(
                          padding: const EdgeInsets.all(12).copyWith(left: 0),
                          child: const ModalContent()
                        ),
                      );
                    },
                  );
                },
                icon: Icon(Icons.tune),
              ),
            ],
          ),
          Expanded(
            child: itemsAsync.when(
              data: (item) {
                return GridView.builder(
                  itemCount: item.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.75,
                  ),
                  padding: const EdgeInsets.all(12),
                  itemBuilder: (context, index) {
                    final i = item[index];
                    return ItemCard(item: i);
                  },
                );
              },
              error: (error, stack) =>
                  Center(child: Text('Error occured displaying items')),
              loading: () => const Center(
                child: CircularProgressIndicator(strokeWidth: 4),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
