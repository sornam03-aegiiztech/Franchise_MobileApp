import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:franchaise_app/Appconfig.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CustomerProfileController extends GetxController {


  var isLoading = false.obs;


  var fullName = "".obs;
  var email = "".obs;
  var phone = "".obs;
  var profileImage = "".obs;


  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();

  /// =========================
  /// GET PROFILE API
  /// =========================
  Future<void> getProfile() async {
    try {
      isLoading(true);

      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("token");

      final response = await http.get(
        Uri.parse("${AppConfig.baseURL}customer_profile_details"),
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json"
        },
      );

      print("API HIT → customer_profile_details");
      print("STATUS CODE → ${response.statusCode}");
      print("RESPONSE BODY → ${response.body}");

      final data = jsonDecode(response.body);

      if (data["status"] == 200) {

        final profile = data["data"];

        fullName.value = profile["full_name"] ?? "";
        email.value = profile["email"] ?? "";
        phone.value = profile["phone"] ?? "";
        profileImage.value = profile["profile_image"] ?? "";

        /// Set to textfields
        nameCtrl.text = fullName.value;
        emailCtrl.text = email.value;
        phoneCtrl.text = phone.value;

      } else {
       EasyLoading.showError(data["message"]);
      }

    } catch (e) {
      EasyLoading.showError(e.toString());
    } finally {
      isLoading(false);
    }
  }

  /// =========================
  /// UPDATE PROFILE API
  /// =========================
  Future<void> updateProfile(File? imageFile) async {
    try {
      isLoading(true);

      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("token");

      var request = http.MultipartRequest(
        "POST",
        Uri.parse("${AppConfig.baseURL}customer_profile_update"),
      );

      request.headers.addAll({
        "Authorization": "Bearer $token",
        "Accept": "application/json"
      });

      print("API HIT → customer_profile_update");
      print("FIELDS → ${request.fields}");
      print("IMAGE → ${imageFile?.path}");

      request.fields["full_name"] = nameCtrl.text;
      request.fields["email"] = emailCtrl.text;
      request.fields["phone"] = phoneCtrl.text;

      /// IMAGE (optional)
      if (imageFile != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            "profile_image",
            imageFile.path,
          ),
        );
      }

      var response = await request.send();
      var resBody = await response.stream.bytesToString();
      var data = jsonDecode(resBody);

      print("STATUS CODE → ${response.statusCode}");
      print("RESPONSE BODY → $resBody");

      if (data["status"] == 200) {
       EasyLoading.showSuccess(data["message"]);
        getProfile();
        Get.back();
      } else {
        EasyLoading.showError( data["message"]);
      }

    } catch (e) {
      EasyLoading.showSuccess(e.toString());
    } finally {
      isLoading(false);
    }
  }
}