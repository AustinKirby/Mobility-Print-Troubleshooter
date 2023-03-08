import 'package:flutter/material.dart';

class BalanceWidget extends StatelessWidget {
  final String balance;

  const BalanceWidget(this.balance, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 50,
      margin: EdgeInsets.only(top: 15, left: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Balance",
            style: TextStyle(
              fontFamily: "Roboto",
              fontSize: 18,
            ),
          ),
          const Spacer(),
          Text(balance),
        ],
      ),
    );
  }
}
