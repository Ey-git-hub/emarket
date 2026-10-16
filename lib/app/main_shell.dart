import 'package:emarket/app/widgets/app_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainShell extends StatelessWidget {
  const MainShell({super.key, required this.child, required this.location});

  final Widget child;
  final String location;

  @override
  Widget build(BuildContext context) {
    final selectedIndex = switch (location) {
      '/favorites' => 1,
      '/postItem' => 2,
      '/profile' => 3,
      _ => 0,
    };

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          child,
          Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(
              top: false,
              minimum: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: PillBar(
                options: const [
                  Option(Icons.home, 'Home'),
                  Option(Icons.favorite, 'Favorites'),
                  Option(Icons.add, 'Add'),
                  Option(Icons.person, 'Profile'),
                ],
                selectedIndex: selectedIndex,
                onSelected: (index) => context.go(_locations[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

const _locations = ['/home', '/favorites', '/postItem', '/profile'];
