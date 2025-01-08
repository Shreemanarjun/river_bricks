import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:mason/mason.dart';
import 'package:yaml/yaml.dart';

void run(HookContext context) {
  context.logger.info('Pre generation started');

  // Check if pubspec.yaml exists
  final pubspec = File(path.join(".", 'pubspec.yaml'));
  if (!pubspec.existsSync()) {
    context.logger.err('Could not find pubspec.yaml');
    context.logger.info('Pre generation stopped');
    return;
  }

  // Read and parse pubspec.yaml
  final content = pubspec.readAsStringSync();
  final yamlMap = loadYaml(content) as YamlMap?;

  // Get the default project name from pubspec.yaml
  final defaultName = yamlMap?['name'] as String?;
  if (defaultName == null) {
    context.logger.err('Could not find the "name" field in pubspec.yaml');
    context.logger.info('Pre generation stopped');
    return;
  }

  // Prompt the user for the project name with a hint
  final projectName = context.logger.prompt(
    'Enter the project name',
    defaultValue: defaultName,
  );

  // Set the project name in the context variables
  context.vars['project_name'] = projectName;
  context.logger.info('Project name: $projectName');
  context.logger.info('Pre generation completed');
}
