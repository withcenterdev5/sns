import 'package:flutter/material.dart';
import 'package:sns/init.dart';
import 'package:sns/methods/app.bar.dart';
import 'package:sns/router/router.dart';
import 'package:sns/screen/chat/chat.screen.dart';
import 'package:sns/screen/post/post.screen.dart';
import 'package:sns/screen/user/user.screen.dart';

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

class BodyScreen extends StatefulWidget {
  const BodyScreen({super.key});

  @override
  State<BodyScreen> createState() => _BodyScreenState();
}

class _BodyScreenState extends State<BodyScreen> {
  @override
  void initState() {
    super.initState();
    createUser();
  }

  int index = 2;
  late Widget child;
  @override
  Widget build(BuildContext context) {
    switch (index) {
      case 0:
        child = const PostScreen();
        break;
      case 1:
        child = const ChatList();
        break;
      case 2:
        child = const UserScreen();
        break;
    }
    return Scaffold(
      appBar: appBar(context),
      body: child,
      bottomNavigationBar: bottomNav(),
    );
  }

  Widget bottomNav() {
    return BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      currentIndex: index,
      onTap: (value) => setState(() {
        index = value;
      }),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.feed_outlined),
          activeIcon: Icon(Icons.feed),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.message_outlined),
          label: '',
          activeIcon: Icon(Icons.message),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_4_outlined),
          label: '',
          activeIcon: Icon(Icons.person_4),
        ),
      ],
    );
  }
}
