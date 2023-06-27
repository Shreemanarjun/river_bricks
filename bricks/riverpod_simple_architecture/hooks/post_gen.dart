import 'dart:io';

import 'package:mason/mason.dart';

void run(HookContext context) async {
  context.logger.info('Post generation started');
  final packageprogress = context.logger.progress('Installing packages');

  try {
    // Run `flutter packages get` after generation.
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

  final codegenprogress =
      context.logger.progress('Generating localization and routes ');

  try {
    // Run `flutter packages get` after generation.
    await Process.run(
      'flutter',
      ['pub', 'run', 'build_runner', 'build', '--delete-conflicting-outputs'],
      workingDirectory: Directory.current.absolute.path.toString(),
    );
    codegenprogress.complete();
  } catch (e) {
    codegenprogress.cancel();
    codegenprogress.fail(e.toString());
  }
  context.logger.info('Post generation completed');
}
