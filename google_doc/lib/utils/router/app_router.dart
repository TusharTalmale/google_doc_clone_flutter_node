import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_doc/provider/auth_controller.dart';
import 'package:google_doc/screens/screens.dart';
import 'package:google_doc/utils/router/route_constants.dart';
import 'package:google_doc/widgets/layout/app_shell.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  final authController = ref.watch(authControllerProvider);
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final isLoggedIn = authController.value != null;
      final isAuthRoute =
          state.matchedLocation.startsWith('/login') ||
          state.matchedLocation.startsWith('/register');
      if (!isLoggedIn && !isAuthRoute) {
        return '/login';
      }
      if (isLoggedIn && isAuthRoute) {
        return '/home';
      }
      if (state.matchedLocation.startsWith('/public')) {
        return null;
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/auth',
        redirect: (context, state) => '/auth/login',
        routes: [
          GoRoute(
            path: 'login',
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const Center(child: Text('login')),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                    return FadeTransition(opacity: animation, child: child);
                  },
            ),
          ),
          GoRoute(
            path: 'register',
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const Center(child: Text('register')),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                    return FadeTransition(opacity: animation, child: child);
                  },
            ),
          ),
        ],
      ),

      // Main App Shell (with sidebar)
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        pageBuilder: (context, state, child) => CustomTransitionPage(
          key: state.pageKey,
          child: AppShell(child: child),
          transitionsBuilder: _buildFadeTransition,
        ),

        routes: [
          GoRoute(
            path: '/',
            pageBuilder: (context, state) =>
                NoTransitionPage(child: HomeScreen()),
          ),
          GoRoute(
            path: '/trash',
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: TrashScreen(),

              transitionsBuilder: _buildFadeTransition,
            ),
          ),
          // GoRoute(
          //   path:'/settings',
          //   pageBuilder: (context, state) =>
          //       NoTransitionPage(child: SettingsScreen()),
          // ),
          // GoRoute(
          //   path:'/about',
          //   pageBuilder: (context, state) =>
          //       NoTransitionPage(child: AboutScreen()),
          // ),
          // GoRoute(
          //   path:'/privacy',
          //   pageBuilder: (context, state) =>
          //       NoTransitionPage(child: PrivacyScreen()),
          // ),
          GoRoute(
            path: '/shared',
            pageBuilder: (context, state) => CustomTransitionPage(
              child: SharedWithMeScreen(),
              transitionsBuilder: _buildFadeTransition,
            ),
          ),
        ],
      ),
      GoRoute(
        path: '/doc/:id',
        pageBuilder: (context, state) {
          final docId = state.pathParameters['id']!;
          final isPublic = state.uri.queryParameters.containsKey('token');

          return CustomTransitionPage(
            key: state.pageKey,
            child: EditorScreen(
              documentId: docId,
              isPublic: isPublic,
              publicToken: state.uri.queryParameters['token'],
            ),
            transitionsBuilder: _buildSharedAxisTransition,
            fullscreenDialog: true,
          );
        },
      ),
      GoRoute(
        path: '/public/:id',
        redirect: (context, state) =>
            '/doc/${state.pathParameters['id']}?${state.uri.query}',
      ),
    ],
    errorPageBuilder: (context, state) =>
        MaterialPage(child: ErrorScreen(error: state.error)),
  );
});

Widget _buildFadeTransition(context, animation, secondaryAnimation, child) {
  return FadeTransition(opacity: animation, child: child);
}

Widget _buildSlideTransition(context, animation, secondaryAnimation, child) {
  const begin = Offset(1.0, 0.0);
  const end = Offset.zero;
  const curve = Curves.easeInOutCubic;

  var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
  var offsetAnimation = animation.drive(tween);

  return SlideTransition(position: offsetAnimation, child: child);
}

Widget _buildSharedAxisTransition(
  context,
  animation,
  secondaryAnimation,
  child,
) {
  return SharedAxisTransition(
    animation: animation,
    secondaryAnimation: secondaryAnimation,
    transitionType: SharedAxisTransitionType.horizontal,
    child: child,
  );
}
