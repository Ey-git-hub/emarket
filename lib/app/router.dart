import 'package:emarket/app/main_shell.dart';
import 'package:emarket/features/auth/providers/auth_provider.dart';
import 'package:emarket/features/items/presentation/post_items_screen.dart';
import 'package:emarket/features/items/domain/items.dart';
// import 'package:emarket/features/presentation/home/home_screen.dart';
import 'package:emarket/features/presentation/home/item_details_screen.dart';
// import 'package:emarket/features/presentation/item_details_screen.dart';
import 'package:emarket/features/presentation/login_screen.dart';
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
      GoRoute(path: '/home', builder: (context, state) => MainShell()),
      GoRoute(
        path: '/postItem',
        builder: (context, state) => PostItemsScreen(),
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
