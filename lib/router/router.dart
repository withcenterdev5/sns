import 'package:fireflutter/fireflutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sns/authentication/login.dart';
import 'package:sns/main.dart';
import 'package:sns/other_widgets/app.bar.dart';
import 'package:sns/screen/landing.page.dart';
import 'package:sns/screen/user/user.edit.screen.dart';

late User user;

final router = GoRouter(
  routes: [
    GoRoute(
      path: MainApp.routeName,
      pageBuilder: (context, state) => const NoTransitionPage(
        child: Login(),
      ),
    ),
    GoRoute(
      path: LandingPage.routeName,
      pageBuilder: (context, state) {
        int? index = state.extra as int?;
        return MaterialPage<void>(
          child: BodyScreen(index: index),
        );
      },
    ),
    // try transition here

    GoRoute(
      path: '/EditScreen',
      pageBuilder: (context, state) {
        user = state.extra as User;
        return MaterialPage<void>(
          child: ScaffoldApp(
            child: UpdateUserInfo(user: user),
          ),
        );
      },
    ),
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
