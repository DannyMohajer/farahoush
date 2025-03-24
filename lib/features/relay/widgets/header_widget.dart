import 'package:farahoush/core/styles/app_theme.dart';
import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  final String name;
  final IconData icon;
  const HeaderWidget({super.key, required this.name, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTextTheme.labelLarge.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.grey[700],
            fontSize: 20 * MediaQuery.textScaleFactorOf(context),
          ),
        ),
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            shape: BoxShape.circle,
          ),
          child: Center(child: Icon(icon, size: 30, color: Colors.grey[400])),
        ),
      ],
    );
  }
}
