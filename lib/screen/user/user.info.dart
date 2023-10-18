import 'package:fireflutter/fireflutter.dart';
import 'package:flutter/material.dart';

class UserInformations extends StatelessWidget {
  const UserInformations({
    super.key,
    required this.user,
  });

  final User user;

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
                BasicField(label: 'firstName', value: user.firstName),
                BasicField(label: 'middleName', value: user.middleName),
                BasicField(label: 'lastName', value: user.lastName),
                BasicField(label: 'displayName', value: user.displayName),
              ],
            ),
          ),
          const Text(
            'Other Users',
          ),
          const Divider(),
          Expanded(
            child: UserListView(
              field: 'firstName',
              titleBuilder: (user) => Text('${user.firstName} ${user.lastName}'),
              subtitleBuilder: (user) => const Text('Show blocked or unblocked here'),
              onTap: (user) => UserService.instance.showPublicProfileScreen(context: context, user: user),
              trailingBuilder: (user) => TextButton(
                onPressed: () async {
                  final blocked = await toggle(pathBlock(user.uid));
                  toast(
                      title: blocked ? 'Blocked' : 'Unblocked',
                      message: 'The user has been ${blocked ? 'blocked' : 'unblocked'} by you');
                },
                child: Database(
                  path: pathBlock(user.uid),
                  builder: (value, string) => Text(value == null ? 'Block' : 'Unblock'),
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
