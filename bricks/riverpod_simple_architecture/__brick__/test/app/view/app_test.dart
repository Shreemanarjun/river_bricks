import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_test/hive_test.dart';
import 'package:{{project_name.snakeCase()}}/features/counter/counter.dart';

import '../../helpers/pump_app.dart';

void main() {
  group('App', () {
    setUp(() async {
      await setUpTestHive();
    });
    testWidgets('renders CounterPage', (tester) async {
      await tester.pumpApp(
        const ProviderScope(child: CounterPage()),
      );
      expect(find.byType(CounterPage), findsOneWidget);
    });
    tearDown(() async {
      await tearDownTestHive();
    });
  });
}
