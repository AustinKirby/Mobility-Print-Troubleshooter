import 'dart:developer';
import 'package:win32/win32.dart';
import 'package:win32/winrt.dart';

import 'package:printer_fleet_troubleshoot/src/net32/printerNames.dart';
import 'package:printer_fleet_troubleshoot/src/troubleshoot.dart';

class Printer implements Troubleshoot {
  late Iterable<String> _names;

  _parseNames() {
    final printerNames = PrinterNames(PRINTER_ENUM_LOCAL);
    try {
      _names = printerNames.all();
    } catch (e) {
      log(e.toString());
    }
  }

  Iterable<String> names() => _names;

  bool isPrinter(String name) {
    try {
      return _names.firstWhere((element) => element.contains(name)).isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<TroubleshootResult> troubleshoot() async {
    _parseNames();

    await Future.delayed(const Duration(seconds: 1));

    if (!isPrinter("Mobility-Print")) {
      return TroubleshootResult(
        message: "Did not find Mobility Print printer.",
        state: TroubleshootState.fail,
      );
    }

    return TroubleshootResult(
      message: "Mobility Print printer is installed.",
      state: TroubleshootState.success,
    );
  }
}
