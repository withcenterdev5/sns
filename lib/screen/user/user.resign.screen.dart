import 'package:fireflutter/fireflutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ResignScreen extends StatefulWidget {
  const ResignScreen({super.key, required this.user});
  final User user;
  @override
  State<ResignScreen> createState() => _ResignScreenState();
}

class _ResignScreenState extends State<ResignScreen> {
  @override
  void initState() {
    super.initState();
    UserService.instance.init(
      onDelete: (user) async {
        await alert(context: context, title: 'Account Deleted!', message: 'Account has been deleted permanently.');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String fullName = '${widget.user.firstName} ${widget.user.lastName}';
    return SizedBox(
      height: 200,
      child: Padding(
        padding: const EdgeInsets.all(sizeMd),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Account Deletion',
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontSize: sizeMd,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: sizeSm),
            Center(
              child: RichText(
                text: TextSpan(
                  text: 'Your Account ',
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(text: fullName, style: const TextStyle(fontWeight: FontWeight.bold)),
                    const TextSpan(text: ' will be deleted.'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: sizeLg),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () async {
                    String? answer = await prompt(
                      context: context,
                      title: 'Delete Account',
                      message: "Type 'confirm' to resign",
                    );
                    if (answer!.toLowerCase() == 'confirm') {
                      widget.user.delete();
                    }
                  },
                  child: Text(
                    'Delete',
                    style: TextStyle(color: Theme.of(context).colorScheme.error),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => context.pop(),
                  child: const Text('Cancel'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
