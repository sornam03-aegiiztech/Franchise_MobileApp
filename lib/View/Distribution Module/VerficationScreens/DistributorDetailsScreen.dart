import 'dart:io';
import 'dart:ui' as BorderType;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../Controllers/CustomerModuleController/DashboardController.dart';
import '../../../Controllers/DistributorModuleController/DistributorDetailsController.dart';
import '../Subscriptions/PremiumScreen.dart';
import 'Notifications.dart';


class DistributionDetailsScreen extends StatefulWidget {
  const DistributionDetailsScreen({super.key});

  @override
  State<DistributionDetailsScreen> createState() =>
      _DistributionDetailsScreenState();
}

class _DistributionDetailsScreenState extends State<DistributionDetailsScreen> {
  final DistributorDetailsController distributorDetailsController=Get.put(DistributorDetailsController());
  final servicesController = Get.put(ServicesController());
  final allcontroller = Get.put(AllDistributorController());
  File? brandLogo;
  File? ownerImage;
  File? frontDoc;
  File? backDoc;
  File? document;

  final ImagePicker picker = ImagePicker();

  Future<void> pickImage(ImageSource source, Function(File) onSelected) async {
    final XFile? image = await picker.pickImage(source: source);

    if (image != null) {
      onSelected(File(image.path));
    }
  }

