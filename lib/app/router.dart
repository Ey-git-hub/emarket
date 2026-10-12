import 'package:emarket/features/presentation/home_screen.dart';
import 'package:emarket/features/presentation/login_screen.dart';
import 'package:emarket/features/presentation/signup_screen.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    GoRoute(path: '/signUp', builder: (context, state) => const SignupScreen()),
    GoRoute(path: '/home', builder: (context, state) => HomeScreen()),
  ],
);
