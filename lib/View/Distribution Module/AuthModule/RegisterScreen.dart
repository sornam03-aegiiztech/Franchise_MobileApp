import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:franchaise_app/Constants/Colors.dart';
import 'package:franchaise_app/Constants/utlity.dart';
import 'package:franchaise_app/Controllers/DistributorModuleController/AuthControllers.dart';

import 'package:get/get.dart';

import 'LoginScreen.dart';
import 'OTPScreen.dart';

class DistributorRegisterscreen extends StatelessWidget {
   DistributorRegisterscreen({super.key});


  final DistributorRegisterController registerController=Get.put(DistributorRegisterController());



  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Utility.checkInternetManagerWidget(
     Scaffold(
        backgroundColor: apptheme,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(width * 0.05),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    'Create Account',
                    style: TextStyle(
                      fontSize: width * 0.05,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),

                  SizedBox(height: height * 0.015),

                  Text(
                    'Join our premium network to access exclusive \ninventory and supply chains.',
                    style: TextStyle(
                      fontSize: width * 0.035,
                      color: const Color(0xff919191),
                    ),
                  ),

                  SizedBox(height: height * 0.015),

                  /// BUSINESS NAME
                  Text(
                    'Business Name',
                    style: TextStyle(
                        fontSize: width * 0.035,
                        color: Colors.white),
                  ),

                  SizedBox(height: height * 0.012),

                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: const Color(0xff999999),
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TextFormField(
                      controller: registerController.businessController,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Enter Business Name',
                        hintStyle: TextStyle(
                          fontSize: width * 0.03,
                          color: const Color(0xff999999),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: height * 0.015),
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.business,
                          size: width * 0.045,
                          color: const Color(0xff989898),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: height * 0.02),

                  /// OWNER NAME
                  Text(
                    'Owner Name',
                    style: TextStyle(
                        fontSize: width * 0.035,
                        color: Colors.white),
                  ),

                  SizedBox(height: height * 0.012),

                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: const Color(0xff999999),
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TextFormField(
                      controller: registerController.ownerController,
                      style: const TextStyle(        // ⭐ typed text color
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Enter Your Name',
                        hintStyle: TextStyle(
                          fontSize: width * 0.03,
                          color: const Color(0xff999999),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: height * 0.015),
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.person,
                          size: width * 0.045,
                          color: const Color(0xff989898),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: height * 0.02),

                  /// MOBILE NUMBER
                  Text(
                    'Mobile Number',
                    style: TextStyle(
                        fontSize: width * 0.035,
                        color: Colors.white),
                  ),

                  SizedBox(height: height * 0.012),

                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: const Color(0xff999999),
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TextFormField(
                      controller: registerController.mobileController,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(10),
                      ],
                      decoration: InputDecoration(
                        hintText: 'Enter Your phone number',
                        hintStyle: TextStyle(
                          fontSize: width * 0.03,
                          color: const Color(0xff999999),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: height * 0.015),
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.phone,
                          size: width * 0.045,
                          color: const Color(0xff989898),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: height * 0.02),

                  /// EMAIL
                  Text(
                    'Email Address',
                    style: TextStyle(
                        fontSize: width * 0.035,
                        color: Colors.white),
                  ),

                  SizedBox(height: height * 0.012),

                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: const Color(0xff999999),
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TextFormField(
                      controller: registerController.emailController,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Enter Your Email',
                        hintStyle: TextStyle(
                          fontSize: width * 0.03,
                          color: const Color(0xff999999),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: height * 0.015),
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.mail,
                          size: width * 0.045,
                          color: const Color(0xff989898),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: height * 0.02),

                  /// PASSWORD
                  Text(
                    'Password',
                    style: TextStyle(
                        fontSize: width * 0.035,
                        color: Colors.white),
                  ),

                  SizedBox(height: height * 0.012),

                  Obx(() => Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: const Color(0xff999999),
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TextFormField(
                      controller: registerController.passwordController,
                      style: const TextStyle(
                        color: Colors.white,
                      ),

                      /// 👇 IMPORTANT
                      obscureText: registerController.isPasswordHidden.value,

                      decoration: InputDecoration(
                        hintText: 'Minimum 6 characters',
                        hintStyle: TextStyle(
                          fontSize: width * 0.03,
                          color: const Color(0xff999999),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: height * 0.015,
                        ),
                        border: InputBorder.none,

                        prefixIcon: Icon(
                          Icons.lock,
                          size: width * 0.045,
                          color: const Color(0xff989898),
                        ),

                        /// 👇 EYE ICON
                        suffixIcon: IconButton(
                          icon: Icon(
                            registerController.isPasswordHidden.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            registerController.isPasswordHidden.toggle();
                          },
                        ),
                      ),
                    ),
                  )),

                  SizedBox(height: height * 0.025),

                  /// LOGIN LINK
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: 'Already have an account? ',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xff999999),
                        ),
                        children: [
                          TextSpan(
                            text: 'Log in',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.to( DistributionLoginscreen());
                              },
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: height * 0.012),

                  /// TERMS
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
                            text: 'Privacy Policy',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: height * 0.03),

                  /// CONTINUE BUTTON
                  InkWell(
                    onTap: () {
                      registerController.DistributorregisterUser();
                    },
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: buttontheme,
                      ),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: height * 0.018),
                          child: Text(
                            'Continue',
                            style: TextStyle(
                              fontSize: width * 0.038,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: height * 0.02),
                ],
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