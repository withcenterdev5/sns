import 'package:fireflutter/fireflutter.dart';
import 'package:flutter/material.dart';

class StackFloatingButton extends StatelessWidget {
  const StackFloatingButton({
    super.key,
    required this.onPressed,
    required this.labelIcon,
    this.top,
    this.left,
    this.right,
    this.bottom,
  });
  final VoidCallback onPressed;
  final Widget labelIcon;
  final double? top;
  final double? left;
  final double? right;
  final double? bottom;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: bottom ?? 0,
      right: right ?? 0,
      left: left,
      top: top,
      child: Padding(
        padding: const EdgeInsets.all(sizeSm),
        child: TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateColor.resolveWith((states) => Theme.of(context).colorScheme.primary),
          ),
          onPressed: onPressed,
          child: labelIcon,
        ),
      ),
    );
  }
}
