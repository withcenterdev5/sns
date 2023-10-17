import 'package:fireflutter/fireflutter.dart';

createUser() async {
  User? userDoc = await User.get(myUid);
  if (userDoc == null) {
    User.create(uid: myUid!);
  }
}
