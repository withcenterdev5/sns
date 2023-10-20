import 'package:fireflutter/fireflutter.dart';
import 'package:flutter/material.dart';
import 'package:sns/other_widgets/methods.dart';

class CustomChatListTile extends StatelessWidget {
  const CustomChatListTile({
    super.key,
    required this.room,
    required this.onTap,
    this.avatarSize = 24,
  });
  final Room room;
  final double avatarSize;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: room.isSingleChat
          ? UserAvatar(
              uid: room.lastMessage!.uid,
              radius: 16,
              borderWidth: 0,
              borderColor: Colors.grey.shade300,
            )
          : SizedBox(
              width: avatarSize,
              height: avatarSize,
              child: Stack(
                children: [
                  UserAvatar(
                    uid: room.users.last,
                    size: avatarSize / 1.6,
                    radius: 10,
                    borderWidth: 1,
                    borderColor: Colors.grey.shade300,
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: UserAvatar(
                      uid: room.lastMessage?.uid,
                      size: avatarSize / 1.4,
                      radius: 10,
                      borderWidth: 1,
                      borderColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
      title: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            room.isGroupChat
                ? Text(
                    getRenamedRoomForUser(room: room, uid: myUid!),
                    style: Theme.of(context).textTheme.bodyLarge,
                  )
                : UserDoc(
                    uid: otherUserUid(room.users),
                    builder: (_) {
                      return Text(_.name, style: Theme.of(context).textTheme.bodyLarge);
                    },
                  ),
            Text(
              (room.lastMessage?.text ?? '').replaceAll("\n", ' '),
              style: Theme.of(context).textTheme.bodySmall,
              maxLines: 1,
            ),
          ],
        ),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            room.lastMessageTime,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 2),
          NoOfNewMessageBadge(
            room: room,
          ),
        ],
      ),
    );
  }
}
