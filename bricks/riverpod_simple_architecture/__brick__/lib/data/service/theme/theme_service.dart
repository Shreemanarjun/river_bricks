import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:{{project_name.snakeCase()}}/data/service/theme/i_theme_service.dart';

class ThemeService implements IThemeService {
  static String boxName = 'themeBox';
  static String themeKey = 'themeKey';

  @override
  Future<ThemeMode> getTheme() async {
    final box = await Hive.openBox(boxName);
    final theme = box.get(themeKey);
    if (theme != null) {
      if (theme == ThemeMode.light.toString()) {
        return ThemeMode.light;
      } else if (theme == ThemeMode.dark.toString()) {
        return ThemeMode.dark;
      }
      return ThemeMode.system;
    }
    return ThemeMode.system;
  }

  @override
  Future<void> setTheme({required ThemeMode themeMode}) async {
    final box = await Hive.openBox(boxName);
    await box.put(themeKey, themeMode.toString());
  }
}
