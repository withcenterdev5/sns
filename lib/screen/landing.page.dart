import 'package:fireflutter/fireflutter.dart';
import 'package:flutter/material.dart';
import 'package:sns/widgets/methods.dart';
import 'package:sns/widgets/app.bar.dart';
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
  const BodyScreen({super.key, this.index});
  final int? index;
  @override
  State<BodyScreen> createState() => _BodyScreenState();
}

class _BodyScreenState extends State<BodyScreen> {
  int index = 1;
  late Widget widgetChild;
  @override
  void initState() {
    super.initState();
    mainInit();
    createUser();
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.index ?? index) {
      case 0:
        widgetChild = const PostScreen();
        break;
      case 1:
        widgetChild = const ChatList();
        break;
      case 2:
        widgetChild = const UserScreen();
        break;
    }
    return Scaffold(
      appBar: appBar(context),
      body: UserDoc(
        live: false,
        builder: (user) => Stack(
          children: [
            widgetChild,
            if (user.isComplete == false)
              Container(
                height: 40,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.error,
                ),
                child: Center(
                  child: Text(
                    "Account is incomplete. Complete profile to use the app fully.",
                    style: TextStyle(color: Theme.of(context).colorScheme.onError, fontSize: sizeSm - 3),
                  ),
                ),
              ),
          ],
        ),
      ),
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
