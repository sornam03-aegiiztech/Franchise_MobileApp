import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../Appconfig.dart';


class FranchiseDashboardController extends GetxController {

  var isLoading = false.obs;

  var totalContactView = 0.obs;
  var profileView = 0.obs;
  var message = "".obs;

  @override
  void onInit() {
    super.onInit();
    fetchDashboardData();
  }

  Future<void> fetchDashboardData() async {
    try {
      isLoading(true);

      String? token = AppConfig.pref.getString("token");

      final response = await http.get(
        Uri.parse("${AppConfig.baseURL}franchise_dashboard"),
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
        },
      );

      print("DASHBOARD API → $response");
      print("API RESPONSE → ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data["status"] == 200) {
          totalContactView.value = data["total_contact_view"] ?? 0;
          profileView.value = data["profile_view"] ?? 0;
          message.value = data["message"] ?? "";
          EasyLoading.showSuccess(message.value);
        } else {
          EasyLoading.showError("Something went wrong");
        }
      } else {
        EasyLoading.showError("Server error");
      }
    } catch (e) {
      print("ERROR → $e");
     EasyLoading.showError("Exception occurred");
    } finally {
      isLoading(false);
    }
  }
}