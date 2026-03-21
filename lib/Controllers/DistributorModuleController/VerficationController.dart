import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:franchaise_app/View/Distribution%20Module/Subscriptions/PremiumScreen.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../Appconfig.dart';

class DistributorDetailsController extends GetxController {

  final brandNameCtrl = TextEditingController();
  final territoryCtrl = TextEditingController();
  final unitsCtrl = TextEditingController();
  final daysCtrl = TextEditingController();
  final descCtrl = TextEditingController();

  final companyCtrl = TextEditingController();
  final mobileCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final cityCtrl = TextEditingController();
  final addressCtrl = TextEditingController();
  final postalCtrl = TextEditingController();

  final idNumberCtrl = TextEditingController();
  final gstCtrl = TextEditingController();



  Future<void> addDistributor({
    File? brandLogo,
    File? ownerImage,
    File? frontDoc,
    File? backDoc,
    File? document,

    required String brandName,
    required String category,
    required String territory,
    required String units,
    required String days,
    required String description,

    required String companyName,
    required String mobile,
    required String email,
    required String city,
    required String address,
    required String postalCode,

    required String idType,
    required String idNumber,
    required String gst,
  }) async {
    try {
      EasyLoading.show(status: "Submitting...");

      String? token = AppConfig.pref.getString("token");

      var uri = Uri.parse("${AppConfig.baseURL}add_distibutor");

      var request = http.MultipartRequest("POST", uri);


      request.headers.addAll({
        "Authorization": "Bearer $token",
      });


      request.fields.addAll({
        "brand_name": brandName,
        "business_category": category,
        "branch_territory": territory,
        "branch_territory_units": units,
        "branch_territory_day": days,
        "business_description": description,

        "company_name": companyName,
        "mobile": mobile,
        "email": email,
        "city": city,
        "address": address,
        "postal_code": postalCode,

        "id_document_type": idType,
        "document_id_number": idNumber,
        "rigistration_number": gst,
      });


      if (brandLogo != null) {
        request.files.add(await http.MultipartFile.fromPath(
            "brand_logo", brandLogo.path));
      }

      if (ownerImage != null) {
        request.files.add(await http.MultipartFile.fromPath(
            "owner_image", ownerImage.path));
      }

      if (frontDoc != null) {
        request.files.add(await http.MultipartFile.fromPath(
            "document_front_side", frontDoc.path));
      }

      if (backDoc != null) {
        request.files.add(await http.MultipartFile.fromPath(
            "document_back_side", backDoc.path));
      }

      if (document != null) {
        request.files.add(await http.MultipartFile.fromPath(
            "document", document.path));
      }


      var response = await request.send();
      var responseData = await http.Response.fromStream(response);

      EasyLoading.dismiss();

      final data = jsonDecode(responseData.body);

      print("ADD DISTRIBUTOR RESPONSE: $data");

      if (response.statusCode == 200 && data["status"] == 200) {
        EasyLoading.showSuccess(data["message"]);
        Get.to(ActivateDistributionScreen());
      } else {
        EasyLoading.showError(data["message"] ?? "Failed");
      }

    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError("Error: $e");
    }
  }

}