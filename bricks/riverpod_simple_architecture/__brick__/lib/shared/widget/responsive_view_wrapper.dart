import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ResponsiveBreakPointWrapper extends StatelessWidget {
  final Widget child;
  const ResponsiveBreakPointWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBreakpoints.builder(
      child: ResponsiveViewWrapper(child: child),
      breakpoints: [
        const Breakpoint(start: 0, end: 440, name: MOBILE),
        const Breakpoint(start: 440, end: 880, name: TABLET),
        const Breakpoint(start: 880, end: 1920, name: DESKTOP),
        const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
      ],
    );
  }
}

class ResponsiveViewWrapper extends StatelessWidget {
  final Widget child;
  const ResponsiveViewWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MaxWidthBox(
      maxWidth: 3840,
      child: ResponsiveScaledBox(
        width: ResponsiveValue<double>(context, conditionalValues: [
          const Condition.equals(name: MOBILE, value: 420),
          const Condition.equals(name: TABLET, value: 800),
          const Condition.equals(name: DESKTOP, value: 968),
          const Condition.equals(name: '4K', value: 1921),
          // There are no conditions for width over 2668
          // because the `maxWidth` is set to 1200 via the MaxWidthBox.
        ]).value,
        child:
            BouncingScrollWrapper.builder(context, child, dragWithMouse: true),
      ),
    );
  }
}
