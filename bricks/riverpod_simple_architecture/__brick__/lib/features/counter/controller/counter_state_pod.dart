import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:{{project_name.snakeCase()}}/features/counter/counter.dart';

/// This provider holds CounternNotifier
final counterPod = NotifierProvider<CounterNotifier, int>(
  CounterNotifier.new,
  name: 'counterPod',
);
