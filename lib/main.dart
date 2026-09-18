import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semi_bill/presentation/splash_screen.dart';
import 'package:semi_bill/themes/app_theme.dart';
import 'package:semi_bill/themes/theme_provider.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(themeProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Semi Bill',
      theme: SemiAppTheme.light(),
      darkTheme: SemiAppTheme.dark(),
      themeMode: mode,
      home: const SplashScreen(),
    );
  }
}
