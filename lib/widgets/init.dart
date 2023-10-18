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
