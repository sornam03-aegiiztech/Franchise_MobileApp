import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:franchaise_app/Appconfig.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CustomerSubscriptionController extends GetxController {

  var isLoading = false.obs;

  var planType = "".obs;
  var planName = "".obs;
  var includedList = <String>[].obs;
  var message = "".obs;

  @override
  void onInit() {
    super.onInit();
    fetchSubscriptionPlan();
  }

  Future<void> fetchSubscriptionPlan() async {
    try {
      isLoading(true);

      final response = await http.get(
        Uri.parse("${AppConfig.baseURL}customer_subscription_plan"),
      );

      print("SUBSCRIPTION API → ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data["status"] == 200) {

          var plan = data["data"][0];

          planType.value = plan["plan_type"] ?? "";
          planName.value = plan["amount"] ?? "";
          includedList.value = List<String>.from(plan["included"] ?? []);

          message.value = data["message"];

          EasyLoading.showSuccess(message.value);
        }
      }
    } catch (e) {
      print("ERROR → $e");
      EasyLoading.showError("Something went wrong");
    } finally {
      isLoading(false);
    }
  }
}