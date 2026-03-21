import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'dart:io';

import 'package:image_picker/image_picker.dart';

import '../../../Appconfig.dart';
import '../../../Controllers/DistributorModuleController/EditListingController.dart';

class DistributionEditListingScreen extends StatefulWidget {
  const DistributionEditListingScreen({super.key});

  @override
  State<DistributionEditListingScreen> createState() => _DistributionEditListingScreenState();
}

class _DistributionEditListingScreenState extends State<DistributionEditListingScreen> {
  final controller = Get.put(DistributorEditListingController());

  File? selectedImage;
  File? brandLogo;
  File? ownerImage;
  final ImagePicker picker = ImagePicker();

  String categoryValue = "Food Industry";

  /// PICK IMAGE
  Future pickImage(ImageSource source, String type) async {
    final picked = await picker.pickImage(source: source);

    if (picked != null) {
      setState(() {
        if (type == "logo") {
          brandLogo = File(picked.path);
          controller.brandLogoFile = brandLogo;
        } else {
          ownerImage = File(picked.path);
          controller.ownerImageFile = ownerImage;
        }
      });
    }
  }

  /// CAMERA / GALLERY OPTION
  void showImageOption(String type) {
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
                  pickImage(ImageSource.camera, type); // ✅ PASS TYPE
                },
              ),

              ListTile(
                leading: const Icon(Icons.photo),
                title: const Text("Gallery"),
                onTap: () {
                  Navigator.pop(context);
                  pickImage(ImageSource.gallery, type); // ✅ PASS TYPE
                },
              ),
            ],
          ),
        );
      },
    );
  }
  @override
  void initState() {
    super.initState();
    controller.getDistributorDetails().then((_) {
      setState(() {
        categoryValue = controller.categoryController.text.isEmpty
            ? "Food Industry"
            : controller.categoryController.text;
      });
    });
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
          return const Center(child: CircularProgressIndicator());
        }
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [

              /// IMAGE SECTION
              Stack(
                children: [

                  CustomPaint(
                    painter: DottedBorderPainter(),
                    child: Container(
                      height: 160,
                      width: width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: brandLogo != null
                              ? FileImage(brandLogo!)
                              : controller.brandImageUrl.value.isNotEmpty
                              ? NetworkImage("${AppConfig.imageURL}${controller.brandImageUrl.value}")
                              : const AssetImage("assets/images/applogo.png") as ImageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),

                  Container(
                    height: 160,
                    width: width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black.withOpacity(0.4),
                    ),
                  ),

                  /// CHANGE IMAGE BUTTON
                  Positioned.fill(
                    child: Center(
                      child: GestureDetector(
                        onTap: () => showImageOption("logo"),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [

                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white
                              ),
                              child: Icon(Icons.camera_alt_outlined,
                                  color: Colors.black, size: 24),
                            ),

                            SizedBox(height: 10),

                            Text(
                              "Change Brand Logo",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
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
                      hint: "EcoClean Solution",
                      controller: controller.brandController,
                    ),

                    const SizedBox(height: 14),

                    _buildDropdown(),

                    const SizedBox(height: 14),

                    _buildField(
                        label: "Branch / Territory",
                        hint: "eg.Coimbatore",
                        controller: controller.territoryController
                    ),

                    const SizedBox(height: 15),

                    _buildUnitsDaysField(),

                    const SizedBox(height: 15),

                    _buildDescription(),
                  ],
                ),
              ),

              const SizedBox(height: 16),


              Stack(
                children: [

                  CustomPaint(
                    painter: DottedBorderPainter(),
                    child: Container(
                      height: 160,
                      width: width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: ownerImage != null
                              ? FileImage(ownerImage!)
                              : controller.ownerImageUrl.value.isNotEmpty
                              ? NetworkImage("${AppConfig.imageURL}${controller.ownerImageUrl.value}")
                              : const AssetImage("assets/images/applogo.png") as ImageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),

                  Container(
                    height: 160,
                    width: width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black.withOpacity(0.4),
                    ),
                  ),

                  /// CHANGE IMAGE BUTTON
                  Positioned.fill(
                    child: Center(
                      child: GestureDetector(
                        onTap: () => showImageOption("owner"),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [

                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white
                              ),
                              child: Icon(Icons.camera_alt_outlined,
                                  color: Colors.black, size: 24),
                            ),

                            SizedBox(height: 10),

                            Text(
                              "Change Brand Owner Image",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),

              SizedBox(
                height: 20,
              ),


              /// 🔹 CONTACT CARD
              _buildCard(
                children: [
                  _buildField(
                      label: "Owner / Company Name",
                      hint: "Enter legal entity name",
                      controller: controller.companyController
                  ),
                  const SizedBox(height: 12),
                  _buildField(
                      label: "Mobile Number",
                      hint: "+91 00000-00000",
                      controller: controller.mobileController
                  ),
                  const SizedBox(height: 12),
                  _buildField(
                      label: "Business Email",
                      hint: "example@gmail.com",
                      controller: controller.emailController
                  ),
                ],
              ),

              const SizedBox(height: 20),

              /// 🔹 SECTION TITLE


              /// 🔹 ADDRESS CARD
              _buildCard(
                children: [
                  const Text(
                    "Physical Headquarters",
                    style: TextStyle(color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),

                  const SizedBox(height: 15),
                  _buildField(
                      label: "Street Address",
                      hint: "e.g.123 north street",
                      controller: controller.addressController
                  ),
                  const SizedBox(height: 12),
                  _buildField(
                      label: "City",
                      hint: "e.g. Coimbatore",
                      controller: controller.cityController
                  ),
                  const SizedBox(height: 12),
                  _buildField(
                      label: "Postal Code",
                      hint: "e.g. 632221",
                      controller: controller.postalController

                  ),
                ],
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

                    controller.updateDistributor();
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

  Widget _buildCard({required List<Widget> children}) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xff2C2C2C),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(children: children),
    );
  }

  Widget _buildUnitsDaysField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        /// 🔹 LABEL (ONLY ONCE)
        const Text(
          "Branch / Territory",
          style: TextStyle(color: Colors.white70, fontSize: 14),
        ),

        const SizedBox(height: 6),

        /// 🔹 TWO FIELDS
        Row(
          children: [

            /// Units
            Expanded(
              child: TextField(
                controller: controller.unitsController,

                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "500 Units",
                  hintStyle: const TextStyle(color: Colors.grey,fontSize: 12),
                  filled: true,
                  fillColor: const Color(0xff2C2C2C),
                  contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 14),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: Colors.white24),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: Colors.white24),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: Colors.red, width: 1.5),
                  ),
                ),
              ),
            ),

            const SizedBox(width: 12),

            /// Days
            Expanded(
              child: TextField(
                controller: controller.daysController,

                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "14-21 Days",
                  hintStyle: const TextStyle(color: Colors.grey,fontSize: 12),
                  filled: true,
                  fillColor: const Color(0xff2C2C2C),
                  contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 14),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: Colors.white24),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: Colors.white24),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: Colors.red, width: 1.5),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// TEXT FIELD
  Widget _buildField({required String label, required String hint,TextEditingController? controller,}) {
    return Column(

      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text(
          label,
          style: const TextStyle(color: Colors.white70),
        ),

        const SizedBox(height: 6),

        TextField(
          controller: controller,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.white38),

            filled: true,
            fillColor: const Color(0xff3a3a3a),

            contentPadding: const EdgeInsets.symmetric(
                horizontal: 16, vertical: 14),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: Colors.white),  // WHITE BORDER
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: Colors.white),
            ),
          ),
        )
      ],
    );
  }

  /// DROPDOWN
  Widget _buildDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const Text(
          "Business Category",
          style: TextStyle(color: Colors.white70),
        ),

        const SizedBox(height: 6),

        Container(
          width: double.infinity, // WIDTH INCREASE
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: const Color(0xff3a3a3a),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.white),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              dropdownColor: const Color(0xff3a3a3a),
              value: categoryValue,
              isExpanded: true,

              items: const [
                DropdownMenuItem(
                    value: "Food Industry",
                    child: Text("Food Industry",
                        style: TextStyle(color: Colors.white))),

                DropdownMenuItem(
                    value: "Retail",
                    child: Text("Retail",
                        style: TextStyle(color: Colors.white))),

                DropdownMenuItem(
                    value: "Education",
                    child: Text("Education",
                        style: TextStyle(color: Colors.white))),

                DropdownMenuItem(
                    value: "Healthcare",
                    child: Text("Healthcare",
                        style: TextStyle(color: Colors.white))),

                DropdownMenuItem(
                    value: "Technology",
                    child: Text("Technology",
                        style: TextStyle(color: Colors.white))),
              ],

              onChanged: (value) {
                setState(() {
                  categoryValue = value!;
                  controller.categoryController.text = value;
                });
              },
            ),
          ),
        )
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
          controller: controller.descriptionController,
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

class DottedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashWidth = 6, dashSpace = 4, strokeWidth = 1;

    final paint = Paint()
      ..color = Colors.white38
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width, size.height),
          const Radius.circular(14),
        ),
      );

    final metrics = path.computeMetrics();

    for (var metric in metrics) {
      double distance = 0;
      while (distance < metric.length) {
        final nextDistance = distance + dashWidth;
        canvas.drawPath(
          metric.extractPath(distance, nextDistance),
          paint,
        );
        distance = nextDistance + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}