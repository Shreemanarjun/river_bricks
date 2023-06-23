import 'dart:io';

import 'package:mason/mason.dart';

void run(HookContext context) async {
  final dir = Directory.current.path;
  final newprogress = context.logger.progress('Starting in $dir with Mason');
  try {
    final result = await Process.run(
      'flutter',
      ['pub', 'get'],
      workingDirectory: dir,
      runInShell: true,
    );
    newprogress.update(result.stdout);
  } catch (e) {
    newprogress.fail("Failed to get packages due to ${e.toString()}");
  }
  newprogress.complete("Completed pub get");
}
