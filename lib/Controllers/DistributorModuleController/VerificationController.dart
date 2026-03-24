import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:franchaise_app/View/Distribution%20Module/BottomBar.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:http/http.dart' as http;

import '../../Appconfig.dart';


class DistributorVerificationController extends GetxController {
  RxBool isLoading = false.obs;

  RxString message = "".obs;

  RxString generalStatus = "".obs;
  RxString contactStatus = "".obs;
  RxString verificationStatus = "".obs;

  Future<void> getVerification() async {
    try {
      isLoading(true);

      String token = AppConfig.pref.getString("token") ?? "";

      final response = await http.get(
        Uri.parse("${AppConfig.baseURL}distibutor_verification"),
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
        },
      );

      final data = jsonDecode(response.body);

      if (data["status"] == 200) {
        message.value = data["message"] ?? "";

        var d = data["data"];

        generalStatus.value = (d["general_status"] ?? "").toString();
        contactStatus.value = (d["contact_status"] ?? "").toString();
        verificationStatus.value =
            (d["verification_status"] ?? "").toString();

        print("GENERAL → ${generalStatus.value}");
        print("CONTACT → ${contactStatus.value}");
        print("VERIFY → ${verificationStatus.value}");

        /// 🔥 AUTO NAVIGATION
        if (generalStatus.value.toLowerCase() == "approved" &&
            contactStatus.value.toLowerCase() == "approved" &&
            verificationStatus.value.toLowerCase() == "approved") {

          Get.offAll(() => DistributionBottomBarScreen());
        }

      } else {
        EasyLoading.showError( data["message"]);
      }
    } catch (e) {
      EasyLoading.showError("Something went wrong");
    } finally {
      isLoading(false);
    }
  }

  @override
  void onInit() {
    super.onInit();
    getVerification();
  }
}