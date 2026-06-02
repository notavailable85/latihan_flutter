import 'package:flutter/material.dart';
import 'package:latihan_flutter/safenesia/screens/home_page.dart';
import 'core/constants/app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Safenesia',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        primaryColor: AppColors.primary,

        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),

        scaffoldBackgroundColor: AppColors.background,

        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
        ),
      ),

      home: const SnHomePage(),
    );
  }
}
