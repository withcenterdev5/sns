import 'package:fireflutter/fireflutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sns/widgets/methods.dart';

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
  final renameValue = TextEditingController();

  return AppBar(
    forceMaterialTransparency: true,
    leading: IconButton(
      icon: const Icon(Icons.chevron_left),
      onPressed: () => context.pop(),
    ),
    title: room!.isGroupChat
        ? Text(
            getRenamedRoomForUser(uid: myUid!, room: room),
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
        onPressed: () => showDialog(
          context: context,
          builder: (context) => Dialog(
            child: SizedBox(
              height: 200,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(sizeMd, sizeSm, sizeMd, sizeSm),
                child: Column(
                  children: [
                    Text(
                      'Rename Room',
                      style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: sizeMd),
                    ),
                    const SizedBox(height: sizeSm),
                    TextField(
                      controller: renameValue,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter new Name',
                      ),
                    ),
                    const SizedBox(height: sizeXs),
                    ElevatedButton(
                      onPressed: () {
                        ChatService.instance
                            .updateRoomSetting(room: room, setting: 'rename', value: {myUid!: renameValue.text});
                        context.pop();
                        toast(title: 'Chat Renamed', message: 'Chat Room Succesfully Renamed');
                      },
                      child: const Text('Change'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        icon: const Icon(Icons.drive_file_rename_outline_outlined),
      ),
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
