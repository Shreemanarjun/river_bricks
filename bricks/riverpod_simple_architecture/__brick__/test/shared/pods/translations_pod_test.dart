import 'package:flutter_riverpod/misc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:example/shared/pods/translation_pod.dart';

void main() {
  test('translationsPod throws UnimplementedError when not overridden', () {
    final container = ProviderContainer.test();

    expect(
      () => container.read(translationsPod),
      throwsA(
        isA<ProviderException>().having(
          (s) => s.exception,
          'exception',
          isA<UnimplementedError>(),
        ),
      ),
    );
  });
}
