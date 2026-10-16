import 'package:emarket/app/main_shell.dart';
import 'package:emarket/features/auth/providers/auth_provider.dart';
import 'package:emarket/features/items/presentation/post_items_screen.dart';
import 'package:emarket/features/items/domain/items.dart';
import 'package:emarket/features/presentation/favorites/favorites_screen.dart';
import 'package:emarket/features/presentation/home/home_screen.dart';
import 'package:emarket/features/presentation/home/item_details_screen.dart';
import 'package:emarket/features/presentation/login_screen.dart';
import 'package:emarket/features/presentation/profile/user_profile_screen.dart';
import 'package:emarket/features/presentation/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final refereshNotifier = ValueNotifier<int>(0);
  ref.listen(authStateProvider, ((previous, next) {
    refereshNotifier.value++;
  }));
  ref.onDispose(refereshNotifier.dispose);
  return GoRouter(
    initialLocation: '/login',
    refreshListenable: refereshNotifier,
    redirect: (context, state) {
      final authState = ref.read(authStateProvider);
      if (authState.isLoading) return null;
      final isSignedIn = authState.value != null;
      final location = state.matchedLocation;
      final onAuthPage = location == '/login' || location == '/signUp';
      if (!isSignedIn && !onAuthPage) return '/login';
      if (isSignedIn && onAuthPage) return '/home';
      return null;
    },
    routes: [
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: '/signUp',
        builder: (context, state) => const SignupScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) =>
            MainShell(location: state.uri.path, child: child),
        routes: [
          GoRoute(
            path: '/home',
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: '/favorites',
            builder: (context, state) => const FavoritesScreen(),
          ),
          GoRoute(
            path: '/postItem',
            builder: (context, state) => const PostItemsScreen(),
          ),
          GoRoute(
            path: '/profile',
            builder: (context, state) => const UserProfileScreen(),
          ),
        ],
      ),
      GoRoute(
        path: '/itemdetails',
        builder: (context, state) {
          final item = state.extra as Item;
          return ItemDetailsScreen(item: item);
        },
      ),
    ],
  );
});
