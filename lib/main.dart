import 'package:flutter/material.dart';
import 'package:printer_fleet_troubleshoot/views/loading_view.dart';
import 'package:printer_fleet_troubleshoot/views/balance_view.dart';
import 'package:printer_fleet_troubleshoot/views/troubleshoot_view.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  await windowManager.setResizable(false);

  WindowOptions windowOptions = const WindowOptions(
    size: Size(650, 550),
    maximumSize: Size(650, 550),
    center: true,
    skipTaskbar: false,
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Printer Fleet Troubleshooter',
      theme: ThemeData.light(useMaterial3: true),
      routes: {
        '/': ((context) => const LoadingView()),
        '/troubleshoot': ((context) => const TroubleshootView()),
        '/balance': ((context) => const BalanceView()),
      },
    );
  }
}
