import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:{{project_name.snakeCase()}}/features/counter/counter.dart';

class CounterNotifier extends Notifier<int> {
  @override
  int build() {
    return ref.watch(intialCounterValuePod);
  }

  void increment() => state = state + 1;
  void decrement() => state = state - 1;
}
