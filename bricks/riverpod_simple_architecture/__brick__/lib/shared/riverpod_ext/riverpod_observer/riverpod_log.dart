import 'package:{{project_name.snakeCase()}}/shared/riverpod_ext/riverpod_observer/riverpod_obs.dart';
import 'package:flutter_riverpod/misc.dart';

import 'package:talker_flutter/talker_flutter.dart';

String _defaultMessage({
  required ProviderBase<Object?> provider,
  required String suffix,
}) {
  return "$provider $suffix";
}

/// [Riverpod] add provider log model
class RiverpodAddLog extends TalkerLog {
  RiverpodAddLog({
    required this.provider,
    required this.value,
    required this.settings,
  }) : super(
          _defaultMessage(
            provider: provider,
            suffix: 'initialized',
          ),
        );

  final ProviderBase<Object?> provider;
  final Object? value;
  final TalkerRiverpodLoggerSettings settings;

  @override
  String get key => TalkerLogType.riverpodAdd.key;

  @override
  String generateTextMessage({
    TimeFormat timeFormat = TimeFormat.timeAndSeconds,
  }) {
    final sb = StringBuffer();
    sb.write(displayTitleWithTime(timeFormat: timeFormat));
    sb.write('\n$message');
    sb.write(
        '\n${'INITIAL state: ${settings.printStateFullData ? '\n$value' : value.runtimeType}'}');
    return sb.toString();
  }
}

/// [Riverpod] update provider log model
class RiverpodUpdateLog extends TalkerLog {
  RiverpodUpdateLog({
    required this.provider,
    required this.previousValue,
    required this.newValue,
    required this.settings,
  }) : super(
          _defaultMessage(
            provider: provider,
            suffix: 'updated',
          ),
        );

  final ProviderBase<Object?> provider;
  final Object? previousValue;
  final Object? newValue;
  final TalkerRiverpodLoggerSettings settings;

  @override
  String get key => TalkerLogType.riverpodUpdate.key;

  @override
  String generateTextMessage({
    TimeFormat timeFormat = TimeFormat.timeAndSeconds,
  }) {
    final sb = StringBuffer();
    sb.write(displayTitleWithTime(timeFormat: timeFormat));
    sb.write('\n$message');
    sb.write(
        '\n${'PREVIOUS state: ${settings.printStateFullData ? '\n$previousValue' : previousValue.runtimeType}'}');
    sb.write(
        '\n${'NEW state: ${settings.printStateFullData ? '\n$newValue' : newValue.runtimeType}'}');
    return sb.toString();
  }
}

/// [Riverpod] dispose provider log model
class RiverpodDisposeLog extends TalkerLog {
  RiverpodDisposeLog({
    required this.provider,
    required this.settings,
  }) : super(
          _defaultMessage(
            provider: provider,
            suffix: 'disposed',
          ),
        );

  final ProviderBase<Object?> provider;
  final TalkerRiverpodLoggerSettings settings;

  @override
  String get key => TalkerLogType.riverpodDispose.key;

  @override
  String generateTextMessage({
    TimeFormat timeFormat = TimeFormat.timeAndSeconds,
  }) {
    final sb = StringBuffer();
    sb.write(displayTitleWithTime(timeFormat: timeFormat));
    sb.write('\n$message');
    return sb.toString();
  }
}

/// [Riverpod] fail provider log model
class RiverpodFailLog extends TalkerLog {
  RiverpodFailLog({
    required this.provider,
    required this.providerError,
    required this.providerStackTrace,
    required this.settings,
  }) : super(
          _defaultMessage(
            provider: provider,
            suffix: 'failed',
          ),
        );

  final ProviderBase<Object?> provider;
  final Object providerError;
  final StackTrace providerStackTrace;
  final TalkerRiverpodLoggerSettings settings;

  @override
  String? get key => TalkerLogType.riverpodFail.key;

