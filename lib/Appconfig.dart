import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AppConfig {
  static String baseURL =
      "https://aegiiz.us/ffdj_application/api/";
  static String imageURL =
      "https://aegiiz.us/ffdj_application/upload/";

  AppConfig._();

  static late SharedPreferences pref;

  static init() async {
    pref = await SharedPreferences.getInstance();
  }

  static Map<String, String> header = {
    "Accept": "application/json",
    "Content-Type": "application/json",
  };

  static Future<dynamic> httpPost(String endPoint, dynamic body) async {
    try {
      final response = await http.post(
        Uri.parse(baseURL + endPoint),
        headers: header,
        body: jsonEncode(body),
      );

      print("POST URL → ${baseURL + endPoint}");
      print("Request → ${jsonEncode(body)}");
      print("Status → ${response.statusCode}");
      print("Response → ${response.body}");

      return jsonDecode(response.body);
    } catch (e) {
      EasyLoading.showError("Something went wrong");
      throw Exception("Service Error: $e");
    }
  }

  static Future<dynamic> httpGet(String endPoint) async {
    try {
      final response = await http.get(
        Uri.parse(baseURL + endPoint),
        headers: header,
      );

      print("GET URL → ${baseURL + endPoint}");

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return null;
      }
    } catch (e) {
      EasyLoading.showError("Something went wrong");
      throw Exception("Service Error: $e");
    }
  }
}