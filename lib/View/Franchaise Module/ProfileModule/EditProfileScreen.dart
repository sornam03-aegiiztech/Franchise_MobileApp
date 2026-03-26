import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../Controllers/FranchiseModuleAuthControllers/ProfileController.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final controller = Get.put(FranchiseProfileController());
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
      body: SafeArea(
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
                    onTap: (){
                      Get.back();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xff2E2E2E),
                       shape: BoxShape.circle
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 7.0),
                        child: const Icon(Icons.arrow_back_ios,color: Colors.white,size: 15,),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: height * 0.03),

                /// PROFILE IMAGE
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [

                    Obx(() => CircleAvatar(
                      radius: 50,
                      backgroundImage: selectedImage != null
                          ? FileImage(selectedImage!)
                          : controller.profileImage.value.isNotEmpty
                          ? NetworkImage(controller.profileImage.value)
                          : const AssetImage("assets/images/profile.png") as ImageProvider,
                    )),

                    GestureDetector(
                      onTap: () {
                        openImagePicker(); // 🔥 THIS IS IMPORTANT
                      },
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
                _label("Owner Name"),
                _textfield(Icons.person,"Enter Owner name",controller.OwnerTextController),

                SizedBox(height: height * 0.02),

                /// NAME
                _label("Business Name"),
                _textfield(Icons.business,"Enter Business name",controller.nameTextController),

                SizedBox(height: height * 0.02),

                /// PHONE
                _label("Mobile Number"),
                _textfield(Icons.phone,"Enter Mobile number",controller.mobileTextController,keyboardType: TextInputType.phone,inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],),

                SizedBox(height: height * 0.02),

                /// EMAIL
                _label("Business Email"),
                _textfield(Icons.email,"Enter email",controller.emailTextController),

               SizedBox(
                 height: 120,
               ),

                /// SAVE BUTTON
                GestureDetector(
                  onTap: () {
                    controller.updateProfile();
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xffF23E46),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Center(
                      child: Text(
                        "Save Change",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: height * 0.03)
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget _label(String text){
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom:8),
        child: Text(
          text,
          style: const TextStyle(
              color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500
          ),
        ),
      ),
    );
  }

 

  Widget _textfield(
      IconData icon,
      String hint,
      TextEditingController controller, {
        TextInputType keyboardType = TextInputType.text,
        List<TextInputFormatter>? inputFormatters,
      }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType, 
      inputFormatters: inputFormatters, 
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.white70),
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 12),
        filled: true,
        fillColor: const Color(0xff2A2A2A),
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
 
}