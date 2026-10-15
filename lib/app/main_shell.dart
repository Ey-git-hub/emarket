import 'package:emarket/features/items/presentation/post_items_screen.dart';
import 'package:emarket/features/presentation/favorites/favorites_screen.dart';
import 'package:emarket/features/presentation/home/home_screen.dart';
import 'package:emarket/features/presentation/profile/user_profile_screen.dart';
import 'package:flutter/material.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MainShellState();
  }
}

class _MainShellState extends State<MainShell> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('Main shell')),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          HomeScreen(),
          FavoritesScreen(),
          PostItemsScreen(),
          UserProfileScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        // selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        // backgroundColor:  Colors.orange,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'favorites',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
