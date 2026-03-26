import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Constants/Colors.dart';
import '../../../Controllers/CustomerModuleController/AuthController.dart';
import '../../../Controllers/DistributorModuleController/AuthControllers.dart';
import 'ForgotOTPScreen.dart';

class CustomerForgotPassword extends StatelessWidget {
 CustomerForgotPassword({super.key});

  final CustomerForgotPasswordController controller =
  Get.put(CustomerForgotPasswordController());

 final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: apptheme,
      appBar: AppBar(
        backgroundColor: apptheme,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form( // ✅ முக்கியம்
              key: _formKey,
              child: Column(
                children: [
                  Image.asset('assets/images/applogo.png', height: 80),

                  SizedBox(height: 15),

                  Text(
                    'Forgot Password',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 8),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      'Enter your registered email to receive OTP for password reset.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[400],
                      ),
                    ),
                  ),

                  SizedBox(height: 30),

                  /// 🔹 Email Field with Validation
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextFormField(
                      controller: controller.emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(color: Colors.white),

                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter email";
                        }

                        // ✅ Email regex validation
                        if (!GetUtils.isEmail(value)) {
                          return "Please enter valid email";
                        }

                        return null;
                      },

                      decoration: InputDecoration(
                        hintText: 'Enter your Email',
                        hintStyle: TextStyle(color: Colors.grey),
                        prefixIcon: Icon(Icons.email, color: Colors.grey),

                        errorStyle: TextStyle(color: Colors.red), // 👈 கீழே error color

                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(color: Colors.grey),
                        ),

                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(color: buttontheme),
                        ),

                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(color: Colors.red),
                        ),

                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 30),

                  /// 🔹 Button
                  InkWell(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        controller.CustomerforgotPassword();
                      }
                    },
                    child: Container(
                      width: 280,
                      padding: EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: buttontheme,
                      ),
                      child: Center(
                        child: Text(
                          'Send OTP',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
