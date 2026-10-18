import 'package:emarket/features/auth/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserProfileScreen extends ConsumerStatefulWidget {
  const UserProfileScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _UserProfileScreenState();
  }
}

class _UserProfileScreenState extends ConsumerState<UserProfileScreen> {
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  // final Controller=TextEditingController();
  void _update() {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }
  }

  void init() {}
  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authRepositoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              auth.signOut();
            },
            icon: Icon(Icons.exit_to_app_sharp),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Enter your name';
                      }

                      return null;
                    },
                  ),
                  SizedBox(height: 12),
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'current password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Enter your current password';
                      }

                      return null;
                    },
                  ),
                  SizedBox(height: 12),
                  TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      labelText: 'New Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Enter your new password';
                      }

                      return null;
                    },
                  ),

                  SizedBox(height: 12),
                  TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Enter your new Password';
                      }

                      return null;
                    },
                  ),
                  SizedBox(height: 8),
                  ElevatedButton(onPressed: _update, child: Text('Update')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
