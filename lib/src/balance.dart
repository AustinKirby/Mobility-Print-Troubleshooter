import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class Balance {
  static Future<String> GetBalance(String username) async {
    try {
      var res = await http.Client().get(Uri.parse(
          "https://acprint.algonquincollege.com:9192/rpc/api/web/user/$username/details.json"));

      var json = jsonDecode(res.body.toString());
      log(json['balanceFormatted']);

      return json['balanceFormatted'] ?? "\$0.00";
    } catch (e) {
      return "\$0.00";
    }
  }
}
