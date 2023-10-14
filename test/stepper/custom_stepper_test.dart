import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:ui_pocket/main.dart';

import '../flutter_test_config.dart';

void main() {
  setUp(() {
    testExecutable(() {});
  });

  group('Golden tests', () {
    // デバイスサイズのリストを作成
    const deviceSizes = ['mobileS', 'mobileM', 'mobileL'];

    // それぞれのデバイスでマスター画像との差分があるか確認
    for (final deviceSize in deviceSizes) {
      testGoldens(
        'CustomStepperが正しく動作しているかのテスト - $deviceSize',
        (tester) async {
          const targetWidget = MyApp();
          await tester.pumpWidgetBuilder(targetWidget);
          await screenMatchesGolden(tester, 'sample_golden_test.$deviceSize');
        },
      );
    }
  });
}
