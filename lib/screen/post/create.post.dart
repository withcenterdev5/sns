import 'package:fireflutter/fireflutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PostCreate extends StatefulWidget {
  const PostCreate({super.key});

  @override
  State<PostCreate> createState() => _PostCreateState();
}

class _PostCreateState extends State<PostCreate> {
  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}

class InputFields extends StatelessWidget {
  const InputFields({
    super.key,
    required this.controller,
    required this.hintText,
    this.isContent = false,
  });
  final String hintText;
  final TextEditingController controller;
  final bool isContent;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: isContent ? 5 : 1,
      decoration: InputDecoration(
        hintText: hintText,
      ),
    );
  }
}

class PostField extends StatelessWidget {
  const PostField({
    super.key,
    required this.onTap,
  });

  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(sizeLg),
        onTap: onTap,
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(
              width: .5,
            ),
            borderRadius: BorderRadius.circular(sizeLg),
          ),
          child: const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: sizeSm),
              child: Text("What's on your mind?"),
            ),
          ),
        ),
      ),
    );
  }
}
