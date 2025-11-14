import 'package:flutter/material.dart';
import 'package:flutter_practice8/features/navigation/app_router.dart';
import 'package:flutter_practice8/shared/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Car Expenses App',
      theme: appTheme,
      routerConfig: appRouter,
    );
  }
}
