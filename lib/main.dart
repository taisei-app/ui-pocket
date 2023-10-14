import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
// import 'package:ui_pocket/calendar/table_calendar_sample.dart';
import 'package:ui_pocket/stepper/custom_stepper.dart';

void main() {
  initializeDateFormatting().then(
    (_) => runApp(
      const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: CustomStepperPage(),
    );
  }
}

class CustomStepperPage extends StatelessWidget {
  const CustomStepperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CustomStepper(
          texts: [
            "電話番号\n認",
            "パスワード\n設定",
            "希望条件\n設定",
          ],
          currentStep: 1,
          steps: 3,
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("UI POCKET"),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomStepper(
              steps: 3,
              currentStep: 2,
              texts: [
                "電話番号\n認証",
                "パスワード\n設定",
                "希望条件\n設定",
              ],
              borderWidth: 3,
            ),
          ],
        ),
      ),
    );
  }
}
