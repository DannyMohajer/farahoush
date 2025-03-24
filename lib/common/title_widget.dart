import 'package:farahoush/core/styles/app_theme.dart';
import 'package:flutter/material.dart';

Widget titleWidget(String title) {
  return Text(
    ' $title',
    style: AppTextTheme.labelLarge.copyWith(fontWeight: FontWeight.w800),
  );
}
