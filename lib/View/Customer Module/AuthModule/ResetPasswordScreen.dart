import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:franchaise_app/Constants/utlity.dart';
import 'package:franchaise_app/View/Distribution%20Module/AuthModule/LoginScreen.dart';
import 'package:get/get.dart';

import '../../../Constants/Colors.dart';
import '../../../Controllers/CustomerModuleController/AuthController.dart';
import '../../../Controllers/DistributorModuleController/AuthControllers.dart';

class CustomerResetScreen extends StatelessWidget {
  CustomerResetScreen({super.key});

  final CustomerResetPasswordController controller =
  Get.put(CustomerResetPasswordController());

  final String email = Get.arguments['email'] ?? "";
  final String otp = Get.arguments['otp'] ?? "";

  @override
  Widget build(BuildContext context) {
    return Utility.checkInternetManagerWidget(
       Scaffold(
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
            child: Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [

                    Image(
                      image: AssetImage('assets/images/applogo.png'),
                      height: 75,
                      width: 75,
                    ),

                    SizedBox(height: 10),

                    Text(
                      'Reset Password',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 8),


                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Text(
                        "Create a strong password to keep your account secure.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white70,
                        ),
                      ),
                    ),

                    SizedBox(height: 25),


                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1, color: Color(0xff999999)),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Obx(() => TextFormField(
                              onChanged: (value) {
                                controller.validatePasswords();
                              },
                              controller: controller.passwordController,
                              obscureText:
                              controller.isPasswordHidden.value,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                hintText: 'Enter Password',
                                hintStyle: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xff999999),
                                ),
                                contentPadding:
                                EdgeInsets.symmetric(vertical: 10),
                                border: InputBorder.none,
                                prefixIcon: Icon(Icons.lock,
                                    size: 16,
                                    color: Color(0xff989898)),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    controller.isPasswordHidden.value
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    size: 16,
                                    color: Color(0xff989898),
                                  ),
                                  onPressed: () {
                                    controller.isPasswordHidden.toggle();
                                  },
                                ),
                              ),
                            )),
                          ),


                          Obx(() => controller.passwordError.value.isNotEmpty
                              ? Padding(
                            padding:
                            const EdgeInsets.only(left: 10, top: 5),
                            child: Text(
                              controller.passwordError.value,
                              style: TextStyle(
                                  color: Colors.red, fontSize: 11),
                            ),
                          )
                              : SizedBox())
                        ],
                      ),
                    ),

                    SizedBox(height: 20),


                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1, color: Color(0xff999999)),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Obx(() => TextFormField(
                              onChanged: (value) {
                                controller.validatePasswords();
                              },
                              controller:
                              controller.confirmPasswordController,
                              obscureText: controller
                                  .isConfirmPasswordHidden.value,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                hintText: 'Enter Confirm Password',
                                hintStyle: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xff999999),
                                ),
                                contentPadding:
                                EdgeInsets.symmetric(vertical: 10),
                                border: InputBorder.none,
                                prefixIcon: Icon(Icons.lock,
                                    size: 16,
                                    color: Color(0xff989898)),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    controller
                                        .isConfirmPasswordHidden.value
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    size: 16,
                                    color: Color(0xff989898),
                                  ),
                                  onPressed: () {
                                    controller
                                        .isConfirmPasswordHidden.toggle();
                                  },
                                ),
                              ),
                            )),
                          ),


                          Obx(() => controller.confirmPasswordError.value
                              .isNotEmpty
                              ? Padding(
                            padding:
                            const EdgeInsets.only(left: 10, top: 5),
                            child: Text(
                              controller.confirmPasswordError.value,
                              style: TextStyle(
                                  color: Colors.red, fontSize: 11),
                            ),
                          )
                              : SizedBox())
                        ],
                      ),
                    ),

                    SizedBox(height: 20),




                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: InkWell(
                          onTap: () {
                            if (controller.passwordController.text.isEmpty ||
                                controller
                                    .confirmPasswordController.text.isEmpty) {
                              EasyLoading.showToast("Enter all fields");
                              return;
                            }

                            if (controller.passwordController.text !=
                                controller
                                    .confirmPasswordController.text) {
                              EasyLoading.showToast(
                                  "Passwords do not match");
                              return;
                            }

                            controller.CustomerresetPassword(email, otp);
                          },
                          child: Container(
                            width: 300,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: buttontheme),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12.0),
                                child: Text(
                                  'Continue',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
          () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => this),
        );
      },
    );
  }
}
