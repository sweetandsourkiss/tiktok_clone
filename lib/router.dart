import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/features/authentication/sign_up_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: SignUpScreen.routeURL,
      name: SignUpScreen.routeName,
      builder: (context, state) => const SignUpScreen(),
    ),
  ],
);
