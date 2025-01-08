import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:mason/mason.dart';
import 'package:yaml/yaml.dart';

void run(HookContext context) {
  context.logger.info('Pre generation started');
  final pubspec = File(path.join(".", 'pubspec.yaml'));
  if (!pubspec.existsSync()) {
    context.logger.err('Could not find pubspec.yaml');
    context.logger.info('Pre generation stopped');
    return;
  }

  final content = pubspec.readAsStringSync();
  final yamlMap = loadYaml(content) as YamlMap?;

  final name = yamlMap?['name'];
  if (name == null) {
    context.logger.err('Could not find the "name" field in pubspec.yaml');
    context.logger.info('Pre generation stopped');
    return;
  }

  context.logger.info('Project name: $name');
  context.vars['project_name'] = name;
  context.logger.info('Pre generation completed');
}
