import 'package:flutter/material.dart';
import 'package:printer_fleet_troubleshoot/components/balance.dart';
import 'package:printer_fleet_troubleshoot/components/footer.dart';
import 'package:printer_fleet_troubleshoot/components/username_form.dart';
import 'package:printer_fleet_troubleshoot/src/balance.dart';

class BalanceView extends StatefulWidget {
  const BalanceView({super.key});

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<BalanceView> {
  String balance = "\$0.00";

  _handleUsernameChange(String username) {
    Balance.GetBalance(username).then(
      (value) {
        setState(() {
          balance = value;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Check Balance"),
      ),
      body: Container(
        width: 500,
        height: 160,
        margin: const EdgeInsets.symmetric(vertical: 50, horizontal: 70),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 220,
              height: 160,
              child: UsernameForm(
                onUsernameChange: _handleUsernameChange,
              ),
            ),
            BalanceWidget(balance),
          ],
        ),
      ),
      bottomSheet: const Footer(),
    );
  }
}
