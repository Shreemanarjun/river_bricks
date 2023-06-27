import 'dart:io';

import 'package:mason/mason.dart';

void run(HookContext context) async {
  context.logger.info('Post generation started');
  final packageprogress = context.logger.progress('Installing packages');

  /// Run `flutter packages get` after generation.
  try {
    await Process.run(
      'flutter',
      ['packages', 'get'],
      runInShell: true,
    );
    packageprogress.complete();
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
      """🎉 Congratulations on generating your code using the provided template! 🚀 You've built an impressive library with powerful features. 💪 Utilize Riverpod for efficient state management, Auto Route for seamless navigation, and Dio for API requests. 🌐📥 With velocity_x, create stunning UIs, while flex_color_scheme provides theming and persistence. 🎨💾 Flash enables engaging alerting UIs, and Hive with storage provider facilitates efficient database usage. 🗄️💡 Localize and internationalize your app using l18n. 🌍🌐 Handle scenarios like no internet connection and app locale selection with internet_connection_checker's default UIs. 🌐🚫 Ensure responsiveness across devices with responsive_framework. 📱💻 And use talker_flutter for logging and debugging. 🗣️🐛 Keep up the great work! Happy coding! 💻✨""");
}
