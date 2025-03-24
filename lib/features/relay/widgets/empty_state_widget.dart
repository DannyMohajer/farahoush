import 'package:farahoush/core/config/assets/app_images.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset('${AppImages.imageBasePath}empty_state.png', width: 100),
        Gap(6),
        Text('رله ای اضافه نشده است!'),
      ],
    );
  }
}