  void showImagePickerOptions(Function(File) onSelected) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text("Camera"),
              onTap: () {
                Navigator.pop(context);
                pickImage(ImageSource.camera, onSelected);
              },
            ),
            ListTile(
              leading: Icon(Icons.photo),
              title: Text("Gallery"),
              onTap: () {
                Navigator.pop(context);
                pickImage(ImageSource.gallery, onSelected);
              },
            ),
          ],
        );
      },
    );
  }

  int currentStep = 1; // Change 1,2,3 for different screens


  bool validateStep1() {
    if (brandLogo == null) {
      EasyLoading.showToast("Upload Brand Logo");
      return false;
    }

    if (distributorDetailsController.brandNameCtrl.text.isEmpty) {
      EasyLoading.showToast("Enter Brand Name");
      return false;
    }

    if (distributorDetailsController.selectedCategory.value.isEmpty) {
      EasyLoading.showToast("Select Category");
      return false;
    }

    if (distributorDetailsController.territoryCtrl.text.isEmpty) {
      EasyLoading.showToast("Enter Territory");
      return false;
    }

    if (distributorDetailsController.unitsCtrl.text.isEmpty) {
      EasyLoading.showToast("Enter Units");
      return false;
    }

    if (distributorDetailsController.daysCtrl.text.isEmpty) {
      EasyLoading.showToast("Enter Days");
      return false;
    }

    if (distributorDetailsController.descCtrl.text.isEmpty) {
      EasyLoading.showToast("Enter Business Description");
      return false;
    }
    if (distributorDetailsController.selectedProducts.isEmpty) {
      EasyLoading.showToast("Select Products");
      return false;
    }

    return true;
  }

  bool validateStep2() {
    if (ownerImage == null) {
      EasyLoading.showToast("Upload Owner Image");
      return false;
    }

    if (distributorDetailsController.companyCtrl.text.isEmpty) {
      EasyLoading.showToast("Enter Company Name");
      return false;
    }

    if (distributorDetailsController.mobileCtrl.text.isEmpty) {
      EasyLoading.showToast("Enter Mobile Number");
      return false;
    }

    if (distributorDetailsController.mobileCtrl.text.length != 10) {
      EasyLoading.showToast("Enter valid Mobile Number");
      return false;
    }

    if (!GetUtils.isEmail(distributorDetailsController.emailCtrl.text)) {
      EasyLoading.showToast("Enter valid Email");
      return false;
    }

    if (distributorDetailsController.addressCtrl.text.isEmpty) {
      EasyLoading.showToast("Enter Address");
      return false;
    }

    if (distributorDetailsController.cityCtrl.text.isEmpty) {
      EasyLoading.showToast("Enter City");
      return false;
    }

    if (distributorDetailsController.postalCtrl.text.length !=6) {
      EasyLoading.showToast("Enter Valid Postal Code");
      return false;
    }

    if (distributorDetailsController.selectedProducts.isEmpty) {
      EasyLoading.showToast("Select at least one product");
      return false;
    }

    return true;
  }

  bool validateStep3() {
    if (distributorDetailsController.idNumberCtrl.text.isEmpty) {
      EasyLoading.showToast("Enter ID Number");
      return false;
    }

    if (frontDoc == null) {
      EasyLoading.showToast("Upload Front Document");
      return false;
    }

    if (backDoc == null) {
      EasyLoading.showToast("Upload Back Document");
      return false;
    }

    if (distributorDetailsController.gstCtrl.text.isEmpty) {
      EasyLoading.showToast("Enter GST Number");
      return false;
    }

    if (document == null) {
      EasyLoading.showToast("Upload Document");
      return false;
    }

    return true;
  }


  @override
  void dispose() {
    distributorDetailsController.dispose();
    super.dispose();
  }

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
                    onTap: () {
                      if (currentStep > 1) {
                        setState(() {
                          currentStep--; // 🔥 step back
                        });
                      } else {
                        Get.back(); // 🔥 exit screen
                      }
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
          "Please provide your official business details \nto proceed with the Distributor listing.",
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
            letterSpacing: 1,
          ),
        ),

        const SizedBox(height: 20),

        const Text("General Details",
            style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500)),

        const SizedBox(height: 15),

        _buildUploadBox("Upload Brand Logo", brandLogo, (file) {
          setState(() => brandLogo = file);
        }),

        const SizedBox(height: 15),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xff2C2C2C),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [

              _buildTextField("Brand Name", "e.g. Tea boy",controller:distributorDetailsController.brandNameCtrl ),

              const SizedBox(height: 15),

              _buildDropdown(),

              const SizedBox(height: 15),

              _buildTextField("Branch / Territory", "e.g. Coimbatore",controller: distributorDetailsController.territoryCtrl),

              const SizedBox(height: 15),

              _buildUnitsDaysField(),

              const SizedBox(height: 15),


              _buildTextField("Business Description", "Describe the Business of your customers", maxLines: 4,controller: distributorDetailsController.descCtrl),

              const SizedBox(height: 15),

              _buildProductHandled(),

            ],
          ),
        ),
        const SizedBox(height: 15),

        Center(
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: 'By clicking continue, you agree to our ',
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xff999999),
              ),
              children: [
                TextSpan(
                  text: 'Terms & Conditions',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(text: ' and '),
                TextSpan(
                  text: 'Privacy Policy.',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: ' We may send you automated communication for registration updates.'
                )
              ],
            ),
          ),
        ),

        SizedBox(
          height: 20,
        ),


        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: _buildButton("Next Step", () {
            if (validateStep1()) {
              setState(() {
                currentStep = 2;
              });
            }
          }),
        )
      ],
    );
  }

  /// ---------------- STEP 2 ----------------

  Widget _stepTwo() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// 🔹 TITLE
          const Text(
            "Contact Details",
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 6),

          const Text(
            "Formal channels only personal messaging apps are restricted to ensure professional compliance",
            style: TextStyle(color: Colors.white54, fontSize: 12),
          ),

          const SizedBox(height: 20),

          /// 🔹 UPLOAD BOX

          _buildUploadBox("Upload Brand Owner Image", ownerImage, (file) {
            setState(() => ownerImage = file);
          }),
          const SizedBox(height: 20),

          /// 🔹 CONTACT CARD
          _buildCard(
            children: [
              _buildTextField("Owner / Company Name", "Enter legal entity name",controller: distributorDetailsController.companyCtrl),
              const SizedBox(height: 12),
              _buildTextField("Mobile Number", "+91 00000-00000",controller: distributorDetailsController.mobileCtrl,keyboardType: TextInputType.phone,inputFormatters: [
                LengthLimitingTextInputFormatter(10),
                FilteringTextInputFormatter.digitsOnly,
              ]),
              const SizedBox(height: 12),
              _buildTextField("Business Email", "example@gmail.com",controller: distributorDetailsController.emailCtrl),
            ],
          ),

          const SizedBox(height: 20),

          /// 🔹 SECTION TITLE


          /// 🔹 ADDRESS CARD
          _buildCard(
            children: [
              const Text(
                "Physical Headquarters",
                style: TextStyle(color: Colors.white, fontSize: 16,fontWeight: FontWeight.w500),
              ),

              const SizedBox(height: 15),
              _buildTextField("Street Address", "e.g.123 north street",controller: distributorDetailsController.addressCtrl),
              const SizedBox(height: 12),
              _buildTextField("City", "e.g. Coimbatore",controller: distributorDetailsController.cityCtrl),
              const SizedBox(height: 12),
              _buildTextField("Postal Code", "e.g. 632221",controller: distributorDetailsController.postalCtrl,keyboardType: TextInputType.number,inputFormatters: [
                LengthLimitingTextInputFormatter(6),
                FilteringTextInputFormatter.digitsOnly,
              ]),
            ],
          ),

          const SizedBox(height: 25),

          /// 🔹 BUTTON
          _buildButton("Next Step", () {
            if (validateStep2()) {
              setState(() {
                currentStep = 3;
              });
            }
          }),
        ],
      ),
    );
  }

  /// ---------------- STEP 3 ----------------

  Widget _stepThree() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// 🔹 TITLE
          const Text(
            "Verification Details",
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 6),

          const Text(
            "Your business information and upload the required legal documents to complete your listing.",
            style: TextStyle(color: Colors.white54, fontSize: 12),
          ),

          const SizedBox(height: 20),

          /// 🔹 MAIN CARD
          _buildCard(
            children: [

              /// Owner ID Proof
              const Text("Owner ID Proof",
                  style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 16)),

              const SizedBox(height: 12),

              _buildDropdownField("ID Document Type", "Aadhaar Card"),

              const SizedBox(height: 12),

              _buildTextField("Document ID Number", "Enter ID Number",controller: distributorDetailsController.idNumberCtrl),

              const SizedBox(height: 12),

              /// 🔹 FRONT + BACK
              Row(
                children: [
                  Expanded(child: _buildSmallUploadBox("Front Side", frontDoc, (file) {
                    setState(() => frontDoc = file);
                  }),),
                  const SizedBox(width: 12),
                  Expanded(child: _buildSmallUploadBox("Back Side", backDoc, (file) {
                    setState(() => backDoc = file);
                  }),),
                ],
              ),

              const SizedBox(height: 12),

              _buildTextField(
                  "GSTIN/REGISTRATION NUMBER", "0000000000",controller: distributorDetailsController.gstCtrl),
            ],
          ),

          const SizedBox(height: 20),

          /// 🔹 BIG UPLOAD
          _buildUploadBox("Upload Documents", document, (file) {
            setState(() => document = file);
          }),

          const SizedBox(height: 25),

          /// 🔹 BUTTON
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: _buildButton("Save & Publish", () {
              if (validateStep3()) {
                distributorDetailsController.addDistributor(
                  brandLogo: brandLogo,
                  ownerImage: ownerImage,
                  frontDoc: frontDoc,
                  backDoc: backDoc,
                  document: document,

                  brandName: distributorDetailsController.brandNameCtrl.text,
                  category: distributorDetailsController.selectedCategory.value,
                  territory: distributorDetailsController.territoryCtrl.text,
                  units: distributorDetailsController.unitsCtrl.text,
                  days: distributorDetailsController.daysCtrl.text,
                  description: distributorDetailsController.descCtrl.text,

                  companyName: distributorDetailsController.companyCtrl.text,
                  mobile: distributorDetailsController.mobileCtrl.text,
                  email: distributorDetailsController.emailCtrl.text,
                  city: distributorDetailsController.cityCtrl.text,
                  address: distributorDetailsController.addressCtrl.text,
                  postalCode: distributorDetailsController.postalCtrl.text,

                  idType: "Aadhaar Card",
                  idNumber: distributorDetailsController.idNumberCtrl.text,
                  gst: distributorDetailsController.gstCtrl.text,
                );
              }
            }),
          ),
        ],
      ),
    );
  }



  Widget _buildProductHandled() {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Product Handled",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),

          ...distributorDetailsController.productList.map((product) {
            return CheckboxListTile(
              value: distributorDetailsController.selectedProducts.contains(product),
              onChanged: (value) {
                if (value == true) {
                  distributorDetailsController.selectedProducts.add(product);
                } else {
                  distributorDetailsController.selectedProducts.remove(product);
                }
              },
              title: Text(
                product,
                style: const TextStyle(color: Colors.white),
              ),
              activeColor: Colors.red,
              checkColor: Colors.white,
              controlAffinity: ListTileControlAffinity.leading,
            );
          }).toList(),
        ],
      );
    });
  }

  Widget _buildDropdownField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text(label,
            style: const TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w500)),

        const SizedBox(height: 6),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: const Color(0xff3A3A3A),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.white24),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              dropdownColor: const Color(0xff2C2C2C),
              isExpanded: true,
              style: const TextStyle(color: Colors.white),
              items: ["Aadhaar Card", "PAN Card"]
                  .map((e) => DropdownMenuItem(
                value: e,
                child: Text(e),
              ))
                  .toList(),
              onChanged: (val) {},
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSmallUploadBox(
      String title,
      File? image,
      Function(File) onPick,
      ) {
    return GestureDetector(
      onTap: () => showImagePickerOptions(onPick),
      child: CustomPaint(
        painter: DottedBorderPainter(),
        child: Container(
          height: 110,
          decoration: BoxDecoration(
            color: const Color(0xff3A3A3A),
            borderRadius: BorderRadius.circular(14),
          ),
          child: image == null
              ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.camera_alt_outlined,
                  color: Colors.white54),
              const SizedBox(height: 6),
              Text(
                title,
                style: const TextStyle(color: Colors.white70),
              ),
            ],
          )
              : ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.file(
              image,
              height: 110,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ),
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
                controller: distributorDetailsController.unitsCtrl,
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
                controller: distributorDetailsController.daysCtrl,
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




  Widget _buildDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        /// 🔹 LABEL
        const Text(
          "Business Category",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),

        const SizedBox(height: 6),

        /// 🔹 DROPDOWN
        Obx(() {
          if (servicesController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: const Color(0xff3A3A3A),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.white24),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: distributorDetailsController.selectedCategory.value.isEmpty
                    ? null
                    : distributorDetailsController.selectedCategory.value,
                hint: const Text(
                  "Select Category",
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                dropdownColor: const Color(0xff2C2C2C),
                icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
                isExpanded: true,
                style: const TextStyle(color: Colors.white),

                /// 🔥 API LIST
                items: servicesController.tabs.map((String value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),

                /// 🔥 ON CHANGE
                onChanged: (value) {
                  distributorDetailsController.selectedCategory.value = value!;
                },
              ),
            ),
          );
        }),
      ],
    );
  }

  /// COMMON TEXTFIELD

  Widget _buildTextField(String label, String hint, {int maxLines = 1,TextEditingController? controller,TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        /// 🔹 LABEL
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500
          ),
        ),

        const SizedBox(height: 6),

        /// 🔹 FIELD
        TextField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType ?? TextInputType.text,
          inputFormatters: inputFormatters,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.grey,fontSize: 12),
            filled: true,
            fillColor: const Color(0xff3A3A3A), // 🔥 slight diff for card contrast

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
      ],
    );
  }

  /// UPLOAD BOX

  Widget _buildUploadBox(String text, File? image, Function(File) onPick) {
    return GestureDetector(
      onTap: () => showImagePickerOptions(onPick),
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
            child: image == null   // ✅ FIXED
                ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                    color: Color(0xff3F3F3F),
                    shape: BoxShape.circle,
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
                image, // ✅ FIXED
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