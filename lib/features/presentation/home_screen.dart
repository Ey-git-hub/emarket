import 'package:emarket/features/auth/providers/auth_provider.dart';
import 'package:emarket/features/auth/providers/user_provider.dart';
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
    final noContent=Center(child: Text('No items for now'),);
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
      body: Padding(
        padding: EdgeInsets.all(3),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              itemsAsync.when(
                data: (item) {
                  return GridView.builder(
                    itemCount: item.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemBuilder: ((context, index) {
                      final i = item[index];
                      return Card(
                        child: 
                          Text(
                            i.name,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        
                      );
                    }),
                  );
                },
                error: (error, stack) => Text('Error $error'),
                loading: () =>
                    Center(child: CircularProgressIndicator(strokeWidth: 4)),
              ),

              // itemsAsync.when(
              //   data: (data) => Text('Items: ${data.length}'),
              //   error: (Object error, StackTrace stackTrace) {
              //     return Text('error $error');
              //   },

              //   loading: () {
              //     return CircularProgressIndicator();
              //   },
              // ),
              // userAsync.when(
              //   data: (user) => Text('Hello, ${user?.name ?? 'no profile'}'),
              //   loading: () => const CircularProgressIndicator(),
              //   error: (e, st) => Text('Error: $e'),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
