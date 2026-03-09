import 'package:flutter/material.dart';

import 'dart:io';

import 'package:image_picker/image_picker.dart';

class EditListingScreen extends StatefulWidget {
  const EditListingScreen({super.key});

  @override
  State<EditListingScreen> createState() => _EditListingScreenState();
}

class _EditListingScreenState extends State<EditListingScreen> {

  File? selectedImage;
  final ImagePicker picker = ImagePicker();

  String categoryValue = "Food Industry";

  /// PICK IMAGE
  Future pickImage(ImageSource source) async {
    final picked = await picker.pickImage(source: source);

    if (picked != null) {
      setState(() {
        selectedImage = File(picked.path);
      });
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

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            /// IMAGE SECTION
            Stack(
              children: [

                Container(
                  height: 160,
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: selectedImage != null
                          ? FileImage(selectedImage!)
                          : const AssetImage("assets/images/applogo.png")
                      as ImageProvider,
                      fit: BoxFit.cover,
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
                      onTap: showImageOption,
                      child:  Column(
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
                            "Change Image",
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
                      hint: "EcoClean Solution"
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
                      hint: "₹100k - ₹200k"
                  ),

                  const SizedBox(height: 14),

                  _buildField(
                      label: "Franchise Fee",
                      hint: "₹50,000"
                  ),

                  const SizedBox(height: 14),

                  _buildField(
                      label: "Liquid Capital Required",
                      hint: "₹50,000"
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
                onPressed: () {},
                child: const Text(
                  "Update Listing",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  /// TEXT FIELD
  Widget _buildField({required String label, required String hint}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text(
          label,
          style: const TextStyle(color: Colors.white70),
        ),

        const SizedBox(height: 6),

        TextField(
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
              ],

              onChanged: (value) {
                setState(() {
                  categoryValue = value!;
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