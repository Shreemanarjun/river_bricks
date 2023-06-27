import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:{{project_name.snakeCase()}}/core/theme/theme_controller.dart';

class ThemeSegmentedBtn extends ConsumerStatefulWidget {
  const ThemeSegmentedBtn({Key? key}) : super(key: key);

  @override
  ConsumerState<ThemeSegmentedBtn> createState() => _ThemeSegmentedBtnState();
}

class _ThemeSegmentedBtnState extends ConsumerState<ThemeSegmentedBtn> {
  Set<ThemeMode> selection = <ThemeMode>{
    ThemeMode.system,
  };
  @override
  void initState() {
    super.initState();
    selection = {ref.read(themecontrollerProvider)};
  }

  @override
  Widget build(BuildContext context) {
    return SegmentedButton(
      segments: const <ButtonSegment<ThemeMode>>[
        ButtonSegment<ThemeMode>(
          value: ThemeMode.light,
          icon: Icon(Icons.light_mode),
        ),
        ButtonSegment<ThemeMode>(
          value: ThemeMode.dark,
          icon: Icon(Icons.dark_mode),
        ),
        ButtonSegment<ThemeMode>(
          value: ThemeMode.system,
          icon: Icon(Icons.brightness_auto),
        ),
      ],
      selected: selection,
      onSelectionChanged: (thememodes) {
        setState(() {
          selection = thememodes;
        });
        ref
            .read(themecontrollerProvider.notifier)
            .changeTheme(thememodes.first);
      },
      style: const ButtonStyle(
          maximumSize: MaterialStatePropertyAll(Size.fromWidth(12))),
    );
  }
}
