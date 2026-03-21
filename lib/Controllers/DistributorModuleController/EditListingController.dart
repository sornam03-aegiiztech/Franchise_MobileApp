import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../Appconfig.dart';

class DistributorEditListingController extends GetxController {

  /// ================================
  /// CONTROLLERS
  /// ================================
  final brandController = TextEditingController();
  final categoryController = TextEditingController();
  final territoryController = TextEditingController();
  final unitsController = TextEditingController();
  final daysController = TextEditingController();
  final descriptionController = TextEditingController();

  final companyController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();

  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final postalController = TextEditingController();

  final docTypeController = TextEditingController();
  final docNumberController = TextEditingController();
  final regNumberController = TextEditingController();

  /// ================================
  /// IMAGE FILES
  /// ================================
  File? brandLogoFile;
  File? ownerImageFile;
  File? docFrontFile;
  File? docBackFile;
  File? documentFile;

  var isLoading = false.obs;
  var brandImageUrl = "".obs;
  var ownerImageUrl = "".obs;


  bool validateFields() {
    if (brandController.text.trim().isEmpty) {
      EasyLoading.showToast("Enter Brand Name");
      return false;
    }

    if (categoryController.text.trim().isEmpty) {
      EasyLoading.showToast("Select Business Category");
      return false;
    }

    if (territoryController.text.trim().isEmpty) {
      EasyLoading.showToast("Enter Territory");
      return false;
    }

    if (unitsController.text.trim().isEmpty) {
      EasyLoading.showToast("Enter Units");
      return false;
    }

    if (daysController.text.trim().isEmpty) {
      EasyLoading.showToast("Enter Days");
      return false;
    }

    if (companyController.text.trim().isEmpty) {
      EasyLoading.showToast("Enter Company Name");
      return false;
    }

    /// 📱 Mobile validation
    if (mobileController.text.trim().isEmpty) {
      EasyLoading.showToast("Enter Mobile Number");
      return false;
    }

    if (mobileController.text.length != 10) {
      EasyLoading.showToast("Enter valid 10 digit mobile number");
      return false;
    }

    /// 📧 Email validation
    if (emailController.text.trim().isEmpty) {
      EasyLoading.showToast("Enter Email");
      return false;
    }

    if (!GetUtils.isEmail(emailController.text.trim())) {
      EasyLoading.showToast("Enter valid Email");
      return false;
    }

    if (addressController.text.trim().isEmpty) {
      EasyLoading.showToast("Enter Address");
      return false;
    }

    if (cityController.text.trim().isEmpty) {
      EasyLoading.showToast("Enter City");
      return false;
    }

    if (postalController.text.trim().isEmpty) {
      EasyLoading.showToast("Enter Postal Code");
      return false;
    }

    if (postalController.text.length < 5) {
      EasyLoading.showToast("Enter valid Postal Code");
      return false;
    }

    return true;
  }

  /// ================================
  /// GET DISTRIBUTOR DETAILS
  /// ================================
  Future<void> getDistributorDetails() async {
    try {
      isLoading(true);

      String token = AppConfig.pref.getString("token") ?? "";

      final url = "${AppConfig.baseURL}distibutor_details";

      final response = await http.get(
        Uri.parse(url),
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
        },
      );

      print("GET RESPONSE → ${response.body}");

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data["status"] == 200) {

        var details = data["data"];

        /// SET DATA
        brandController.text = details["brand_name"] ?? "";
        categoryController.text = details["business_category"] ?? "";
        territoryController.text = details["branch_territory"] ?? "";
        unitsController.text = details["branch_territory_units"] ?? "";
        daysController.text = details["branch_territory_day"] ?? "";
        descriptionController.text = details["business_description"] ?? "";

        companyController.text = details["company_name"] ?? "";
        mobileController.text = details["mobile"] ?? "";
        emailController.text = details["email"] ?? "";

        addressController.text = details["address"] ?? "";
        cityController.text = details["city"] ?? "";
        postalController.text = details["postal_code"] ?? "";

        docTypeController.text = details["id_document_type"] ?? "";
        docNumberController.text = details["document_id_number"] ?? "";
        regNumberController.text = details["rigistration_number"] ?? "";

        brandImageUrl.value = details["brand_logo"] ?? "";
        ownerImageUrl.value = details["owner_image"] ?? "";

        EasyLoading.showSuccess(data["message"]);

      } else {
        EasyLoading.showError(data["message"] ?? "No data found");
      }

    } catch (e) {
      EasyLoading.showError("Something went wrong");
    } finally {
      isLoading(false);
    }
  }

  /// ================================
  /// UPDATE DISTRIBUTOR (MULTIPART)
  /// ================================
  Future<void> updateDistributor() async {
    if (!validateFields()) return;
    try {
      EasyLoading.show(status: "Updating...");

      String token = AppConfig.pref.getString("token") ?? "";

      var request = http.MultipartRequest(
        'POST',
        Uri.parse("${AppConfig.baseURL}update_distibutor"),
      );

      /// HEADERS
      request.headers.addAll({
        "Authorization": "Bearer $token",
        "Accept": "application/json",
      });

      /// TEXT FIELDS
      request.fields['brand_name'] = brandController.text;
      request.fields['business_category'] = categoryController.text;
      request.fields['branch_territory'] = territoryController.text;
      request.fields['branch_territory_units'] = unitsController.text;
      request.fields['branch_territory_day'] = daysController.text;
      request.fields['business_description'] = descriptionController.text;

      request.fields['company_name'] = companyController.text;
      request.fields['mobile'] = mobileController.text;
      request.fields['email'] = emailController.text;

      request.fields['address'] = addressController.text;
      request.fields['city'] = cityController.text;
      request.fields['postal_code'] = postalController.text;

      request.fields['id_document_type'] = docTypeController.text;
      request.fields['document_id_number'] = docNumberController.text;
      request.fields['rigistration_number'] = regNumberController.text;

      /// FILES (OPTIONAL)
      if (brandLogoFile != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'brand_logo',
          brandLogoFile!.path,
        ));
      }

      if (ownerImageFile != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'owner_image',
          ownerImageFile!.path,
        ));
      }

      if (docFrontFile != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'document_front_side',
          docFrontFile!.path,
        ));
      }

      if (docBackFile != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'document_back_side',
          docBackFile!.path,
        ));
      }

      if (documentFile != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'document',
          documentFile!.path,
        ));
      }

      print("UPDATE API → ${request.url}");
      print("FIELDS → ${request.fields}");

      var response = await request.send();
      var resBody = await response.stream.bytesToString();

      EasyLoading.dismiss();

      print("RESPONSE → $resBody");

      var data = jsonDecode(resBody);

      if (response.statusCode == 200 && data["status"] == 200) {
        EasyLoading.showSuccess(data["message"]);
        Get.back();
      } else {
        EasyLoading.showError(data["message"] ?? "Update Failed");
      }

    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError(e.toString());
    }
  }

  /// ================================
  /// DISPOSE
  /// ================================
  @override
  void onClose() {
    brandController.dispose();
    categoryController.dispose();
    territoryController.dispose();
    unitsController.dispose();
    daysController.dispose();
    descriptionController.dispose();
    companyController.dispose();
    mobileController.dispose();
    emailController.dispose();
    addressController.dispose();
    cityController.dispose();
    postalController.dispose();
    docTypeController.dispose();
    docNumberController.dispose();
    regNumberController.dispose();
    super.onClose();
  }
}