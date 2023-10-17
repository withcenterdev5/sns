import 'package:fireflutter/fireflutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sns/authentication/login.dart';
import 'package:sns/methods/app.bar.dart';
import 'package:sns/screen/landing.page.dart';
import 'package:sns/screen/user/user.edit.screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => const NoTransitionPage(
        child: Login(),
      ),
    ),
    // try transition here
    GoRoute(
      path: LandingPage.routeName,
      pageBuilder: (context, state) => const MaterialPage<void>(
        child: BodyScreen(),
      ),
    ),
    GoRoute(
      path: '/EditScreen',
      pageBuilder: (context, state) {
        User user = state.extra as User;
        return MaterialPage<void>(
          child: ScaffoldApp(
            child: UpdateUserInfo(user: user),
          ),
        );
      },
    ),
    // GoRoute(
    //   path: '/ResignScreen',
    //   pageBuilder: (context, state) {
    //     User user = state.extra as User;
    //     return MaterialPage<void>(
    //       child: ScaffoldApp(
    //         child: ResignScreen(user: user),
    //       ),
    //     );
    //   },
    // ),
  ],
);

class ScaffoldApp extends StatelessWidget {
  const ScaffoldApp({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: child,
      bottomNavigationBar: const Text('bottomnavbar'),
    );
  }
}
