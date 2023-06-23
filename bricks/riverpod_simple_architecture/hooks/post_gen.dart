import 'dart:io';

import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  final dir = Directory.current.path;
  final newprogress =
      context.logger.progress('Generating routes in $dir with Mason');
  try {
    await Process.run(
      'cd',
      [dir],
      workingDirectory: dir,
      runInShell: true,
    );
    await Process.run(
      'flutter',
      ['packages', 'pub', 'run', 'build_runner', 'build'],
    workingDirectory: dir,
      runInShell: true,
    );
    newprogress.complete("Generated all routes");
  } catch (e) {
    newprogress.fail("Failed to generate route $e");
  }
}
