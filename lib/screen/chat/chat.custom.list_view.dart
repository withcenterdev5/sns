import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:fireflutter/fireflutter.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CustomChatRoomController {
  CustomChatRoomState? state;
  showChatRoom({required BuildContext context, User? user, Room? room}) {
    ChatService.instance.showChatRoom(context: context, user: user, room: room);
  }
}

class CustomChatRoom extends StatefulWidget {
  const CustomChatRoom({
    super.key,
    this.controller,
    this.orderBy = 'lastMessage.createdAt',
    this.descending = true,
    this.itemBuilder,
    this.emptyBuilder,
    this.pageSize = 20,
    this.scrollController,
    this.primary,
    this.physics,
    this.shrinkWrap = false,
    this.padding,
    this.dragStartBehavior = DragStartBehavior.start,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.clipBehavior = Clip.hardEdge,
    this.chatRoomAppBarBuilder,
    this.singleChatOnly = false,
    this.groupChatOnly = false,
    this.openChatOnly = false,
    this.allChat = false,
    this.itemExtent = 64,
    this.avatarSize = 46,
    this.scrollDirection = Axis.vertical,
    this.visibility,
    this.onTap,
    this.tileBuilder,
  }) : assert(itemExtent == null || visibility == null, "You can't set both itemExtent and visibility");

  final Widget Function(BuildContext context, Room room)? tileBuilder;
  final CustomChatRoomController? controller;
  final String orderBy;
  final bool descending;
  final int pageSize;
  final Widget Function(BuildContext, Room)? itemBuilder;
  final Widget Function(BuildContext)? emptyBuilder;
  final ScrollController? scrollController;
  final bool? primary;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final EdgeInsetsGeometry? padding;

  final DragStartBehavior dragStartBehavior;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;
  final Clip clipBehavior;

  final bool singleChatOnly;
  final bool groupChatOnly;
  final bool openChatOnly;

  final bool allChat;

  final double? itemExtent;

  final double avatarSize;

  final Axis scrollDirection;

  final bool Function(Room)? visibility;

  final Function(Room)? onTap;
  final PreferredSizeWidget Function(BuildContext, Room)? chatRoomAppBarBuilder;

  @override
  State<CustomChatRoom> createState() => CustomChatRoomState();
}

class CustomChatRoomState extends State<CustomChatRoom> {
  @override
  void initState() {
    super.initState();
    widget.controller?.state = this;
  }

  Query get query {
    Query q = chatCol;

    if (widget.allChat) {
    } else if (widget.openChatOnly == true) {
      q = q.where('open', isEqualTo: true);
    } else {
      q = q.where('users', arrayContains: myUid!);

      if (widget.singleChatOnly == true) {
        q = q.where('group', isEqualTo: false);
      } else if (widget.groupChatOnly == true) {
        q = q.where('group', isEqualTo: true);
      }
    }

    q = q.orderBy(widget.orderBy, descending: widget.descending);
    return q;
  }

  @override
  Widget build(BuildContext context) {
    if (loggedIn == false) {
      return Center(child: Text(tr.loginFirstMessage));
    }

    return FirestoreListView(
      query: query,
      itemExtent: widget.itemExtent,
      itemBuilder: (context, QueryDocumentSnapshot snapshot) {
        final room = Room.fromDocumentSnapshot(snapshot);

        if (widget.visibility != null && widget.visibility!(room) == false) {
          return const SizedBox();
        }
        if (widget.itemBuilder != null) {
          return widget.itemBuilder!(context, room);
        } else {
          return room.isSingleChat
              ? UserBlocked(
                  otherUid: room.otherUserUid,
                  blockedBuilder: (context) {
                    return const Text("*** Blocked ***");
                  },
                  notBlockedBuilder: (context) {
                    return ChatRoomListTile(
                      key: ValueKey(room.roomId),
                      room: room,
                      avatarSize: widget.avatarSize,
                      onTap: () {
                        widget.onTap?.call(room) ?? ChatService.instance.showChatRoom(context: context, room: room);
                      },
                    );
                  },
                )
              : chatRoomListTile(room, context);
        }
      },
      emptyBuilder: (context) {
        if (widget.emptyBuilder != null) {
          return widget.emptyBuilder!(context);
        } else {
          return Center(child: Text(tr.noChatRooms));
        }
      },
      errorBuilder: (context, error, stackTrace) {
        return Center(child: Text('Error loading chat rooms $error'));
      },
      loadingBuilder: (context) => const Center(child: CircularProgressIndicator()),
      pageSize: widget.pageSize,
      controller: widget.scrollController,
      primary: widget.primary,
      physics: widget.physics,
      shrinkWrap: widget.shrinkWrap,
      padding: widget.padding,
      dragStartBehavior: widget.dragStartBehavior,
      keyboardDismissBehavior: widget.keyboardDismissBehavior,
      clipBehavior: widget.clipBehavior,
      scrollDirection: widget.scrollDirection,
    );
  }

  Widget chatRoomListTile(Room room, BuildContext context) {
    return widget.tileBuilder?.call(context, room) ??
        ChatRoomListTile(
          key: ValueKey(room.roomId),
          room: room,
          avatarSize: widget.avatarSize,
          onTap: () {
            widget.onTap?.call(room) ?? ChatService.instance.showChatRoom(context: context, room: room);
          },
        );
  }
}
