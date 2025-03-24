import 'package:farahoush/common/widgets/buttons/custom_normal_button.dart';
import 'package:farahoush/core/styles/app_theme.dart';
import 'package:flutter/material.dart';

class AddingRelayWidget extends StatelessWidget {
  final VoidCallback onPressed;
  const AddingRelayWidget({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'افزودن رله',
          style: AppTextTheme.labelLarge.copyWith(fontWeight: FontWeight.w800),
        ),
        CustomNormalButton(
          onPressed: onPressed,
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.add, color: Colors.blue),
          ),
        ),
      ],
    );
  }
}
