import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hydrated_state_notifier/hydrated_state_notifier.dart';
import 'package:{{project_name.snakeCase()}}/bootstrap.dart';
import 'package:{{project_name.snakeCase()}}/l10n/l10n.dart';

class LocaleNotifier extends HydratedStateNotifier<Locale> {
  LocaleNotifier() : super(const Locale.fromSubtags(languageCode: 'en'));

  void changeLocale({required BuildContext context, required Locale locale}) {
    final isSupported = AppLocalizations.supportedLocales.contains(locale);
    if (isSupported) {
      state = locale;
    } else {
      talker.debug('language not supported');
    }
  }

  @override
  Locale? fromJson(Map<String, dynamic> json) {
    return Locale.fromSubtags(languageCode: json['defaultLocale'] as String);
  }

  @override
  Map<String, dynamic>? toJson(Locale state) => {
        'defaultLocale': state.languageCode,
      };
}

final localePod = StateNotifierProvider.autoDispose<LocaleNotifier, Locale>(
  (ref) => LocaleNotifier(),
);
