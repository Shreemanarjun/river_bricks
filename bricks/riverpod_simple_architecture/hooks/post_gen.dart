import 'dart:io';

import 'package:mason/mason.dart';

void run(HookContext context) async {
  context.logger.info('Post generation started');

  final depprogress = context.logger.progress('Installing dependencies');

  /// Run `Add dependencies` after generation.
  final deps = [
    "auto_route",
    "dio",
    "dio_smart_retry",
    "duration",
    "flash",
    "flex_color_scheme",
    "flutter_displaymode",
    "flutter_riverpod",
    "hive_flutter",
    "internet_connection_checker_plus",
    "intl",
    "path_provider",
    "platform_info",
    "responsive_framework",
    "talker_dio_logger",
    "talker_flutter",
    "velocity_x",
  ];
  try {
    await Process.run(
      'dart',
      ['pub', 'add', ...deps],
      runInShell: true,
    );
    depprogress.complete("All dependecies added");
  } catch (e) {
    depprogress.cancel();
    depprogress.fail(e.toString());
  }
  final devdepprogress = context.logger.progress('Installing dependencies');

  /// Run `Add dev dependencies` after generation.
  final devdeps = [
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
    devdepprogress.complete("All dev dependecies added");
  } catch (e) {
    devdepprogress.cancel();
    devdepprogress.fail(e.toString());
  }
  final packageprogress = context.logger.progress('Installing packages');

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
  try {
    await Process.run(
      'dart',
      ['pub', 'get'],
      runInShell: true,
    );
    packageprogress.complete("Got dart packages");
  } catch (e) {
    packageprogress.cancel();
    packageprogress.fail(e.toString());
  }

  /// Run `flutter pub get` after generation.
  try {
    await Process.run(
      'dart',
      ['pub', 'remove', 'flutter_gen'],
      runInShell: true,
    );
    packageprogress.complete("Removed unnecessary packages");
  } catch (e) {
    packageprogress.cancel();
    packageprogress.fail(e.toString());
  }

  /// Run `dart fix --apply` after generation.
  final codefixprogress = context.logger.progress('Fixing & Updating code');

  try {
    await Process.run(
      'dart',
      ['fix', '--apply'],
      runInShell: true,
    );
    codefixprogress.complete();
  } catch (e) {
    codefixprogress.cancel();
    codefixprogress.fail(e.toString());
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
  context.logger.info('Post generation completed');
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
