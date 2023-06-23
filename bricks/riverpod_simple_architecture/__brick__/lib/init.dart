import 'package:flutter/services.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:platform_info/platform_info.dart';

Future<void> init() async {
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await platform.when(
    android: FlutterDisplayMode.setHighRefreshRate,
  );
  await SystemChannels.textInput.invokeMethod('TextInput.hide');
}
