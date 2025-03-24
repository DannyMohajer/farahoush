import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomNormalButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  const CustomNormalButton({
    super.key,
    required this.child,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      minSize: 0.0,
      child: Material(
        color: Colors.transparent,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        child: child,
      ),
    );
  }
}
