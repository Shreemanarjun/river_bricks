import 'dart:io';

import 'package:mason/mason.dart';

void run(HookContext context) async {
  context.logger.info('Post generation started');

  final depprogress =
      context.logger.progress('Installing general dependencies');

  /// Run `Add dependencies` after generation.
  final deps = <String>[
    "auto_route",
    "dio",
    "dio_smart_retry",
    "duration",
    "flash",
    "flex_color_scheme",
    "flutter_displaymode",
    "flutter_secure_storage",
    "flutter_riverpod",
    "hive_ce_flutter",
    "internet_connection_checker_plus",
    "intl",
    "path_provider",
    "platform_info",
    "responsive_framework:{'git':{'url':'https://github.com/Shreemanarjun/ResponsiveFramework.git'}}",
    "talker_dio_logger",
    "talker_flutter",
    "talker_riverpod_logger",
    "velocity_x",
  ];
  try {
    await Process.run(
      'dart',
      ['pub', 'add', ...deps],
      runInShell: true,
    );
    depprogress.complete("All general dependencies added");
  } catch (e) {
    depprogress.cancel();
    depprogress.fail(e.toString());
  }
  final devdepprogress = context.logger.progress('Installing dev dependencies');

  /// Run `Add dev dependencies` after generation.
  final devdeps = <String>[
    "auto_route_generator",
    "build_runner",
    "custom_lint",
    "flutter_lints",
    "mocktail",
    "riverpod_lint",
    "riverpod_test",
    "very_good_analysis",
  ];
  try {
    await Process.run(
      'dart',
      ['pub', 'add', '--dev', ...devdeps],
      runInShell: true,
    );
    devdepprogress.complete("All dev dependencies added");
  } catch (e) {
    devdepprogress.cancel();
    devdepprogress.fail(e.toString());
  }
  final packageprogress =
      context.logger.progress('Installing flutter packages');

  /// Run `flutter packages get` after generation.
  try {
    await Process.run(
      'flutter',
      ['packages', 'get'],
      runInShell: true,
    );
    packageprogress.complete("Got all flutter packages");
  } catch (e) {
    packageprogress.cancel();
    packageprogress.fail(e.toString());
  }

  /// Run `flutter pub get` after generation.
  final additionalpackageprogress =
      context.logger.progress('Installing dart packages');
  try {
    await Process.run(
      'dart',
      ['pub', 'get'],
      runInShell: true,
    );
    additionalpackageprogress.complete("Got dart packages");
  } catch (e) {
    additionalpackageprogress.cancel();
    additionalpackageprogress.fail(e.toString());
  }

  /// Run `Remove flutter_gen` after generation.
  final fluttergenprogress =
      context.logger.progress('Removing conflicting packages');
  try {
    await Process.run(
      'dart',
      ['pub', 'remove', 'flutter_gen'],
      runInShell: true,
    );
    fluttergenprogress.complete("Removed conflicting packages");
  } catch (e) {
    fluttergenprogress.cancel();
    fluttergenprogress.fail(e.toString());
  }

  /// Run `flutter pub run build_runner` after generation.
  final codegenprogress =
      context.logger.progress('Generating localization and routes ');

  try {
    await Process.run(
      'flutter',
      ['pub', 'run', 'build_runner', 'build', '--delete-conflicting-outputs'],
      runInShell: true,
    );
    codegenprogress.complete();
  } catch (e) {
    codegenprogress.cancel();
    codegenprogress.fail(e.toString());
  }

  /// Run `flutter pub get` after generation.
  final lpackageprogress =
      context.logger.progress('Checking updation of pubspec');
  try {
    await Process.run(
      'dart',
      ['pub', 'get'],
      runInShell: true,
    );
    lpackageprogress.complete("pubspec updation compelete");
  } catch (e) {
    lpackageprogress.cancel();
    additionalpackageprogress.fail(e.toString());
  }
  context.logger.info('Post generation completed');

  // /// Code fixer
  // final codefixprogress = context.logger.progress('Fixing & Updating code');

  // try {
  //   await Process.run(
  //     'dart',
  //     ['fix', '--apply'],
  //     runInShell: true,
  //   );
  //   codefixprogress.complete();
  // } catch (e) {
  //   codefixprogress.cancel();
  //   codefixprogress.fail(e.toString());
  // }

  /// Run `mason upgrade -g` for additional updates for mason
  final masonpackageupgrade = context.logger.progress('Upgrading mason');

  try {
    await Process.run(
      'mason',
      ['upgrade', '-g'],
      runInShell: true,
    );
    masonpackageupgrade.complete("Upgraded mason");
  } catch (e) {
    masonpackageupgrade.cancel();
    masonpackageupgrade.fail(e.toString());
  }

  /// Run `Remove flutter_gen` after generation.
  final coverageprogress = context.logger.progress('Generating coverage');
  try {
    await Process.run(
      'flutter',
      ['test', '--coverage'],
      runInShell: true,
    );
    coverageprogress.complete("Coverage file generate");
  } catch (e) {
    coverageprogress.cancel();
    coverageprogress.fail(e.toString());
  }
  //flutter test --coverage
  context.logger.info(
      """\n\n 🎉 Congratulations on generating your code using the provided template! with version 
      \n 🚀 You've built an impressive library with powerful features.
      \n 💪 Utilize Riverpod for efficient state management,
      \n Auto Route for seamless navigation, and Dio for API requests.
      \n 🌐📥 With velocity_x, create stunning UIs, while flex_color_scheme provides theming and persistence.
      \n 🎨💾 Flash enables engaging alerting UIs, and Hive with storage provider facilitates efficient database usage.
      \n 🗄️💡 Localize and internationalize your app using l18n.
      \n 🌍🌐 Handle scenarios like no internet connection and app locale selection with internet_connection_checker's default UIs.
      \n 🌐🚫 Ensure responsiveness across devices with responsive_framework.\n 📱💻 And use talker_flutter for logging and debugging.
      \n 🗣️🐛 Keep up the great work! Happy coding! 💻✨
      \n Please uncomment custom lint option in analysis_options.yaml to enable riverpod lint
      \n\n Love Flutter from Shreeman Arjun! do visit https://github.com/Shreemanarjun ❤️🔥\n\n""");
}
