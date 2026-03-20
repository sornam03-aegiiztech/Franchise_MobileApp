import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../Appconfig.dart';

class EditListingController extends GetxController {


  final brandController = TextEditingController();
  final descController = TextEditingController();
  final investController = TextEditingController();
  final feeController = TextEditingController();
  final capitalController = TextEditingController();

  var isLoading = false.obs;


  var brandName = "".obs;
  var category = "".obs;
  var description = "".obs;
  var investment = "".obs;
  var fee = "".obs;
  var capital = "".obs;
  var imageUrl = "".obs;
  File? selectedImageFile;


  Future<void> getFranchiseDetails() async {
    try {
      isLoading(true);

      String token = AppConfig.pref.getString("token") ?? "";

      print("TOKEN → $token");

      if (token.isEmpty) {
        EasyLoading.showError("Missing token");
        return;
      }

      final url = "${AppConfig.baseURL}franchise_details";

      print("API URL → $url");

      final response = await http.get(
        Uri.parse(url),
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
        },
      );

      print("STATUS → ${response.statusCode}");
      print("RESPONSE → ${response.body}");

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        var details = data["data"];

        brandController.text = details["brand_name"] ?? "";
        descController.text = details["business_description"] ?? "";
        investController.text = details["total_invesment"] ?? "";
        feeController.text = details["franchise_fee"] ?? "";
        capitalController.text = details["liquid_capital_requried"] ?? "";

        brandName.value = details["brand_name"] ?? "";
        category.value = details["business_category"] ?? "Food Industry";
        description.value = details["business_description"] ?? "";
        investment.value = details["total_invesment"] ?? "";
        fee.value = details["franchise_fee"] ?? "";
        capital.value = details["liquid_capital_requried"] ?? "";
        imageUrl.value = details["image"] ?? "";

      } else {
        EasyLoading.showError(data["message"] ?? "Failed");
      }

    } catch (e) {
      EasyLoading.showError(e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateFranchise({
    required String categoryValue,
  }) async {
    try {
      EasyLoading.show(status: "Updating...");


      String token = AppConfig.pref.getString("token") ?? "";


      if (token.isEmpty) {
        EasyLoading.showError("Missing token");
        return;
      }

      var request = http.MultipartRequest(
        'POST',
        Uri.parse("${AppConfig.baseURL}franchise_update"),
      );


      request.headers.addAll({
        "Authorization": "Bearer $token",
        "Accept": "application/json",
      });


      // request.fields['franchise_id'] = franchiseId;
      request.fields['brand_name'] = brandController.text;
      request.fields['business_category'] = categoryValue;
      request.fields['business_description'] = descController.text;
      request.fields['total_invesment'] = investController.text;
      request.fields['franchise_fee'] = feeController.text;
      request.fields['liquid_capital_requried'] = capitalController.text;


      if (selectedImageFile != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'image',
            selectedImageFile!.path,
          ),
        );
      }

      print("UPDATE API → ${AppConfig.baseURL}franchise_update");
      print("FIELDS → ${request.fields}");

      var response = await request.send();
      var resBody = await response.stream.bytesToString();

      EasyLoading.dismiss();

      print("STATUS → ${response.statusCode}");
      print("RESPONSE → $resBody");

      var data = jsonDecode(resBody);

      if (response.statusCode == 200) {
        EasyLoading.showSuccess(data["message"] ?? "Updated Successfully");
        Get.back();
      } else {
        EasyLoading.showError(data["message"] ?? "Update Failed");
      }

    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError(e.toString());
    }
  }


  @override
  void onClose() {
    brandController.dispose();
    descController.dispose();
    investController.dispose();
    feeController.dispose();
    capitalController.dispose();
    super.onClose();
  }
}