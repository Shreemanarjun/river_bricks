import 'dart:async';
import 'package:duration/duration.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:{{project_name.snakeCase()}}/shared/riverpod_ext/asynvalue_easy_when.dart';
import 'package:velocity_x/velocity_x.dart';

final timerProvider = StreamProvider.autoDispose<int>(
  (ref) {
    final streamController = StreamController<int>();
    final subscription =
        Stream.periodic(const Duration(milliseconds: 10), (count) => count)
            .listen((elapsedTime) {
      streamController.add(elapsedTime);
    });
    ref.onCancel(() async {
      await subscription.cancel();
      await streamController.close();
    });
    ref.onDispose(() async {
      await subscription.cancel();
      await streamController.close();
    });
    return streamController.stream;
  },
  name: 'timerProvider',
);

class CircularTimer extends StatelessWidget {
  const CircularTimer({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: Consumer(
            builder: (context, ref, child) {
              return ref.watch(timerProvider).easyWhen(
                    data: (milliseconds) => CircularProgressIndicator(
                      value: milliseconds / 1000,
                    ),
                  );
            },
          ),
        ),
        Positioned.fill(
          child: Center(
            child: Consumer(
              builder: (context, ref, child) {
                return ref.watch(timerProvider).easyWhen(
                  data: (milliseconds) {
                    final duration = printDuration(
                        Duration(milliseconds: milliseconds),
                        tersity: DurationTersity.millisecond,
                        abbreviated: true);
                    return duration.text.xs.isIntrinsic.xs.make();
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
