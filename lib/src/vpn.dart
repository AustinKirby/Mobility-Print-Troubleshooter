import 'package:printer_fleet_troubleshoot/src/troubleshoot.dart';
import 'package:http/http.dart' as http;

class VPN implements Troubleshoot {
  static const URL =
      "https://acprint.algonquincollege.com:9192/app?service=page/Home";

  @override
  Future<TroubleshootResult> troubleshoot() async {
    try {
      final res = await http.Client().get(Uri.parse(URL));

      if (res.statusCode != 200) {
        throw Exception("Could not connect.");
      }
    } catch (e) {
      return TroubleshootResult(
        message: "There appears to be a VPN.",
        state: TroubleshootState.fail,
      );
    }

    return TroubleshootResult(
      message: "There is no VPN.",
      state: TroubleshootState.success,
    );
  }
}
