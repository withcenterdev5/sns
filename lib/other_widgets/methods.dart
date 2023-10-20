import 'package:fireflutter/fireflutter.dart';
import 'package:flutter/material.dart';

createUser() async {
  User? userDoc = await User.get(myUid);
  if (userDoc == null) {
    User.create(uid: myUid!);
  }
}

accountIsDeleted() async {
  var test = await UserService.instance.get(myUid ?? '');
  debugPrint('$test');
}

bool isUserCompleted(BuildContext context) {
  bool isComplete = my!.isComplete;
  if (isComplete == false) {
    toast(
      title: 'Incomplete Profile',
      message: 'Complete your profile to use this feature',
      backgroundColor: Theme.of(context).colorScheme.onErrorContainer,
    );
  }
  return isComplete;
}

mainInit() {
  UserService.instance.init();
  ChatService.instance.init();
  PostService.instance.init();
}

createRoom(List<String> uids, String roomName) async {
  uids.add(myUid!);
  final roomId = chatCol.doc().id;
  debugPrint(roomId);
  final roomData = Room.toCreate(
    name: roomName,
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
  return roomData;
}

getRenamedRoomForUser({required String uid, required Room room}) {
  var renameList = room.rename;
  String userValue = '';
  renameList.forEach((k, v) {
    if (k == myUid) {
      userValue = v;
    }
  });
  return userValue;
}
