import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:{{project_name.snakeCase()}}/l10n/l10n.dart';
import 'package:{{project_name.snakeCase()}}/shared/pods/locale_pod.dart';
import 'package:velocity_x/velocity_x.dart';

class AppLocalePopUp extends ConsumerWidget {
  const AppLocalePopUp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopupMenuButton<Locale>(
        initialValue: AppLocalizations.supportedLocales.first,
        icon: const Icon(Icons.translate),
        // Callback that sets the selected popup menu item.
        onSelected: (locale) {
          ref
              .read(localePod.notifier)
              .changeLocale(context: context, locale: locale);
        },
        itemBuilder: (BuildContext context) =>
            AppLocalizations.supportedLocales.map(
              (e) {
                final l10n = context.l10n;
                return PopupMenuItem<Locale>(
                  value: e,
                  child: l10n.localeName == e.toLanguageTag()
                      ? <Widget>[
                          const Icon(
                            Icons.check,
                            color: Colors.green,
                          ),
                          getLanguageName(e).text.bold.isIntrinsic.make(),
                        ].hStack()
                      : getLanguageName(e).text.isIntrinsic.make(),
                );
              },
            ).toList());
  }
}

String getLanguageName(Locale e) {
  final languageMap = {
    'en': 'English',
    'es': 'Spanish',
  };
  return languageMap[e.languageCode] ?? 'Unknown language';
}
