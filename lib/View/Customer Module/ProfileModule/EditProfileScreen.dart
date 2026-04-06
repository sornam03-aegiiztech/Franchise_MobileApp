import 'dart:io';

import 'package:flutter/material.dart';
import 'package:franchaise_app/Constants/Colors.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../Appconfig.dart';
import '../../../Controllers/CustomerModuleController/ProfileController.dart';
import '../../../main.dart';

class CustomerProfileEditScreen extends StatefulWidget {
  const CustomerProfileEditScreen({super.key});

  @override
  State<CustomerProfileEditScreen> createState() => _CustomerProfileEditScreenState();
}

class _CustomerProfileEditScreenState extends State<CustomerProfileEditScreen> {
  final controller = Get.put(CustomerProfileController());


  File? selectedImage;
  final ImagePicker picker = ImagePicker();

  /// PICK IMAGE
  Future<void> pickImage(ImageSource source) async {

    final XFile? image = await picker.pickImage(source: source);

    if(image != null){
      setState(() {
        selectedImage = File(image.path);
      });
    }
  }

  /// CAMERA OR GALLERY DIALOG
  void openImagePicker(){

    showModalBottomSheet(
        context: context,
        backgroundColor: const Color(0xff2A2A2A),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),

        builder: (context){
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                const Text(
                  "Select Image",
                  style: TextStyle(color: Colors.white,fontSize:16),
                ),

                const SizedBox(height:20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [

                    /// CAMERA
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                        pickImage(ImageSource.camera);
                      },
                      child: Column(
                        children: const [
                          Icon(Icons.camera_alt,color: Colors.white,size:30),
                          SizedBox(height:6),
                          Text("Camera",style: TextStyle(color: Colors.white))
                        ],
                      ),
                    ),

                    /// GALLERY
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                        pickImage(ImageSource.gallery);
                      },
                      child: Column(
                        children: const [
                          Icon(Icons.photo,color: Colors.white,size:30),
                          SizedBox(height:6),
                          Text("Gallery",style: TextStyle(color: Colors.white))
                        ],
                      ),
                    ),

                  ],
                ),

                const SizedBox(height:20)
              ],
            ),
          );
        }
    );
  }
  @override
  void initState() {
    super.initState();
    controller.getProfile();
  }
  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xff1E1E1E),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                FoldingCubeWidget(size: 60),
                SizedBox(height: 15),
                Text(
                  "Loading...",
                  style: TextStyle(color: Colors.white70),
                )
              ],
            ),
          );
        }
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.06),
            child: SingleChildScrollView(
              child: Column(
                children: [

                  SizedBox(height: height * 0.02),

                  /// BACK BUTTON
                  Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: const Color(0xff2E2E2E),
                            shape: BoxShape.circle
                        ),
                        child: InkWell(child: Padding(
                          padding: const EdgeInsets.only(left: 7.0),
                          child: const Icon(
                            Icons.arrow_back_ios, color: Colors.white,
                            size: 14,),
                        )),
                      ),
                    ),
                  ),

                  SizedBox(height: height * 0.03),

                  /// PROFILE IMAGE
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [

                      CircleAvatar(
                        radius: 50,
                        backgroundImage: selectedImage != null
                            ? FileImage(selectedImage!)
                            : (controller.profileImage.value.isNotEmpty
                            ? NetworkImage(
                            "${AppConfig.imageURL}${controller.profileImage.value}"
                        )
                            : const AssetImage("assets/images/profile.png")) as ImageProvider,
                      ),

                      GestureDetector(
                        onTap: openImagePicker,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(Icons.camera_alt, size: 16),
                        ),
                      )
                    ],
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "Change profile",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16
                    ),
                  ),

                  SizedBox(height: height * 0.04),

                  /// NAME
                  _label("Full Name"),
                  _textfield(
                      Icons.person, "Enter full name", controller.nameCtrl),

                  SizedBox(height: height * 0.02),

                  /// PHONE
                  _label("Mobile Number"),
                  _textfield(
                      Icons.phone, "Enter mobile number", controller.phoneCtrl),

                  SizedBox(height: height * 0.02),

                  /// EMAIL
                  _label("Business Email"),
                  _textfield(Icons.email, "Enter email", controller.emailCtrl),


                  SizedBox(
                    height: 120,
                  ),


                  /// SAVE BUTTON
                  GestureDetector(
                    onTap: () {
                      controller.updateProfile(selectedImage);
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: buttontheme,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Center(
                        child: Text(
                          "Save Change",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: height * 0.03)
                ],
              ),
            ),
          ),
        );
      }
      ),
    );
  }

  /// LABEL
  Widget _label(String text){
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom:8),
        child: Text(
          text,
          style: const TextStyle(
              color: Colors.white70
          ),
        ),
      ),
    );
  }

  /// TEXTFIELD
  Widget _textfield(IconData icon,String hint,TextEditingController controller){
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        prefixIcon: Icon(icon,color: Colors.white70),
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white54),
        filled: true,
        fillColor: const Color(0xff2A2A2A),
        contentPadding: const EdgeInsets.symmetric(vertical:16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}