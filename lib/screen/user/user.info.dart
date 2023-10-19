import 'package:fireflutter/fireflutter.dart';
import 'package:flutter/material.dart';

class UserInformations extends StatefulWidget {
  const UserInformations({
    super.key,
  });

  @override
  State<UserInformations> createState() => _UserInformationsState();
}

class _UserInformationsState extends State<UserInformations> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          const Text('Basic Info'),
          const Divider(),
          SingleChildScrollView(
            child: Column(
              children: [
                BasicField(label: 'firstName', value: my!.firstName),
                BasicField(label: 'middleName', value: my!.middleName),
                BasicField(label: 'lastName', value: my!.lastName),
                BasicField(label: 'displayName', value: my!.displayName),
              ],
            ),
          ),
          const Text(
            'Other Users',
          ),
          const Divider(),
          Expanded(
            child: UserListView(
              exemptedUsers: [myUid!],
              titleBuilder: (user) => Text('${user.firstName} ${user.lastName}'),
              subtitleBuilder: (user) => Text(user.displayName),
              onTap: (user) => UserService.instance.showPublicProfileScreen(context: context, user: user),
              trailingBuilder: (user) => TextButton(
                onPressed: () async {
                  final isBlock = my!.hasBlocked(user.uid);
                  if (isBlock) {
                    my!.unblock(user.uid);
                    return;
                  }
                  my!.block(user.uid);
                  return;
                },
                child: UserBlocked(
                  otherUser: user,
                  blockedBuilder: (context) => const Text('Unblock'),
                  notBlockedBuilder: (context) => const Text('Block'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BasicField extends StatelessWidget {
  const BasicField({
    super.key,
    required this.label,
    required this.value,
  });
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
        ),
        const Text(' : '),
        Text(value),
      ],
    );
  }
}
