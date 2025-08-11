import 'package:{{project_name.snakeCase()}}/shared/riverpod_ext/riverpod_observer/riverpod_log.dart';
import 'package:flutter_riverpod/experimental/mutation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:talker_flutter/talker_flutter.dart';

// coverage:ignore-file
class TalkerRiverpodLoggerSettings {
  const TalkerRiverpodLoggerSettings({
    this.enabled = true,
    this.printProviderAdded = true,
    this.printProviderUpdated = true,
    this.printProviderDisposed = false,
    this.printProviderFailed = true,
    this.printStateFullData = true,
    this.printFailFullData = true,
    this.didFailFilter,
    this.providerFilter,
  });

  final bool enabled;
  final bool printProviderAdded;
  final bool printProviderUpdated;
  final bool printProviderDisposed;
  final bool printProviderFailed;
  final bool printStateFullData;
  final bool printFailFullData;
  final bool Function(Object error)? didFailFilter;
  final bool Function(ProviderBase<Object?> provider)? providerFilter;
}

/// [Riverpod] logger on [Talker] base
///
/// [talker] field is the current [Talker] instance.
/// Provide your instance if your application uses [Talker] as the default logger
/// Common Talker instance will be used by default
class TalkerRiverpodObserver extends ProviderObserver {
  TalkerRiverpodObserver({
    Talker? talker,
    this.settings = const TalkerRiverpodLoggerSettings(),
  }) {
    _talker = talker ?? Talker();
  }

  late Talker _talker;
  final TalkerRiverpodLoggerSettings settings;

  @override
  void didAddProvider(
    ProviderObserverContext context,
    Object? value,
  ) {
    super.didAddProvider(
      context,
      value,
    );
    if (!settings.enabled || !settings.printProviderAdded) {
      return;
    }
    final accepted = settings.providerFilter?.call(context.provider) ?? true;
    if (!accepted) {
      return;
    }
    _talker.logCustom(
      RiverpodAddLog(
        provider: context.provider,
        value: value,
        settings: settings,
      ),
    );
  }

  @override
  void didUpdateProvider(
    ProviderObserverContext context,
    Object? previousValue,
    Object? newValue,
  ) {
    super.didUpdateProvider(context, previousValue, newValue);
    if (!settings.enabled || !settings.printProviderUpdated) {
      return;
    }
    final accepted = settings.providerFilter?.call(context.provider) ?? true;
    if (!accepted) {
      return;
    }
    _talker.logCustom(
      RiverpodUpdateLog(
        provider: context.provider,
        previousValue: previousValue,
        newValue: newValue,
        settings: settings,
      ),
    );
  }

  @override
  void didDisposeProvider(
    ProviderObserverContext context,
  ) {
    super.didDisposeProvider(context);
    if (!settings.enabled || !settings.printProviderDisposed) {
      return;
    }
    final accepted = settings.providerFilter?.call(context.provider) ?? true;
    if (!accepted) {
      return;
    }
    _talker.logCustom(
      RiverpodDisposeLog(
        provider: context.provider,
        settings: settings,
      ),
    );
  }

  @override
  void providerDidFail(
    ProviderObserverContext context,
    Object error,
    StackTrace stackTrace,
  ) {
    super.providerDidFail(context, error, stackTrace);
    if (!settings.enabled || !settings.printProviderFailed) {
      return;
    }
    final accepted = settings.providerFilter?.call(context.provider) ?? true;
    if (!accepted) {
      return;
    }

    try {
      final errorFiltered = settings.didFailFilter?.call(error) ?? true;
      if (!errorFiltered) {
        return;
      }
    } catch (_) {
      return;
    }

    _talker.logCustom(
      RiverpodFailLog(
        provider: context.provider,
        providerError: error,
        providerStackTrace: stackTrace,
        settings: settings,
      ),
    );
  }

  @override
  void mutationStart(
      ProviderObserverContext context, Mutation<Object?> mutation) {
    _talker.logCustom(
      RiverpodMutationStart(
        provider: context.provider,
        value: context.container.read(context.provider),
        settings: settings,
      ),
    );
    super.mutationStart(context, mutation);
  }

  @override
  void mutationSuccess(ProviderObserverContext context,
      Mutation<Object?> mutation, Object? result) {
    _talker.logCustom(
      RiverpodMutationUpdate(
        provider: context.provider,
        previousValue: context.container.read(context.provider),
        newValue: result,
        settings: settings,
      ),
    );
    super.mutationSuccess(context, mutation, result);
  }

  @override
  void mutationError(ProviderObserverContext context,
      Mutation<Object?> mutation, Object error, StackTrace stackTrace) {
    _talker.logCustom(
      RiverpodMutationError(
        provider: context.provider,
        providerError: error,
        providerStackTrace: stackTrace,
        settings: settings,
      ),
    );
    super.mutationError(context, mutation, error, stackTrace);
  }

  @override
  void mutationReset(
      ProviderObserverContext context, Mutation<Object?> mutation) {
    _talker.logCustom(
      RiverpodMutationReset(
        provider: context.provider,
        value: context.container.read(context.provider),
        settings: settings,
      ),
    );
    super.mutationReset(context, mutation);
  }
}
