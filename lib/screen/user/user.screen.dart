import 'package:fireflutter/fireflutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MyDoc(builder: (user) {
      return Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(sizeLg),
            child: Column(
              children: [
                Row(
                  children: [
                    UserAvatar(user: user, size: 80),
                    TextButton(
                      onPressed: () => context.push('/EditScreen', extra: user),
                      child: const Text('Edit Profile'),
                    ),
                  ],
                ),
              ],
            ),
          ),
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
      );
    });
  }
}