  @override
  String generateTextMessage({
    TimeFormat timeFormat = TimeFormat.timeAndSeconds,
  }) {
    final sb = StringBuffer();
    sb.write(displayTitleWithTime(timeFormat: timeFormat));
    sb.write('\n$message');
    sb.write('\n${'ERROR: \n$providerError'}');
    sb.write('\n${'STACK TRACE: \n$providerStackTrace'}');
    return sb.toString();
  }
}

// coverage:ignore-file
class RiverpodMutationStart extends TalkerLog {
  RiverpodMutationStart({
    required this.provider,
    required this.value,
    required this.settings,
  }) : super(
          _defaultMessage(
            provider: provider,
            suffix: 'Mutation Start',
          ),
        );
  final ProviderBase<Object?> provider;
  final Object? value;
  final TalkerRiverpodLoggerSettings settings;

  @override
  String? get key => "Riverpod-Mutation-Start";

  @override
  String generateTextMessage({
    TimeFormat timeFormat = TimeFormat.timeAndSeconds,
  }) {
    final sb = StringBuffer();
    sb.write(displayTitleWithTime(timeFormat: timeFormat));
    sb.write('\n$message');
    sb.write(
        '\n${'INITIAL state: ${settings.printStateFullData ? '\n$value' : value.runtimeType}'}');
    return sb.toString();
  }
}

class RiverpodMutationUpdate extends TalkerLog {
  RiverpodMutationUpdate({
    required this.provider,
    required this.previousValue,
    required this.newValue,
    required this.settings,
  }) : super(
          _defaultMessage(
            provider: provider,
            suffix: 'Mutation Update',
          ),
        );
  final ProviderBase<Object?> provider;
  final Object? previousValue;
  final Object? newValue;
  final TalkerRiverpodLoggerSettings settings;

  @override
  String? get key => "Riverpod-Mutation-Update";

  @override
  String generateTextMessage({
    TimeFormat timeFormat = TimeFormat.timeAndSeconds,
  }) {
    final sb = StringBuffer();
    sb.write(displayTitleWithTime(timeFormat: timeFormat));
    sb.write('\n$message');
    sb.write(
        '\n${'PREVIOUS state: ${settings.printStateFullData ? '\n$previousValue' : previousValue.runtimeType}'}');
    sb.write(
        '\n${'NEW state: ${settings.printStateFullData ? '\n$newValue' : newValue.runtimeType}'}');
    return sb.toString();
  }
}

class RiverpodMutationError extends TalkerLog {
  RiverpodMutationError({
    required this.provider,
    required this.providerError,
    required this.providerStackTrace,
    required this.settings,
  }) : super(
          _defaultMessage(
            provider: provider,
            suffix: 'Mutation Error',
          ),
        );
  final ProviderBase<Object?> provider;
  final Object providerError;
  final StackTrace providerStackTrace;
  final TalkerRiverpodLoggerSettings settings;

  @override
  String? get key => "Riverpod-Mutation-Error";

  @override
  String generateTextMessage({
    TimeFormat timeFormat = TimeFormat.timeAndSeconds,
  }) {
    final sb = StringBuffer();
    sb.write(displayTitleWithTime(timeFormat: timeFormat));
    sb.write('\n$message');
    sb.write('\n${'ERROR: \n$providerError'}');
    sb.write('\n${'STACK TRACE: \n$providerStackTrace'}');
    return sb.toString();
  }
}

class RiverpodMutationReset extends TalkerLog {
  RiverpodMutationReset({
    required this.provider,
    required this.value,
    required this.settings,
  }) : super(
          _defaultMessage(
            provider: provider,
            suffix: 'Mutation Reset',
          ),
        );
  final ProviderBase<Object?> provider;
  final Object? value;
  final TalkerRiverpodLoggerSettings settings;

  @override
  String? get key => "Riverpod-Mutation-Reset";

  @override
  String generateTextMessage({
    TimeFormat timeFormat = TimeFormat.timeAndSeconds,
  }) {
    final sb = StringBuffer();
    sb.write(displayTitleWithTime(timeFormat: timeFormat));
    sb.write('\n$message');
    sb.write(
        '\n${'Reset state: ${settings.printStateFullData ? '\n$value' : value.runtimeType}'}');
    return sb.toString();
  }
}
