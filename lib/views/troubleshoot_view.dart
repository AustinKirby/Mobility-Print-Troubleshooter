import 'dart:async';

import 'package:flutter/material.dart';
import 'package:printer_fleet_troubleshoot/components/footer.dart';
import 'package:printer_fleet_troubleshoot/components/troubleshoot_row.dart';
import 'package:printer_fleet_troubleshoot/src/firewall.dart';
import 'package:printer_fleet_troubleshoot/src/network.dart';
import 'package:printer_fleet_troubleshoot/src/printer.dart';
import 'package:printer_fleet_troubleshoot/src/vpn.dart';
import 'package:printer_fleet_troubleshoot/views/balance_view.dart';

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        const BalanceView(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

class TroubleshootView extends StatefulWidget {
  const TroubleshootView({super.key});

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<TroubleshootView> {
  Timer? timer;

  @override
  void initState() {
    super.initState();

    timer = Timer(
      const Duration(seconds: 1),
      () => startTroubleshooter(),
    );
  }

  startTroubleshooter() {
    timer?.cancel();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(
          left: 0.0,
          top: 10.0,
        ),
        child: Column(
          children: [
            const Text(
              "Mobility Print Troubleshooter",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "Roboto",
                fontSize: 18.0,
              ),
            ),
            TroubleshootRow(
              Icons.print_outlined,
              "Printers",
              "Checking computer's list of printers..",
              Printer(),
            ),
            TroubleshootRow(
              Icons.wifi_outlined,
              "Internet",
              "Checking computer's internet connection..",
              Network(),
            ),
            TroubleshootRow(
              Icons.cloud_off_outlined,
              "Firewall",
              "Checking computer's firewall settings..",
              Firewall(),
            ),
            TroubleshootRow(
              Icons.vpn_lock_outlined,
              "VPN",
              "Checking computer's VPN settings..",
              VPN(),
            ),
            Container(
              padding: EdgeInsets.only(top: 15.0, right: 15.0, left: 15.0),
              child: Row(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(_createRoute());
                    },
                    child: Container(
                      width: 120,
                      child: Row(children: const [
                        Text("Check Balance"),
                        Spacer(),
                        Icon(Icons.chevron_right_outlined),
                      ]),
                    ),
                  ),
                  Spacer(),
                  ElevatedButton(
                    onPressed: () => {
                      Navigator.popUntil(
                        context,
                        (route) => route.settings.name.toString() == "/",
                      )
                    },
                    child: Container(
                      width: 65,
                      child: Row(
                        children: const [
                          Icon(Icons.refresh_outlined),
                          Spacer(),
                          Text("Scan"),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Footer(),
    );
  }
}
