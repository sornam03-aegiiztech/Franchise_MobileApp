import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
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
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xff1E1E1E),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.06),
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

                  CircleAvatar(
                    radius: 50,
                backgroundImage: selectedImage != null
                    ?   FileImage(selectedImage!)
                    : const AssetImage("assets/images/profile.png") as ImageProvider,
              ),


                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(Icons.camera_alt,size: 16),
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
              _label("Owner/Company Name"),
              _textfield(Icons.person,"Guhan"),

              SizedBox(height: height * 0.02),

              /// PHONE
              _label("Mobile Number"),
              _textfield(Icons.phone,"+91 9876543210"),

              SizedBox(height: height * 0.02),

              /// EMAIL
              _label("Business Email"),
              _textfield(Icons.email,"guhan00@gmail.com"),

              const Spacer(),

              /// SAVE BUTTON
              Container(
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
                        fontWeight: FontWeight.w600
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
  Widget _textfield(IconData icon,String hint){
    return TextField(
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