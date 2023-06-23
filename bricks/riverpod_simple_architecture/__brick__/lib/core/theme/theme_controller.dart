import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:{{project_name.snakeCase()}}/shared/pods/theme_pod.dart';

final themecontrollerProvider =
    NotifierProvider.autoDispose<ThemeModeController, ThemeMode>(
  ThemeModeController.new,
  name: 'themecontrollerProvider',
);

class ThemeModeController extends AutoDisposeNotifier<ThemeMode> {
  ThemeModeController() : super();

  Future<void> changeTheme(ThemeMode theme) async {
    state = theme;
    final themeService = ref.watch(themeServicePod);
    await themeService.setTheme(themeMode: state);
  }

  @override
  ThemeMode build() {
    loadTheme();
    return ThemeMode.system;
  }

  Future<void> loadTheme() async {
    final themeService = ref.watch(themeServicePod);
    state = await themeService.getTheme();
  }
}
