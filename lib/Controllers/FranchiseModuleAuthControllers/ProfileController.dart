import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:franchaise_app/View/Distribution%20Module/BottomScreens/ProfileScreen.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../Appconfig.dart';


class FranchiseProfileController extends GetxController {

  var isLoading = false.obs;


  var nameController = "".obs;
  var mobileController = "".obs;
  var emailController = "".obs;
  var profileImage = "".obs;
  var businessName = "".obs;
  var ownerName = "".obs;


  final nameTextController = TextEditingController();
  final mobileTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final OwnerTextController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getProfile(); // 🔥 AUTO CALL
  }

  /// ---------------- GET PROFILE ----------------
  Future<void> getProfile() async {
    try {
      isLoading(true);

      String? token = AppConfig.pref.getString("token");

      final response = await http.get(
        Uri.parse("${AppConfig.baseURL}franchise_profile_details"),
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json"
        },
      );

      print("GET PROFILE → ${response.body}");
      print("TOKEN → $token");
      print("NAME → ${ownerName.value}");
      print("IMAGE → ${profileImage.value}");

      final data = jsonDecode(response.body);

      if (data["status"] == 200) {

        var profile = data["data"];

        nameTextController.text = profile["business_name"] ?? "";
        mobileTextController.text = profile["business_mobile"] ?? "";
        emailTextController.text = profile["business_email"] ?? "";
        OwnerTextController .text = profile["owner_name"] ?? "";

        businessName.value = profile["business_name"] ?? "";
        ownerName.value = profile["owner_name"] ?? "";
        profileImage.value = profile["profile_image"] != null
            ? "${AppConfig.imageURL}${profile["profile_image"]}"
            : "";

        EasyLoading.showSuccess( data["message"]);

      } else {
        EasyLoading.showError(data["message"]);
      }

    } catch (e) {
      EasyLoading.showError("Exception occurred");
    } finally {
      isLoading(false);
    }
  }

  /// ---------------- UPDATE PROFILE ----------------
  // Future<void> updateProfile() async {
  //   try {
  //     isLoading(true);
  //
  //     String? token = AppConfig.pref.getString("token");
  //
  //     final response = await http.post(
  //       Uri.parse("${AppConfig.baseURL}franchise_profile_update"),
  //       headers: {
  //         "Authorization": "Bearer $token",
  //         "Accept": "application/json"
  //       },
  //       body: {
  //         "business_name": nameTextController.text,
  //         "owner_name":OwnerTextController.text,
  //         "business_mobile": mobileTextController.text,
  //         "business_email": emailTextController.text,
  //       },
  //     );
  //
  //     print("UPDATE PROFILE → ${response.body}");
  //
  //     final data = jsonDecode(response.body);
  //
  //     if (data["status"] == 200) {
  //       EasyLoading.showSuccess(data["message"]);
  //       getProfile();
  //       Get.back();
  //     } else {
  //       String errorMessage = data["error"] ?? data["message"];
  //       EasyLoading.showError( errorMessage);
  //     }
  //
  //   } catch (e) {
  //     EasyLoading.showError("Exception occurred");
  //   } finally {
  //     isLoading(false);
  //   }
  // }
  Future<void> updateProfile(File? imageFile) async {
    try {
      isLoading(true);

      String? token = AppConfig.pref.getString("token");

      var request = http.MultipartRequest(
        "POST",
        Uri.parse("${AppConfig.baseURL}franchise_profile_update"),
      );

      request.headers.addAll({
        "Authorization": "Bearer $token",
        "Accept": "application/json",
      });

      request.fields.addAll({
        "business_name": nameTextController.text,
        "owner_name": OwnerTextController.text,
        "business_mobile": mobileTextController.text,
        "business_email": emailTextController.text,
      });

      /// 🔥 IMAGE ADD HERE
      if (imageFile != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            "profile_image", // ⚠️ KEY CONFIRM WITH BACKEND
            imageFile.path,
          ),
        );
      }

      var response = await request.send();
      var resBody = await response.stream.bytesToString();

      print("UPDATE PROFILE → $resBody");

      final data = jsonDecode(resBody);

      if (data["status"] == 200) {
        EasyLoading.showSuccess(data["message"]);
        getProfile();
        Get.back();
      } else {
        EasyLoading.showError(data["message"]);
      }

    } catch (e) {
      EasyLoading.showError("Exception occurred");
    } finally {
      isLoading(false);
    }
  }
}