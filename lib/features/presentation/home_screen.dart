import 'package:emarket/features/auth/providers/auth_provider.dart';
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
    return Scaffold(
      body: Center(

        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              itemsAsync.when(
                data: (data) => Text('Items: ${data.length}'),
                error: (Object error, StackTrace stackTrace) {
                  return Text('error $error');
                },
                loading: () {
                  return CircularProgressIndicator();
                },
              ),
              TextButton(
                onPressed: () {
                  ref.read(authRepositoryProvider).signOut();
                },
                child: Text('Signout'),
              ),
              ElevatedButton(onPressed: (){
                context.push('/postItem');
              }, child: Text('addItem'))
            ],
          ),
        ),
      ),
    );
  }
}
