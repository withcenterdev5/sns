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

// custom app bar for chat room
AppBar customAppBar(BuildContext context, Room? room) {
  return AppBar(
    forceMaterialTransparency: true,
    leading: IconButton(
      icon: const Icon(Icons.chevron_left),
      onPressed: () => context.pop(),
    ),
    title: room!.isGroupChat
        ? Text(
            room.name,
            style: TextStyle(
              color: Theme.of(context).shadowColor,
            ),
          )
        : UserDoc(
            builder: (user) => Text(
              user.name,
              style: TextStyle(
                color: Theme.of(context).shadowColor,
              ),
            ),
            uid: otherUserUid(room.users),
            live: false,
          ),
    actions: [
      IconButton(
        icon: Icon(
          Icons.settings,
          color: Theme.of(context).shadowColor,
        ),
        onPressed: () async {
          return showDialog(
            context: context,
            builder: ((context) {
              return Theme(
                data: ThemeData(
                  appBarTheme: AppBarTheme(
                      backgroundColor: Theme.of(context).canvasColor,
                      iconTheme: IconThemeData(
                        color: Theme.of(context).shadowColor,
                      ),
                      elevation: 0),
                ),
                child: ChatRoomMenuScreen(room: room),
              );
            }),
          );
        },
      ),
    ],
  );
}
