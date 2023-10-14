import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

Future testExecutable(FutureOr Function() testMain) async {
  return GoldenToolkit.runWithConfiguration(
    () async {
      await loadAppFonts();
      await testMain();
    },
    config: GoldenToolkitConfiguration(
      // 複数のデバイスとを登録する。
      defaultDevices: const [
        Device(
          name: 'mobileS',
          size: Size(360, 720),
          devicePixelRatio: 3,
          safeArea: EdgeInsets.only(top: 44, bottom: 34),
        ),
        Device(
          name: 'mobileM',
          size: Size(390, 844),
          devicePixelRatio: 3,
          safeArea: EdgeInsets.only(top: 44, bottom: 34),
        ),
        Device(
          name: 'mobileL',
          size: Size(428, 926),
          devicePixelRatio: 3,
          safeArea: EdgeInsets.only(top: 44, bottom: 34),
        ),
      ],
      skipGoldenAssertion: () => !Platform.isMacOS,
    ),
  );
}
