import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/time_info.dart';

class WorldTimeApi {
  static const String baseUrl = "http://worldtimeapi.org/api";

  static Future<TimeInfo?>? getCurrentTime({required String timeZone}) async {
    http.Response res = await http.get("$baseUrl/ip" as Uri);
    if (res.statusCode == 200) {
      return TimeInfo.fromJson(jsonDecode(res.body));
    } else {
      return null;
    }
  }

  static Future<TimeInfo?> getTimezoneTime(String timeZone) async {
    http.Response res = await http.get("$baseUrl/timezone/$timeZone" as Uri);

    return TimeInfo.fromJson(jsonDecode(res.body));
  }

  static Future<List<String>?> getTimeZones() async {
    http.Response res = await http.get("$baseUrl/timezone" as Uri);
    return List<String>.from(jsonDecode(res.body));
  }
}
