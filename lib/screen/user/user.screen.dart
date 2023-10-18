import 'package:fireflutter/fireflutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sns/screen/user/user.info.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  void initState() {
    super.initState();
    // UserService.instance.customize.showPublicProfileScreen =(context, {uid, user}) =>
  }

  @override
  Widget build(BuildContext context) {
    return MyDoc(
      builder: (user) {
        return Padding(
          padding: const EdgeInsets.all(sizeLg),
          child: Column(
            children: [
              Column(
                children: [
                  UserAvatar(user: user, size: 80),
                  TextButton(
                    onPressed: () => context.push('/EditScreen', extra: user),
                    child: const Text('Edit Profile'),
                  ),
                  TextButton(
                    onPressed: () {
                      showGeneralDialog(
                        context: context,
                        pageBuilder: (context, _, __) => PublicProfileScreen(
                          uid: myUid,
                        ),
                      );
                    },
                    child: const Text('Public Profile'),
                  ),
                ],
              ),
              if (user.isComplete == true) ...[
                UserInformations(user: user),
              ]
            ],
          ),
        );
      },
    );
  }
}
