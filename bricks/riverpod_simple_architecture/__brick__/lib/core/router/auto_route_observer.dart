// ignore_for_file: strict_raw_type

import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';
import 'package:{{project_name.snakeCase()}}/bootstrap.dart';

class RouterObserver extends AutoRouterObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    talker.debug('New route pushed: ${route.settings.name}');
  }

  /// Called when the top route has been popped off, and the current route
  /// shows up.
  void didPopNext() {
    talker.debug('New route replaced:');
  }

  /// Called when a new route has been pushed, and the current route is no
  /// longer visible.
  void didPushNext() {}

  // only override to observer tab routes
  @override
  void didInitTabRoute(TabPageRoute route, TabPageRoute? previousRoute) {
    talker.debug('Tab route visited: ${route.name}');
  }

  @override
  void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
    talker.debug('Tab route re-visited: ${route.name}');
  }
}
