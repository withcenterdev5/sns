import 'package:fireflutter/fireflutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

PreferredSizeWidget appBar(BuildContext context) {
  return AppBar(
    title: const Text('appbar'),
    actions: [
      TextButton(
        onPressed: () {
          UserService.instance.signOut();
          context.go('/');
        },
        child: const Text('Sign Out'),
      ),
    ],
  );
}
