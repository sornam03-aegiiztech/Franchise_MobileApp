import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../Appconfig.dart';

class DistributorProfileController extends GetxController {

  var isLoading = false.obs;

  var profileImage = "".obs;

  var businessName = "".obs;
  var ownerName = "".obs;
  Rx<File?> selectedImage = Rx<File?>(null);

  final businessNameController = TextEditingController();
  final ownerNameController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getProfile();
  }

  /// ---------------- GET PROFILE ----------------
  Future<void> getProfile() async {
    try {
      isLoading(true);

      String? token = AppConfig.pref.getString("token");

      final response = await http.get(
        Uri.parse("${AppConfig.baseURL}distibutor_profile_details"),
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json"
        },
      );

      final data = jsonDecode(response.body);

      if (data["status"] == 200) {

        var profile = data["data"];

        businessNameController.text = profile["business_name"] ?? "";
        ownerNameController.text = profile["owner_name"] ?? "";
        mobileController.text = profile["business_mobile"] ?? "";
        emailController.text = profile["business_email"] ?? "";

        /// 🔥 IMAGE SET
        profileImage.value = profile["profile_image"] ?? "";
        businessName.value = profile["business_name"] ?? "";
        ownerName.value = profile["owner_name"] ?? "";


        EasyLoading.showSuccess(data["message"]);

      } else {
        EasyLoading.showError(data["message"]);
      }

    } catch (e) {
      EasyLoading.showError("Exception occurred");
    } finally {
      isLoading(false);
    }
  }

  /// ---------------- PICK IMAGE ----------------
  void setImage(File image){
    selectedImage.value = image;
     // UI refresh
  }

  /// ---------------- UPDATE PROFILE ----------------
  Future<void> updateProfile() async {
    try {
      isLoading(true);

      String? token = AppConfig.pref.getString("token");

      var request = http.MultipartRequest(
        "POST",
        Uri.parse("${AppConfig.baseURL}distibutor_profile_update"),
      );

      request.headers["Authorization"] = "Bearer $token";

      request.fields["business_name"] = businessNameController.text;
      request.fields["owner_name"] = ownerNameController.text;
      request.fields["business_mobile"] = mobileController.text;
      request.fields["business_email"] = emailController.text;


      /// 🔥 IMAGE UPLOAD
      if (selectedImage.value != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            "profile_image",
            selectedImage.value!.path,
          ),
        );
      }

      var response = await request.send();
      var responseData = await response.stream.bytesToString();

      print("UPDATE PROFILE → $responseData");

      final data = jsonDecode(responseData);

      if (data["status"] == 200) {
        EasyLoading.showSuccess(data["message"]);
        selectedImage.value = null;

        await getProfile();
        Get.back();
      } else {
        EasyLoading.showError(data["message"]);
      }

    } catch (e) {
      print("ERROR → $e");
      EasyLoading.showError("Exception occurred");
    } finally {
      isLoading(false);
    }
  }
}