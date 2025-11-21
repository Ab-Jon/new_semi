import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semi_bill/themes/app_theme.dart';
import 'package:semi_bill/themes/theme_provider.dart';
import 'home_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Semi Bill',
      theme: ThemeData(
        brightness: Brightness.light,
        extensions: [
          AppColors(
            primary: Color(0xFF2B124C),
            background: Colors.white,
            textPrimary: Colors.black87,
          ),
        ],
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        extensions: [
          AppColors(
            primary: Color(0xFF632AAE),
            background: const Color(0xFF1E1E1E),
            textPrimary: Colors.white,
          ),
        ],
      ),
      themeMode: ThemeMode.system,
      home: const HomeScreen(),
    );
  }
}