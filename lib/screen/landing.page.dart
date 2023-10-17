import 'package:flutter/material.dart';
import 'package:sns/router/router.dart';

class LandingPage extends StatefulWidget {
  static const String routeName = '/LandingPage';
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
    );
  }
}
