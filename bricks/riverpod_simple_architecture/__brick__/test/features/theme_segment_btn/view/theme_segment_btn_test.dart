// ignore_for_file: deprecated_member_use

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:{{project_name.snakeCase()}}/core/local_storage/app_storage_pod.dart';
import 'package:{{project_name.snakeCase()}}/features/counter/counter.dart';
import 'package:{{project_name.snakeCase()}}/features/theme_segmented_btn/controller/selection_theme_pod.dart';
import 'package:{{project_name.snakeCase()}}/features/theme_segmented_btn/view/theme_segmented_btn.dart';
import 'package:{{project_name.snakeCase()}}/i18n/strings.g.dart';

import 'package:{{project_name.snakeCase()}}/shared/pods/internet_checker_pod.dart';
import 'package:{{project_name.snakeCase()}}/shared/pods/translation_pod.dart';

import '../../../helpers/helpers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Theme Segment Button Test', () {
    late Box appBox;
    setUp(() async {
      appBox = await Hive.openBox('appBox', bytes: Uint8List(0));
    });
    tearDown(() {
      appBox.clear();
    });
    testWidgets('renderes ThemeSegmentBtn', (tester) async {
      final translation = AppLocale.en.buildSync();
      final container = ProviderContainer(
        overrides: [
          enableInternetCheckerPod.overrideWith((ref) => false),
          appBoxProvider.overrideWithValue(appBox),
          translationsPod.overrideWith((ref) => translation),
        ],
      );
      addTearDown(container.dispose);
      await tester.pumpApp(child: const CounterView(), container: container);
      await tester.pumpAndSettle();
      expect(find.byType(ThemeSegmentedBtn), findsOneWidget);
    });
    testWidgets('renderes ThemeSefementBtn with ThemeMode.System at Intial', (
      tester,
    ) async {
      final translation = AppLocale.en.buildSync();
      final container = ProviderContainer(
        overrides: [
          enableInternetCheckerPod.overrideWith((ref) => false),
          appBoxProvider.overrideWithValue(appBox),
          translationsPod.overrideWith((ref) => translation),
        ],
      );
      addTearDown(container.dispose);
      await tester.pumpApp(child: const CounterView(), container: container);
      await tester.pumpAndSettle();
      expect(find.byType(ThemeSegmentedBtn), findsOneWidget);
      expect(find.byIcon(Icons.brightness_auto), findsOneWidget);
      expect(find.byIcon(Icons.check), findsOneWidget);
    });

    testWidgets(
      'renderes ThemeSefementBtn with ThemeMode.light on select light mode',
      (tester) async {
        final translation = AppLocale.en.buildSync();
        final container = ProviderContainer(
          overrides: [
            enableInternetCheckerPod.overrideWith((ref) => false),
            appBoxProvider.overrideWithValue(appBox),
            translationsPod.overrideWith((ref) => translation),
          ],
        );
        addTearDown(container.dispose);

        await tester.pumpApp(child: const CounterView(), container: container);
        await tester.pumpAndSettle();
        expect(find.byType(ThemeSegmentedBtn), findsOneWidget);
        expect(find.byIcon(Icons.light_mode), findsOneWidget);
        await tester.runAsync(() async {
          await tester.tap(find.byIcon(Icons.light_mode));
          expect(container.read(themeSelectionPod).length, 1);
          expect(container.read(themeSelectionPod), equals({ThemeMode.light}));
        });
      },
    );
    testWidgets(
      'renderes ThemeSefementBtn with ThemeMode.dark on select dark mode',
      (tester) async {
        final translation = AppLocale.en.buildSync();
        final container = ProviderContainer(
          overrides: [
            enableInternetCheckerPod.overrideWith((ref) => false),
            appBoxProvider.overrideWithValue(appBox),
            translationsPod.overrideWith((ref) => translation),
          ],
        );
        addTearDown(container.dispose);

        await tester.pumpApp(child: const CounterView(), container: container);
        await tester.pumpAndSettle();
        expect(find.byType(ThemeSegmentedBtn), findsOneWidget);
        expect(find.byIcon(Icons.dark_mode), findsOneWidget);
        await tester.runAsync(() async {
          await tester.tap(find.byIcon(Icons.dark_mode));
          expect(container.read(themeSelectionPod).length, 1);
          expect(container.read(themeSelectionPod), equals({ThemeMode.dark}));
        });
      },
    );
    testWidgets(
      'renderes ThemeSegementBtn with ThemeMode.system after change from dark mode to system mode',
      (tester) async {
        final translation = AppLocale.en.buildSync();
        final container = ProviderContainer(
          overrides: [
            enableInternetCheckerPod.overrideWith((ref) => false),
            appBoxProvider.overrideWithValue(appBox),
            translationsPod.overrideWith((ref) => translation),
          ],
        );
        addTearDown(container.dispose);

        await tester.pumpApp(child: const CounterView(), container: container);
        await tester.pumpAndSettle();
        expect(find.byType(ThemeSegmentedBtn), findsOneWidget);
        expect(find.byIcon(Icons.dark_mode), findsOneWidget);
        expect(find.byIcon(Icons.brightness_auto), findsOneWidget);
        await tester.runAsync(() async {
          await tester.tap(find.byIcon(Icons.dark_mode));
          expect(container.read(themeSelectionPod).length, 1);
          expect(container.read(themeSelectionPod), equals({ThemeMode.dark}));
        });
        await tester.pump();
        await tester.runAsync(() async {
          await tester.tap(find.byIcon(Icons.brightness_auto));
          expect(container.read(themeSelectionPod).length, 1);
          expect(container.read(themeSelectionPod), equals({ThemeMode.system}));
        });
      },
    );
    testWidgets(
      'renderes ThemeSegementBtn with ThemeMode.system after change from light mode to system mode',
      (tester) async {
        final translation = AppLocale.en.buildSync();
        final container = ProviderContainer(
          overrides: [
            enableInternetCheckerPod.overrideWith((ref) => false),
            appBoxProvider.overrideWithValue(appBox),
            translationsPod.overrideWith((ref) => translation),
          ],
        );
        addTearDown(container.dispose);

        await tester.pumpApp(child: const CounterView(), container: container);
        await tester.pumpAndSettle();
        expect(find.byType(ThemeSegmentedBtn), findsOneWidget);
        expect(find.byIcon(Icons.light_mode), findsOneWidget);
        expect(find.byIcon(Icons.brightness_auto), findsOneWidget);
        await tester.runAsync(() async {
          await tester.tap(find.byIcon(Icons.light_mode));
          expect(container.read(themeSelectionPod).length, 1);
          expect(container.read(themeSelectionPod), equals({ThemeMode.light}));
        });
        await tester.pump();
        await tester.runAsync(() async {
          await tester.tap(find.byIcon(Icons.brightness_auto));
          expect(container.read(themeSelectionPod).length, 1);
          expect(container.read(themeSelectionPod), equals({ThemeMode.system}));
        });
      },
    );
    testWidgets(
      'renderes ThemeSegementBtn with ThemeMode.dark after change from light mode to dark mode',
      (tester) async {
        final translation = AppLocale.en.buildSync();
        final container = ProviderContainer(
          overrides: [
            enableInternetCheckerPod.overrideWith((ref) => false),
            appBoxProvider.overrideWithValue(appBox),
            translationsPod.overrideWith((ref) => translation),
          ],
        );
        addTearDown(container.dispose);

        await tester.pumpApp(child: const CounterView(), container: container);
        await tester.pumpAndSettle();
        expect(find.byType(ThemeSegmentedBtn), findsOneWidget);
        expect(find.byIcon(Icons.light_mode), findsOneWidget);
        expect(find.byIcon(Icons.dark_mode), findsOneWidget);
        await tester.runAsync(() async {
          await tester.tap(find.byIcon(Icons.light_mode));
          expect(container.read(themeSelectionPod).length, 1);
          expect(container.read(themeSelectionPod), equals({ThemeMode.light}));
        });
        await tester.pump();
        await tester.runAsync(() async {
          await tester.tap(find.byIcon(Icons.dark_mode));
          expect(container.read(themeSelectionPod).length, 1);
          expect(container.read(themeSelectionPod), equals({ThemeMode.dark}));
        });
      },
    );
  });
}
