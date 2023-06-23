import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:{{project_name.snakeCase()}}/core/router/router.dart';

final navigatorKey = GlobalKey<NavigatorState>();

final autorouterProvider = Provider.autoDispose(
  (ref) => AppRouter(),
  name: 'autorouterProvider',
);
