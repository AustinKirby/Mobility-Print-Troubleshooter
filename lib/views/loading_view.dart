import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingView extends StatefulWidget {
  const LoadingView({super.key});

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<LoadingView> {
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(
      const Duration(seconds: 3),
      (timer) => navigateToTroubleshoot(),
    );
  }

  String _getRoute() {
    String _route = "";
    Navigator.of(context).popUntil((route) {
      _route = route.settings.name.toString();
      return true;
    });
    return _route;
  }

  void navigateToTroubleshoot() {
    if (_getRoute() == '/') {
      Navigator.pushNamed(context, '/troubleshoot');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          SpinKitThreeBounce(
            color: Colors.black,
          ),
          Text(
            "Loading Mobility Print Troubleshooter..",
            style: TextStyle(
              fontFamily: "Roboto",
              fontSize: 18.0,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
