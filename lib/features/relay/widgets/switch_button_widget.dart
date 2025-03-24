import 'package:farahoush/common/widgets/buttons/custom_normal_button.dart';
import 'package:flutter/material.dart';

class SwitchButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  const SwitchButtonWidget({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return CustomNormalButton(
      onPressed: onPressed,
      child: Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.only(left: 8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 0,
              blurRadius: 4,
              offset: Offset(0, 0),
            ),
          ],
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Colors.grey[100]!],
          ),
        ),
        child: Icon(
          Icons.power_settings_new_rounded,
          size: 18,
          color: Colors.grey[400],
        ),
      ),
    );
  }
}
