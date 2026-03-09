import 'dart:io';
import 'dart:ui' as BorderType;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../Subscriptions/PremiumScreen.dart';
import 'Notifications.dart';


class FranchiseDetailsScreen extends StatefulWidget {
  const FranchiseDetailsScreen({super.key});

  @override
  State<FranchiseDetailsScreen> createState() =>
      _FranchiseDetailsScreenState();
}

class _FranchiseDetailsScreenState extends State<FranchiseDetailsScreen> {

  File? selectedImage;

  final ImagePicker picker = ImagePicker();

  Future<void> pickImage(ImageSource source) async {
    final XFile? image = await picker.pickImage(source: source);

    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    }
  }

  void showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
      },
    );
  }

  int currentStep = 1; // Change 1,2,3 for different screens
  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1E1E1E),
      body: SafeArea(
        child: Column(
          children: [

            /// AppBar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  InkWell(
                    onTap: (){
                      Get.back();
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Colors.black45,
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 7.0),
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 60),
                  const Text(
                    "Distributor Details",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),

                  ),

                ],
              ),
            ),

            /// Step Indicator
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildStep(1),
                  _buildLine(),
                  _buildStep(2),
                  _buildLine(),
                  _buildStep(3),
                ],
              ),
            ),
            const SizedBox(height: 10),

            /// TEXT
            Text(
              "STEPS $currentStep OF 3",
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 12,
                letterSpacing: 1,
              ),
            ),

            const SizedBox(height: 20),



            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: currentStep == 1
                    ? _stepOne()
                    : currentStep == 2
                    ? _stepTwo()
                    : _stepThree(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// STEP CIRCLE
  Widget _buildStep(int step) {
    bool isActive = step <= currentStep;

    return Container(
      width: isActive ? 14 : 8,
      height: isActive ? 14 : 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: isActive
            ? Border.all(color: Colors.red, width: 2)
            : null,
        color: isActive ? Colors.transparent : Colors.grey,
      ),
      child: isActive
          ? Center(
        child: Container(
          width: 6,
          height: 6,
          decoration: const BoxDecoration(
            color: Colors.red,
            shape: BoxShape.circle,
          ),
        ),
      )
          : null,
    );
  }

  /// LINE
  Widget _buildLine() {
    return Expanded(
      child: Container(
        height: 1,
        color: Colors.grey.shade600,
      ),
    );
  }

  /// ---------------- STEP 1 ----------------

  Widget _stepOne() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text(
          "Tell us about your business",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,

            fontWeight: FontWeight.w500
          ),
        ),

        const SizedBox(height: 10),

        Text(
          "Please provide your official business details \nto proceed with the franchise listing.",
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
            letterSpacing: 1,
          ),
        ),

        const SizedBox(height: 20),

        const Text("General Details",
            style: TextStyle(color: Colors.white70)),

        const SizedBox(height: 15),

        _buildUploadBox("Upload Inner Image"),

        const SizedBox(height: 15),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xff2C2C2C),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [

              /// Brand Name
              _buildTextField("Brand Name"),

              const SizedBox(height: 15),

              /// Business Category Dropdown
              _buildDropdown(),

              const SizedBox(height: 15),

              _buildTextField("Branch / Territory"),

              const SizedBox(height: 15),


              /// Business Description
              _buildTextField("Business Description", maxLines: 3),

            ],
          ),
        ),
        const SizedBox(height: 15),
        _buildUploadBox("Upload Brand Cover Image"),
        const SizedBox(height: 15),
        _buildTextField("Owner / Company Name"),
        const SizedBox(height: 15),
        _buildTextField("Mobile Number"),
        const SizedBox(height: 15),
        _buildTextField("Business Email"),

        const SizedBox(height: 30),

        _buildButton("Next Step", () {
          setState(() {
            currentStep = 2;
          });
        })
      ],
    );
  }

  /// ---------------- STEP 2 ----------------

  Widget _stepTwo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const Text("Franchises",
            style: TextStyle(color: Colors.white70)),

        const SizedBox(height: 15),

        _buildTextField("Total Investment"),
        const SizedBox(height: 15),
        _buildTextField("Franchise Fee"),
        const SizedBox(height: 15),
        _buildTextField("Liquid Capital Required"),

        const SizedBox(height: 30),

        _buildButton("Next Step", () {
          setState(() {
            currentStep = 3;
          });
        })
      ],
    );
  }

  /// ---------------- STEP 3 ----------------

  Widget _stepThree() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const Text("Verification Details",
            style: TextStyle(color: Colors.white70)),

        const SizedBox(height: 15),

        _buildUploadBox("Upload Business Documents"),
        const SizedBox(height: 15),
        _buildUploadBox("Upload Photo ID"),

        const SizedBox(height: 30),

        _buildButton("Save & Publish", () {
          setState(() {
            Get.to(ActivateFranchiseScreen());
          });
        })
      ],
    );
  }




  Widget _buildDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xff3A3A3A),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.white12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedCategory,
          hint: const Text(
            "Select Category",
            style: TextStyle(color: Colors.white54),
          ),
          dropdownColor: const Color(0xff2C2C2C),
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
          isExpanded: true,
          items: [
            "Food",
            "Retail",
            "Education",
            "Healthcare",
            "Technology"
          ].map((String value) {
            return DropdownMenuItem(
              value: value,
              child: Text(
                value,
                style: const TextStyle(color: Colors.white),
              ),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              selectedCategory = value;
            });
          },
        ),
      ),
    );
  }

  /// COMMON TEXTFIELD

  Widget _buildTextField(String hint, {int maxLines = 1}) {
    return TextField(
      maxLines: maxLines,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white54),
        filled: true,
        fillColor: const Color(0xff2C2C2C),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(
            color: Colors.white24,
            width: 1,
          ),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: Colors.white24,
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.5,
          ),
        ),
      ),
    );
  }

  /// UPLOAD BOX

  Widget _buildUploadBox(String text) {
    return GestureDetector(
      onTap: showImagePickerOptions,
      child: CustomPaint(
        painter: DottedBorderPainter(),
        child: Container(
          height: 150,
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xff2C2C2C),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Center(
            child: selectedImage == null
                ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xff3F3F3F),
                    shape: BoxShape.circle
                  ),
                  child: const Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  text,
                  style: const TextStyle(color: Colors.white54),
                ),
              ],
            )
                : ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.file(
                selectedImage!,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
  /// BUTTON

  Widget _buildButton(String text, VoidCallback onTap) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.red, Colors.redAccent],
        ),
        borderRadius: BorderRadius.circular(14),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        onPressed: onTap,
        child: Text(text,style: TextStyle(color: Colors.white),),
      ),
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