import 'package:emarket/features/auth/providers/auth_provider.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {
            ref.read(authRepositoryProvider).signOut();
          },
          child: Text('Signout'),
        ),
      ),
    );
  }
}
