import 'package:fireflutter/fireflutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sns/other_widgets/methods.dart';

class CustomCreateDialog extends StatefulWidget {
  const CustomCreateDialog({
    super.key,
    required this.cancel,
    required this.success,
  });

  final void Function(Room room) success;
  final void Function() cancel;

  @override
  State<CustomCreateDialog> createState() => _CustomCreateDialogState();
}

class _CustomCreateDialogState extends State<CustomCreateDialog> {
  List<String> uids = [];
  List<String> exemptedUsers = [myUid!];
  final roomName = TextEditingController();

  @override
  void initState() {
    super.initState();
    ChatService.instance.init(
      customize: ChatCustomize(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(sizeSm),
      child: SizedBox(
        height: 600,
        child: Column(
          children: [
            Text(
              'Create Chat Room',
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontSize: sizeMd,
                  ),
            ),
            const SizedBox(height: sizeSm),
            TextField(
              controller: roomName,
              decoration: const InputDecoration(
                label: Text(
                  'Room Name',
                ),
              ),
            ),
            const SizedBox(height: sizeMd),
            addedUserList(),
            const SizedBox(height: sizeMd),
            Text(
              'Add Users',
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontSize: sizeSm,
                  ),
            ),
            const Divider(thickness: 2, endIndent: sizeLg, indent: sizeLg),
            Expanded(
              child: UserListView(
                // not rebuilding, back on this
                exemptedUsers: exemptedUsers,
                onTap: (user) => setState(
                  () {
                    uids.add(user.uid);
                    exemptedUsers.add(user.uid);
                  },
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => context.pop(),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (uids.length == 1) {
                      final createdRoom = await Room.create(
                        otherUserUid: uids[0],
                        open: true,
                      );
                      widget.success(createdRoom);
                    }
                    final roomData = await createRoom(uids, roomName.text);
                    Room room = Room.fromJson(roomData);
                    widget.success(room);
                    if (context.mounted) {
                      context.pop();
                    }
                  },
                  child: const Text('Create'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  SizedBox addedUserList() {
    return SizedBox(
      height: 50,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: uids.length,
        separatorBuilder: (context, index) => const SizedBox(width: sizeSm),
        itemBuilder: (context, index) => Stack(
          clipBehavior: Clip.none,
          children: [
            UserAvatar(
              uid: uids[index],
              size: sizeXxl,
            ),
            Positioned(
              top: -20,
              right: -20,
              child: IconButton(
                onPressed: () => setState(() {
                  if (uids.isNotEmpty && exemptedUsers.isNotEmpty) {
                    exemptedUsers.remove(uids[index]);
                    uids.remove(uids[index]);
                  }
                }),
                icon: Icon(
                  Icons.cancel,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
