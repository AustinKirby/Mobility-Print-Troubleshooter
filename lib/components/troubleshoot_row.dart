import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:printer_fleet_troubleshoot/src/troubleshoot.dart';
import 'package:url_launcher/url_launcher.dart';

class TroubleshootRow extends StatefulWidget {
  final IconData icon;
  final String title, description;
  final Troubleshoot troubleshoot;

  const TroubleshootRow(
    this.icon,
    this.title,
    this.description,
    this.troubleshoot, {
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<TroubleshootRow> {
  Timer? timer;
  TroubleshootState state = TroubleshootState.none;
  String description = "";

  @override
  void initState() {
    super.initState();
    timer = Timer(const Duration(seconds: 1), () => startTroubleshooter());

    setState(() {
      description = widget.description;
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  startTroubleshooter() {
    setState(() {
      state = TroubleshootState.loading;
    });

    widget.troubleshoot.troubleshoot().then((value) {
      setState(() {
        state = value.state;
        description = value.message ?? "";
      });
    });
  }

  Color _getBorderColor() {
    switch (state) {
      case TroubleshootState.success:
        return Colors.green;
      case TroubleshootState.fail:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 600.0,
      height: 80.0,
      margin: const EdgeInsets.only(top: 10.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: _getBorderColor(),
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 50.0,
          ),
          StateIcon(state),
          Container(
            width: 20.0,
          ),
          Icon(widget.icon),
          Container(
            width: 10.0,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontFamily: "Roboto",
                ),
              ),
              Text(
                description,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class StateIcon extends StatelessWidget {
  final TroubleshootState state;

  const StateIcon(this.state, {super.key});

  @override
  Widget build(BuildContext context) {
    switch (state) {
      case TroubleshootState.loading:
        return const SpinKitCircle(
          color: Colors.black,
          size: 20.0,
        );
      case TroubleshootState.success:
        return const Icon(
          Icons.check_circle_outline,
          size: 20.0,
        );
      case TroubleshootState.fail:
        return const Icon(
          Icons.error_outline,
          size: 20.0,
        );
      default:
        return Container(
          width: 20.0,
        );
    }
  }
}
