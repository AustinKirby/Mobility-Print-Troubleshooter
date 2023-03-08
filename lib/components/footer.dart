import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.0,
      padding: const EdgeInsets.only(top: 5.0, left: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Program developed by: ",
            style: TextStyle(
              fontFamily: "Roboto",
              fontSize: 14,
            ),
          ),
          InkWell(
            onTap: () async {
              try {
                if (await canLaunchUrl(
                    Uri.parse("https://www.linkedin.com/in/austinkirby/"))) {
                  await launchUrl(
                      Uri.parse("https://www.linkedin.com/in/austinkirby/"));
                }
              } catch (e) {
                log(e.toString());
              }
            },
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Text(
                "Austin Kirby",
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
