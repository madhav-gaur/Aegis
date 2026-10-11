import 'package:aegis/router/routes.dart';
import 'package:aegis/screens/app.dart';
import 'package:aegis/screens/signin.dart';
import 'package:aegis/screens/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  redirect: (context, state) {
    final user = FirebaseAuth.instance.currentUser;
    final isLoggedIn = user != null;

    final isAuthPage =
        state.matchedLocation == AppRoutes.signup ||
        state.matchedLocation == AppRoutes.signin;

    if (!isLoggedIn && !isAuthPage) {
      return AppRoutes.signup;
    }

    if (isLoggedIn && isAuthPage) {
      return AppRoutes.app;
    }

    return null;
  },
  routes: [
    GoRoute(path: AppRoutes.app, builder: (context, state) => const App()),
    GoRoute(
      path: AppRoutes.signup,
      builder: (context, state) => const Signup(),
    ),
    GoRoute(
      path: AppRoutes.signin,
      builder: (context, state) => const SignIn(),
    ),
  ],
);
