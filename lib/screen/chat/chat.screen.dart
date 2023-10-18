import 'package:fireflutter/fireflutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sns/widgets/app.bar.dart';
import 'package:sns/widgets/init.dart';
import 'package:sns/screen/chat/chat.custom.create.dart';
import 'package:sns/widgets/stack.floating.dart';

class ChatList extends StatefulWidget {
  const ChatList({super.key});

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  @override
  void initState() {
    super.initState();

    ChatService.instance.init(
      customize: ChatCustomize(
        showChatRoom: ({required context, room, user}) {
          if (isUserCompleted(context)) {
            showGeneralDialog(
              context: context,
              pageBuilder: (context, _, __) => ChatRoomScreen(room: room),
            );
          }
        },
        chatRoomAppBarBuilder: ({room, user}) => customAppBar(context, room),
      ),
    );
  }

  final chatListViewController = ChatRoomListViewController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: ChatRoomListView(
                controller: chatListViewController,
                singleChatOnly: false,
                itemBuilder: (context, room) => ChatRoomListTile(
                  room: room,
                  onTap: () {
                    chatListViewController.showChatRoom(context: context, room: room);
                  },
                ),
              ),
            ),
          ],
        ),
        StackFloatingButton(
          labelIcon: Text(
            'New Chat',
            style: TextStyle(color: Theme.of(context).colorScheme.background),
          ),
          onPressed: () {
            if (isUserCompleted(context)) {
              showDialog(
                context: context,
                builder: (context) => Dialog(
                  child: CustomCreateDialog(
                    success: (room) => ChatService.instance.showChatRoom(room: room, context: context),
                    cancel: () => context.pop(),
                  ),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
