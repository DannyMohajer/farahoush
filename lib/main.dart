import 'package:farahoush/core/localization/app_localization.dart';
import 'package:farahoush/core/localization/app_localization_delegate.dart';
import 'package:farahoush/core/styles/app_theme.dart';
import 'package:farahoush/features/relay/views/relay_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FaraHoush',
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizationDelegate.localizationsDelegates,
      locale: const Locale('fa', 'IR'),
      localeListResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale?.first.languageCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
      theme: AppTheme.customTheme,
      
      scrollBehavior: const MaterialScrollBehavior(),
      home: const RelayScreen(),
    );
  }
}
