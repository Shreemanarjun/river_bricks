import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:{{project_name.snakeCase()}}/core/local_storage/app_storage.dart';
import 'package:{{project_name.snakeCase()}}/core/local_storage/app_storage_pod.dart';
import 'package:{{project_name.snakeCase()}}/shared/riverpod_ext/riverpod_observer.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:hydrated_state_notifier/hydrated_state_notifier.dart';
import 'package:hydrated_state_notifier_hive/hydrated_state_notifier_hive.dart';

final talker = TalkerFlutter.init(
  settings: TalkerSettings(
    maxHistoryItems: null,
  ),
  logger: TalkerLogger(
    output: debugPrint,
  ),
);

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };
  WidgetsFlutterBinding.ensureInitialized();
  // Add cross-flavor configuration here
  final appStorage = AppStorage();
  await appStorage.initAppStorage();
  HydratedStorage.storage = await HiveHydratedStorage.build(
    storageDirectoryPath: kIsWeb ? '' : (await getTemporaryDirectory()).path,
  );
  runApp(
    ProviderScope(
      overrides: [
        appStorageProvider.overrideWithValue(appStorage),
      ],
      observers: [
        MyObserverLogger(
          talker: talker,
        ),
      ],
      child: await builder(),
    ),
  );
}
