import 'package:fireflutter/fireflutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
                onTap: (user) => setState(() {
                  uids.add(user.uid);
                }),
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
                    uids.add(myUid!);
                    final roomId = chatCol.doc().id;
                    debugPrint(roomId);
                    final roomData = Room.toCreate(
                      name: roomName.text,
                      roomId: roomId,
                      master: myUid!,
                      group: true,
                      open: true,
                      users: uids,
                    );
                    await Room.doc(roomId).set(roomData);
                    await ChatService.instance.sendProtocolMessage(
                      room: Room.fromJson(roomData),
                      protocol: Protocol.chatRoomCreated.name,
                      text: tr.chatRoomCreateDialog,
                    );
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
                  uids.remove(uids[index]);
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
