import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:franchaise_app/View/Franchaise%20Module/BottomScreens/SubscriptionScreen.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../Appconfig.dart';
import '../../View/Franchaise Module/AuthModule/LoginScreen.dart';
import '../../View/Franchaise Module/Subscriptions/PremiumScreen.dart';

class FranchiseController extends GetxController {

  /// ================= TEXT CONTROLLERS =================
  final brandNameController = TextEditingController();
  final branchController = TextEditingController();
  final descController = TextEditingController();
  final ownerController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final addressController=TextEditingController();

  final investmentController = TextEditingController();
  final feeController = TextEditingController();
  final capitalController = TextEditingController();
  final unitController=TextEditingController();
  final regionsController= TextEditingController();
  final availableController=TextEditingController();
  final termController = TextEditingController();
  var selectedCategory = "".obs;

  /// ================= IMAGE FILES =================
  File? innerImageFile;
  File? ownerImageFile;
  File? govIdFile;
  File? licenseFile;
  File? subImage1;
  File? subImage2;
  var selectedBenefits = <String>[].obs;

  List<String> benefitsList = [
    "Training Provided",
    "Marketing Support",
    "High ROI",
    "Brand Recognition",
    "Low Investment",
  ];

  /// ================= FINAL API =================
  Future<void> addFranchise() async {
    try {


      if (brandNameController.text.isEmpty) {
        EasyLoading.showError("Enter Brand Name");
        return;
      }

      if (selectedCategory.value.isEmpty) {
        EasyLoading.showError("Select Category");
        return;
      }

      if (innerImageFile == null) {
        EasyLoading.showError("Upload Inner Image");
        return;
      }

      if (ownerImageFile == null) {
        EasyLoading.showError("Upload Owner Image");
        return;
      }

      if (govIdFile == null) {
        EasyLoading.showError("Upload Government ID");
        return;
      }

      if (mobileController.text.length != 10) {
        EasyLoading.showError("Enter valid mobile number");
        return;
      }

      if (!GetUtils.isEmail(emailController.text)) {
        EasyLoading.showError("Enter valid email");
        return;
      }

      EasyLoading.show(status: "Submitting...");

      String token = AppConfig.pref.getString("token") ?? "";
      String businessId = AppConfig.pref.getString("business_id") ?? "";

      print("TOKEN → $token");


      var request = http.MultipartRequest(
        'POST',
        Uri.parse("${AppConfig.baseURL}add_franchise"),
      );
      request.headers.addAll({
        "Authorization": "Bearer $token",
        "Accept": "application/json",
      });




      request.fields['brand_name'] = brandNameController.text;
      request.fields['business_category'] = selectedCategory.value;
      request.fields['branch_territory'] = branchController.text;
      request.fields['business_description'] = descController.text;
      request.fields['owner_company_name'] = ownerController.text;
      request.fields['mobile_number'] = mobileController.text;
      request.fields['business_email'] = emailController.text;
      request.fields['total_invesment'] = investmentController.text;
      request.fields['franchise_fee'] = feeController.text;
      request.fields['liquid_capital_requried'] = capitalController.text;
      request.fields['business_id'] = businessId;
      request.fields['units'] = unitController.text;
      request.fields['regions'] = regionsController.text;
      request.fields['term'] = termController.text;
      request.fields['address'] = addressController.text;
      request.fields['available_hours'] = availableController.text;

      /// 🔥 KEY BENEFITS
      request.fields['key_benefits_added'] = selectedBenefits.join(",");


      request.files.add(
        await http.MultipartFile.fromPath(
          'image',
          innerImageFile!.path,
        ),
      );

      request.files.add(
        await http.MultipartFile.fromPath(
          'brand_owner_image',
          ownerImageFile!.path,
        ),
      );

      request.files.add(
        await http.MultipartFile.fromPath(
          'goverment_issued_id',
          govIdFile!.path,
        ),
      );
      if (subImage1 != null) {
        print("SUB IMAGE 1 → ${subImage1?.path}");

        request.files.add(
          await http.MultipartFile.fromPath(
            'multible_image[]',
            subImage1!.path,
          ),
        );
      }

      if (subImage2 != null) {
        print("SUB IMAGE 2 → ${subImage2?.path}");
        request.files.add(
          await http.MultipartFile.fromPath(
            'multible_image[]',
            subImage2!.path,
          ),
        );
      }

      /// Optional (license may be null)
      if (licenseFile != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'business_license',
            licenseFile!.path,
          ),
        );
      }

      print("API URL → ${AppConfig.baseURL}add_franchise");
      print("FIELDS → ${request.fields}");
      print("FILES → ${request.files.map((e) => e.field).toList()}");
      print("BUSINESS ID → $businessId");

      /// 🔥 SEND REQUEST
      var response = await request.send();
      var resBody = await response.stream.bytesToString();

      EasyLoading.dismiss();

      print("STATUS → ${response.statusCode}");
      print("RESPONSE → $resBody");

      var data = jsonDecode(resBody);

      if (response.statusCode == 200) {
        EasyLoading.showSuccess(data["message"] ?? "Franchise Added");

        var franchiseData = data["data"];


        if (franchiseData != null && franchiseData["franchise_id"] != null) {
          await AppConfig.pref.setString("franchise_id", franchiseData["franchise_id"].toString(),);

          print("SAVED FRANCHISE ID → ${franchiseData["franchise_id"]}");
        }


        Get.to(() => ActivateFranchiseScreen());
      } else {
        EasyLoading.showError(data["message"] ?? "Failed");
      }

    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError("Error: ${e.toString()}");
    }
  }

  /// ================= DISPOSE =================
  @override
  void onClose() {
    brandNameController.dispose();
    branchController.dispose();
    descController.dispose();
    ownerController.dispose();
    mobileController.dispose();
    emailController.dispose();
    investmentController.dispose();
    feeController.dispose();
    capitalController.dispose();
    super.onClose();
  }
}