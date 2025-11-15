import 'package:flutter/material.dart';
import 'package:flutter_practice8/features/navigation/app_router.dart';
import 'package:flutter_practice8/shared/app_theme.dart';
import 'package:flutter_practice8/shared/service_locator.dart';

void main() {
  setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Car Expenses App',
      theme: appTheme,
      routerConfig: router,
    );
  }
}
