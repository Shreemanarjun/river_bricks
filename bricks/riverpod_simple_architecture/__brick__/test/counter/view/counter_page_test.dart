import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:{{project_name.snakeCase()}}/features/counter/counter.dart';

import '../../helpers/helpers.dart';

class MockCounterNotifier extends Notifier<int>
    with Mock
    implements CounterNotifier {}

void main() {
  group('CounterPage', () {
    testWidgets('renders CounterView', (tester) async {
      await tester.pumpApp(const ProviderScope(child: CounterPage()));
      expect(find.byType(CounterView), findsOneWidget);
    });
  });

  group('CounterView', () {
    testWidgets('renders current count', (tester) async {
      const state = 42;

      final container = ProviderContainer(
        overrides: [
          intialCounterValuePod.overrideWithValue(state),
        ],
      );
      addTearDown(container.dispose);
      await tester.pumpApp(
        ProviderScope(
          parent: container,
          child: const CounterView(),
        ),
      );
      expect(find.text('$state'), findsOneWidget);
    });

    testWidgets('calls increment when increment button is tapped',
        (tester) async {
      const state = 42;

      final container = ProviderContainer(
        overrides: [
          intialCounterValuePod.overrideWithValue(state),
        ],
      );
      addTearDown(container.dispose);

      await tester.pumpApp(
        ProviderScope(
          parent: container,
          child: const CounterView(),
        ),
      );
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();
      expect(find.text('42'), findsNothing);
      expect(find.text('43'), findsOneWidget);
    });

    testWidgets('calls decrement when decrement button is tapped',
        (tester) async {
      const state = 42;
      final container = ProviderContainer(
        overrides: [
          intialCounterValuePod.overrideWithValue(state),
        ],
      );
      addTearDown(container.dispose);
      await tester.pumpApp(
        ProviderScope(
          parent: container,
          child: const CounterView(),
        ),
      );
      await tester.tap(find.byIcon(Icons.remove));
      await tester.pump();
      expect(find.text('42'), findsNothing);
      expect(find.text('41'), findsOneWidget);
    });
  });
}
