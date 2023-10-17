import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sns/authentication/login.dart';
import 'package:sns/screen/landing.page.dart';

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
        child: Scaffold(
          body: Center(
            child: Text('screen'),
          ),
        ),
      ),
    ),
  ],
);
