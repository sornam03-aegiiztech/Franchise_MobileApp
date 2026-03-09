import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:franchaise_app/Constants/Colors.dart';


import 'package:get/get.dart';

import 'CustomerOtpScreen.dart';
import 'LoginScreen.dart';



class CustomerRegisterscreen extends StatelessWidget {
  const CustomerRegisterscreen({super.key});

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: apptheme,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(width * 0.05),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            
                Text(
                  'Join the Network',
                  style: TextStyle(
                    fontSize: width * 0.05,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
            
                SizedBox(height: height * 0.015),
            
                Text(
                  'Discover exclusive premium franchise opportunities \nand connect with top brands',
                  style: TextStyle(
                    fontSize: width * 0.035,
                    color: const Color(0xff919191),
                  ),
                ),
            
                SizedBox(height: height * 0.025),
            
                /// BUSINESS NAME
                Text(
                  'Full Name',
                  style: TextStyle(
                      fontSize: width * 0.040,
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
            
                /// OWNER NAME
                Text(
                  'Mobile Number',
                  style: TextStyle(
                      fontSize: width * 0.040,
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
                    keyboardType: TextInputType.phone,
                    style: const TextStyle(        // ⭐ typed text color
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
            
                /// MOBILE NUMBER
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

                    style: const TextStyle(        // ⭐ typed text color
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
                        Icons.email,
                        size: width * 0.045,
                        color: const Color(0xff989898),
                      ),
                    ),
                  ),
                ),
            
            
            
                SizedBox(height: height * 0.050),
            
            
            
            
            
            
                /// CONTINUE BUTTON
                InkWell(
                  onTap: () {
                    Get.to(Customerotpscreen(phoneNumber: '',));
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
                              Get.to(const CustomerLoginscreen());
                            },
                        ),
                      ],
                    ),
                  ),
                ),
            
                SizedBox(
                  height: 180,
                ),
            
            
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
            
            
              ],
            ),
          ),
        ),
      ),
    );
  }
}