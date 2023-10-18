import 'package:fireflutter/fireflutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sns/screen/user/user.resign.screen.dart';

class UpdateUserInfo extends StatefulWidget {
  const UpdateUserInfo({super.key, required this.user});
  final User user;
  @override
  State<UpdateUserInfo> createState() => _UpdateUserInfoState();
}

class _UpdateUserInfoState extends State<UpdateUserInfo> {
  final firstName = TextEditingController();
  final midName = TextEditingController();
  final lastName = TextEditingController();
  final displayName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(sizeSm),
      child: Column(
        children: [
          UserProfileAvatar(
            user: widget.user,
            radius: sizeSm,
            upload: true,
          ),
          const SizedBox(height: sizeSm),
          fullNameCard(),
          const SizedBox(height: sizeSm),
          ElevatedButton(
            onPressed: () {
              widget.user
                  .update(
                isComplete: true,
                firstName: firstName.text,
                middleName: midName.text,
                lastName: lastName.text,
                displayName: displayName.text,
              )
                  .then((value) {
                toast(title: 'Account Updated', message: 'Account successfully updated');
                context.pop();
              });
            },
            child: const Text('Update'),
          ),
          TextButton(
            onPressed: () => showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  child: ResignScreen(user: widget.user),
                );
              },
            ),
            child: Text(
              'Delete Profile',
              style: TextStyle(
                color: Theme.of(context).colorScheme.error,
                fontSize: sizeXs + 4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  SizedBox fullNameCard() {
    return SizedBox(
      height: 280,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(sizeSm),
          child: Column(
            children: [
              const Text('Full Name'),
              InputField(controller: firstName, label: 'First Name'),
              InputField(controller: midName, label: 'Middle Name'),
              InputField(controller: lastName, label: 'Last Name'),
              InputField(controller: displayName, label: 'Display Name'),
            ],
          ),
        ),
      ),
    );
  }
}

class InputField extends StatelessWidget {
  const InputField({super.key, required this.controller, this.onChange, required this.label});

  final TextEditingController controller;
  final Function(String)? onChange;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        decoration: InputDecoration(
          label: Text(label),
        ),
        controller: controller,
        onChanged: onChange,
      ),
    );
  }
}
