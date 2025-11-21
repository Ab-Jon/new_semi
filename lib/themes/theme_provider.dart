import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';

final themeProvider = StateProvider<ThemeMode>((ref) {
  // Start with system theme detection
  return ThemeMode.system;
});
