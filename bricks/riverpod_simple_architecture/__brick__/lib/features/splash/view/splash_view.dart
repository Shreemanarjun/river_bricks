import 'dart:async';

import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  late Future<bool> initialized;
  Future<bool> initialize() async {
    return false;
  }

  @override
  void initState() {
    super.initState();
    initialized = initialize();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initialized,
      builder: (context, snapshot) {
        return switch (snapshot.connectionState) {
          ConnectionState.none => throw UnimplementedError(),
          ConnectionState.waiting => throw UnimplementedError(),
          ConnectionState.active => throw UnimplementedError(),
          ConnectionState.done => throw UnimplementedError(),
        };
      },
    );
  }
}
