import 'dart:io';

import 'package:mason/mason.dart';

// Function to launch a URL based on the operating system
Future<void> _launchURL(String url, HookContext context) async {
  try {
    if (Platform.isMacOS) {
      await Process.run('open', [url]);
    } else if (Platform.isLinux) {
      await Process.run('xdg-open', [url]);
    } else if (Platform.isWindows) {
      await Process.run('start', [url], runInShell: true);
    } else {
      context.logger.err("Unsupported platform for opening URL.");
    }
  } catch (e) {
    context.logger.err("Could not launch the URL: $e");
  }
}

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
    "flutter_secure_storage_x",
    "flutter_riverpod",
    "hive_ce_flutter",
    "internet_connection_checker_plus",
    "intl",
    "multiple_result",
    "path_provider",
    "platform_info",
    "responsive_framework:{'git':{'url':'https://github.com/Shreemanarjun/ResponsiveFramework.git'}}",
    "slang",
    "slang_flutter",
    "talker_dio_logger",
    "talker_flutter",
    "talker_riverpod_logger",
    "velocity_x:{'git':{'url':'https://github.com/Shreemanarjun/VelocityX.git','ref': 'stable'}}",
  ];
  try {
    final result = await Process.run(
      'dart',
      ['pub', 'add', ...deps],
      runInShell: true,
    );
    // Check if the process ran successfully
    if (result.exitCode == 0) {
      depprogress.complete("All general dependencies added");
    } else {
      depprogress.update(
          "Failed to add dependencies with exit code: ${result.exitCode}");
      depprogress.update("Standard output: ${result.stdout}");
      depprogress.fail("Standard error: ${result.stderr}");
      return; // Exit early if dependency addition fails
    }
  } catch (e) {
    depprogress.cancel();
    depprogress.fail(e.toString());
    return; // Exit early if dependency addition fails
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
    "slang_build_runner",
    "spot",
    "very_good_analysis",
  ];
  try {
    final result = await Process.run(
      'dart',
      ['pub', 'add', '--dev', ...devdeps],
      runInShell: true,
    );
    if (result.exitCode == 0) {
      devdepprogress.complete("All dev dependencies added");
    } else {
      devdepprogress.update(
          "Failed to add dependencies with exit code: ${result.exitCode}");
      devdepprogress.update("Standard output: ${result.stdout}");
      devdepprogress.fail("Standard error: ${result.stderr}");
      return;
    }
  } catch (e) {
    devdepprogress.cancel();
    devdepprogress.fail(e.toString());
    return;
  }
  final packageprogress =
      context.logger.progress('Installing flutter packages');

  /// Run `flutter packages get` after generation.
  try {
    final result = await Process.run(
      'flutter',
      ['packages', 'get'],
      runInShell: true,
    );
    if (result.exitCode == 0) {
      packageprogress.complete("Got all flutter packages");
    } else {
      packageprogress
          .update("Failed to get packages with exit code: ${result.exitCode}");
      packageprogress.update("Standard output: ${result.stdout}");
      packageprogress.fail("Standard error: ${result.stderr}");
      return;
    }
  } catch (e) {
    packageprogress.cancel();
    packageprogress.fail(e.toString());
    return;
  }

  /// Run `flutter pub get` after generation.
  final additionalpackageprogress =
      context.logger.progress('Installing dart packages');
  try {
    final result = await Process.run(
      'dart',
      ['pub', 'get'],
      runInShell: true,
    );
    if (result.exitCode == 0) {
      additionalpackageprogress.complete("Got dart packages");
    } else {
      additionalpackageprogress
          .update("Failed to get packages with exit code: ${result.exitCode}");
      additionalpackageprogress.update("Standard output: ${result.stdout}");
      additionalpackageprogress.fail("Standard error: ${result.stderr}");
      return;
    }
  } catch (e) {
    additionalpackageprogress.cancel();
    additionalpackageprogress.fail(e.toString());
    return;
  }

  /// Run `Remove flutter_gen` after generation.
  final fluttergenprogress =
      context.logger.progress('Removing conflicting packages');
  try {
    final result = await Process.run(
      'dart',
      ['pub', 'remove', 'flutter_gen'],
      runInShell: true,
    );
    if (result.exitCode == 0) {
      fluttergenprogress.complete("Removed conflicting packages");
    } else {
      fluttergenprogress.update(
          "Failed to remove packages with exit code: ${result.exitCode}");
      fluttergenprogress.update("Standard output: ${result.stdout}");
      fluttergenprogress.fail("Standard error: ${result.stderr}");
      return;
    }
  } catch (e) {
    fluttergenprogress.cancel();
    fluttergenprogress.fail(e.toString());
    return;
  }

  /// Run `flutter pub run build_runner` after generation.
  final codegenprogress =
      context.logger.progress('Generating localization and routes ');

  try {
    final result = await Process.run(
      'flutter',
      ['pub', 'run', 'build_runner', 'build', '--delete-conflicting-outputs'],
      runInShell: true,
    );
    if (result.exitCode == 0) {
      codegenprogress.complete();
    } else {
      codegenprogress.update(
          "Failed to run build_runner with exit code: ${result.exitCode}");
      codegenprogress.update("Standard output: ${result.stdout}");
      codegenprogress.fail("Standard error: ${result.stderr}");
      return;
    }
  } catch (e) {
    codegenprogress.cancel();
    codegenprogress.fail(e.toString());
    return;
  }

  /// Run `flutter pub get` after generation.
  final lpackageprogress =
      context.logger.progress('Checking updation of pubspec');
  try {
    final result = await Process.run(
      'dart',
      ['pub', 'get'],
      runInShell: true,
    );
    if (result.exitCode == 0) {
      lpackageprogress.complete("pubspec updation compelete");
    } else {
      lpackageprogress
          .update("Failed to get packages with exit code: ${result.exitCode}");
      lpackageprogress.update("Standard output: ${result.stdout}");
      lpackageprogress.fail("Standard error: ${result.stderr}");
      return;
    }
  } catch (e) {
    lpackageprogress.cancel();
    additionalpackageprogress.fail(e.toString());
    return;
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
    final result = await Process.run(
      'mason',
      ['upgrade', '-g'],
      runInShell: true,
    );
    if (result.exitCode == 0) {
      masonpackageupgrade.complete("Upgraded mason");
    } else {
      masonpackageupgrade
          .update("Failed to upgrade mason with exit code: ${result.exitCode}");
      masonpackageupgrade.update("Standard output: ${result.stdout}");
      masonpackageupgrade.fail("Standard error: ${result.stderr}");
      return;
    }
  } catch (e) {
    masonpackageupgrade.cancel();
    masonpackageupgrade.fail(e.toString());
    return;
  }

  /// Run `Remove flutter_gen` after generation.
  final coverageprogress = context.logger.progress('Generating coverage');
  try {
    final result = await Process.run(
      'flutter',
      ['test', '--coverage'],
      runInShell: true,
    );
    if (result.exitCode == 0) {
      coverageprogress.complete("Coverage file generate");
    } else {
      coverageprogress.update(
          "Failed to generate coverage with exit code: ${result.exitCode}");
      coverageprogress.update("Standard output: ${result.stdout}");
      coverageprogress.fail("Standard error: ${result.stderr}");
      return;
    }
  } catch (e) {
    coverageprogress.cancel();
    coverageprogress.fail(e.toString());
    return;
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
      \n\n Love Flutter from Shreeman Arjun! do visit https://shreeman.dev ❤️🔥\n\n""");
  // Ask the user if they want to check other packages or visit shreeman.dev
  final checkOtherPackages = context.logger.confirm(
    'Do you want to check other packages on pub.dev or visit shreeman.dev?',
    defaultValue: true,
  );

  if (checkOtherPackages) {
    // Launch the URL for other packages on pub.dev
    await _launchURL(
        "https://pub.dev/publishers/shreeman.dev/packages", context);
  } else {
    // Launch the URL for shreeman.dev
    await _launchURL("https://shreeman.dev", context);
  }
}
