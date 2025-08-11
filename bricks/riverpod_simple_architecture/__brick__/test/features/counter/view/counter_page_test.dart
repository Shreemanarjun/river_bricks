// ignore_for_file: deprecated_member_use

import 'package:{{project_name.snakeCase()}}/features/counter/controller/counter_state_pod.dart';
import 'package:{{project_name.snakeCase()}}/shared/riverpod_ext/riverpod_observer/riverpod_obs.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

import 'package:{{project_name.snakeCase()}}/core/local_storage/app_storage_pod.dart';
import 'package:{{project_name.snakeCase()}}/features/counter/view/counter_page.dart';
import 'package:{{project_name.snakeCase()}}/i18n/strings.g.dart';
import 'package:{{project_name.snakeCase()}}/shared/pods/internet_checker_pod.dart';

import 'package:{{project_name.snakeCase()}}/shared/pods/translation_pod.dart';

import '../../../helpers/helpers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('CounterPage', () {
    late Box appBox;
    setUp(() async {
      appBox = await Hive.openBox('appBox', bytes: Uint8List(0));
    });
    tearDown(() {
      appBox.clear();
    });
    testWidgets('renders CounterView', (tester) async {
      final translation = AppLocale.en.buildSync();
      await tester.pumpApp(
        child: const CounterPage(),
        container: ProviderContainer.test(
          overrides: [
            enableInternetCheckerPod.overrideWith(
              (ref) => false,
            ),
            appBoxProvider.overrideWithValue(appBox),
            translationsPod.overrideWith((ref) => translation)
          ],
        ),
      );
      expect(find.byType(CounterView), findsOneWidget);
    });
  });

  group('CounterView', () {
    late Box appBox;
    setUp(() async {
      appBox = await Hive.openBox('appBox', bytes: Uint8List(0));
    });
    tearDown(() async {
      await appBox.clear();
    });
    testWidgets('renders current count', (tester) async {
      const state = 42;
      final translation = AppLocale.en.buildSync();
      final container = ProviderContainer.test(
        overrides: [
          enableInternetCheckerPod.overrideWith(
            (ref) => false,
          ),
          appBoxProvider.overrideWithValue(appBox),
          counterPod.overrideWithBuild(
            (ref, notifier) => state,
          ),
          translationsPod.overrideWith((ref) => translation)
        ],
        observers: [TalkerRiverpodObserver()],
      );
      addTearDown(container.dispose);
      await tester.pumpApp(
        child: const CounterView(),
        container: container,
      );
      await tester.pumpAndSettle();

      expect(find.text('$state'), findsOneWidget);
    });

    testWidgets('calls increment when increment button is tapped',
        (tester) async {
      const state = 42;
      final translation = AppLocale.en.buildSync();
      await tester.pumpApp(
        child: const CounterView(),
        container: ProviderContainer.test(
          overrides: [
            enableInternetCheckerPod.overrideWith(
              (ref) => false,
            ),
            appBoxProvider.overrideWithValue(appBox),
            counterPod.overrideWithBuild(
              (ref, notifier) => state,
            ),
            translationsPod.overrideWith((ref) => translation)
          ],
        ),
      );
      await tester.pump();
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();
      expect(find.text('42'), findsNothing);
      expect(find.text('43'), findsOneWidget);
    });

    testWidgets('calls decrement when decrement button is tapped',
        (tester) async {
      const state = 42;
      final translation = AppLocale.en.buildSync();
      final container = ProviderContainer.test(
        overrides: [
          enableInternetCheckerPod.overrideWith(
            (ref) => false,
          ),
          appBoxProvider.overrideWithValue(appBox),
          counterPod.overrideWithBuild(
            (ref, notifier) => state,
          ),
          translationsPod.overrideWith((ref) => translation)
        ],
      );

      await tester.pumpApp(
        child: const CounterView(),
        container: container,
      );

      await tester.runAsync(
        () async {
          await tester.pumpAndSettle();
          await tester.tap(find.byIcon(Icons.remove));
          await tester.pumpAndSettle();
          expect(find.text('42'), findsNothing);
          expect(find.text('41'), findsOneWidget);
        },
      );
    });
  });
}
