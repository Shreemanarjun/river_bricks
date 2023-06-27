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
      """🎉 Congratulations on generating your code using the provided template! 
      \n🚀 You've built an impressive library with powerful features.
      \n 💪 Utilize Riverpod for efficient state management,
      \n Auto Route for seamless navigation, and Dio for API requests.
      \n 🌐📥 With velocity_x, create stunning UIs, while flex_color_scheme provides theming and persistence.
      \n 🎨💾 Flash enables engaging alerting UIs, and Hive with storage provider facilitates efficient database usage.
      \n🗄️💡 Localize and internationalize your app using l18n.
      \n 🌍🌐 Handle scenarios like no internet connection and app locale selection with internet_connection_checker's default UIs.
      \n 🌐🚫 Ensure responsiveness across devices with responsive_framework.\n 📱💻 And use talker_flutter for logging and debugging.
      \n 🗣️🐛 Keep up the great work! Happy coding! 
      \n💻✨
      \n\n Love Flutter from Shreeman Arjun! do visit https://github.com/Shreemanarjun ❤️🔥""");
}
