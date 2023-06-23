import 'package:flutter/material.dart';

abstract class IThemeService {
  Future<void> setTheme({required ThemeMode themeMode});
  Future<ThemeMode> getTheme();
}
