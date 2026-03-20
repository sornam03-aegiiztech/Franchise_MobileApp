import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'dart:io';

import 'package:image_picker/image_picker.dart';

import '../../../Appconfig.dart';
import '../../../Controllers/FranchiseModuleAuthControllers/EditListingController.dart';

class EditListingScreen extends StatefulWidget {
  const EditListingScreen({super.key});

  @override
  State<EditListingScreen> createState() => _EditListingScreenState();
}

class _EditListingScreenState extends State<EditListingScreen> {
  final controller = Get.put(EditListingController());
  File? selectedImage;
  final ImagePicker picker = ImagePicker();




  /// PICK IMAGE
  Future pickImage(ImageSource source) async {
    final picked = await picker.pickImage(source: source);

    if (picked != null) {
      File file = File(picked.path);

      setState(() {
        selectedImage = file;
      });

      controller.selectedImageFile = file; // 🔥 ADD THIS
    }
  }

  /// CAMERA / GALLERY OPTION
  void showImageOption() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SafeArea(
            child: Wrap(
              children: [

                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text("Camera"),
                  onTap: () {
                    Navigator.pop(context);
                    pickImage(ImageSource.camera);
                  },
                ),

                ListTile(
                  leading: const Icon(Icons.photo),
                  title: const Text("Gallery"),
                  onTap: () {
                    Navigator.pop(context);
                    pickImage(ImageSource.gallery);
                  },
                ),
              ],
            ),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    controller.getFranchiseDetails();
  }

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xff1f1f1f),

      appBar: AppBar(
        backgroundColor: const Color(0xff1f1f1f),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Edit Listing",
          style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600),
        ),
      ),

      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [

              /// IMAGE SECTION
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: SizedBox(
                      height: 160,
                      width: width,
                      child: Builder(
                        builder: (context) {
                          /// ✅ FINAL IMAGE URL
                          String finalImageUrl = controller.imageUrl.value.isNotEmpty
                              ? "${AppConfig.imageURL}${controller.imageUrl.value}"
                              : "";

                          print("IMAGE NAME → ${controller.imageUrl.value}");
                          print("FINAL IMAGE URL → $finalImageUrl");

                          /// ✅ IMAGE LOGIC
                          if (selectedImage != null) {
                            return Image.file(
                              selectedImage!,
                              fit: BoxFit.cover,
                            );
                          } else if (finalImageUrl.isNotEmpty) {
                            return Image.network(
                              finalImageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                print("❌ IMAGE LOAD ERROR → $error");
                                return Image.asset(
                                  "assets/images/applogo.png",
                                  fit: BoxFit.cover,
                                );
                              },
                            );
                          } else {
                            return Image.asset(
                              "assets/images/applogo.png",
                              fit: BoxFit.cover,
                            );
                          }
                        },
                      ),
                    ),
                  ),

                  /// 🔲 Dark overlay
                  Container(
                    height: 160,
                    width: width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black.withOpacity(0.4),
                    ),
                  ),

                  /// 📷 Change Image Button
                  Positioned.fill(
                    child: Center(
                      child: GestureDetector(
                        onTap: showImageOption,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: Icon(
                                Icons.camera_alt_outlined,
                                color: Colors.black,
                                size: 24,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Change Image",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              /// CARD CONTAINER
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xff3F3F3F),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [

                    _buildField(
                      label: "Brand Name",
                      controller: controller.brandController,
                    ),

                    const SizedBox(height: 14),

                    _buildDropdown(),

                    const SizedBox(height: 14),

                    _buildDescription(),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              /// INVESTMENT CARD
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xff3F3F3F),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [

                    _buildField(
                      label: "Total Investment",
                      controller: controller.investController,
                    ),

                    const SizedBox(height: 14),

                    _buildField(
                      label: "Franchise Fee",
                      controller: controller.feeController,
                    ),

                    const SizedBox(height: 14),

                    _buildField(
                      label: "Liquid Capital Required",
                      controller: controller.capitalController,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              /// UPDATE BUTTON
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffff4d4d),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    controller.updateFranchise(
                      categoryValue: controller.category.value,
                    );
                  },
                  child: const Text(
                    "Update Listing",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600, color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        );
      }
      ),
      );

  }

  /// TEXT FIELD
  Widget _buildField({
    required String label,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white70)),
        const SizedBox(height: 6),

        TextField(
          controller: controller,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xff3a3a3a),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        )
      ],
    );
  }

  /// DROPDOWN
  Widget _buildDropdown() {
    final List<String> categories = ["Food Industry", "Retail","Education", "Healthcare", "Technology"];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Business Category",
          style: TextStyle(color: Colors.white70),
        ),

        const SizedBox(height: 6),

        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: const Color(0xff3a3a3a),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.white),
          ),
          child: DropdownButtonHideUnderline(
            child: Obx(() {
              return DropdownButton<String>(
                dropdownColor: const Color(0xff3a3a3a),

                /// ✅ SAFE VALUE (important)
                value: categories.contains(controller.category.value)
                    ? controller.category.value
                    : categories.first,

                isExpanded: true,

                /// ✅ DYNAMIC ITEMS (no const)
                items: categories.map((item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                }).toList(),

                /// ✅ UPDATE VALUE
                onChanged: (value) {
                  if (value != null) {
                    controller.category.value = value;
                  }
                },
              );
            }),
          ),
        ),
      ],
    );
  }

  /// DESCRIPTION
  Widget _buildDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const Text(
          "Business Description",
          style: TextStyle(color: Colors.white70),
        ),

        const SizedBox(height: 6),

        TextField(
          controller: controller.descController,
          maxLines: 4,
          style: const TextStyle(color: Colors.white),

          decoration: InputDecoration(
            hintText:
            "Eco-Wash System is a revolutionary car wash franchise...",

            hintStyle: const TextStyle(color: Colors.white38),

            filled: true,
            fillColor: const Color(0xff3a3a3a),

            contentPadding: const EdgeInsets.all(16),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Colors.white),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Colors.white),
            ),
          ),
        )
      ],
    );
  }
}