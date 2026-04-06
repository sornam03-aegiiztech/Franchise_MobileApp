import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:franchaise_app/Constants/Colors.dart';
import 'package:franchaise_app/Constants/utlity.dart';


import 'package:get/get.dart';

import '../../../Controllers/CustomerModuleController/AuthController.dart';
import 'CustomerOtpScreen.dart';
import 'LoginScreen.dart';



class CustomerRegisterscreen extends StatelessWidget {
   CustomerRegisterscreen({super.key});

  final CustomerRegisterController registerController=Get.put(CustomerRegisterController());


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
                  Center(
                    child: Image(image: AssetImage('assets/images/applogo.png'),
                      height: 75,
                      width: 75,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text(
                      'Join the Network',
                      style: TextStyle(
                        fontSize: width * 0.05,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),

                  SizedBox(height: height * 0.015),

                  Center(
                    child: Text(
                      'Discover exclusive premium franchise opportunities \nand connect with top brands',
                      style: TextStyle(
                        fontSize: width * 0.035,
                        color: const Color(0xff919191),
                      ),
                      textAlign: TextAlign.center,
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
                      controller: registerController.nameController,
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
                      controller: registerController.mobileController,
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
                      controller: registerController.emailController,
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

                  SizedBox(height: height * 0.02),


                  Text(
                    'Password',
                    style: TextStyle(
                        fontSize: width * 0.040,
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



                  SizedBox(height: height * 0.050),






                  /// CONTINUE BUTTON
                  InkWell(
                    onTap: () {
                      registerController.CustomerregisterUser();
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
                                Get.to(CustomerLoginscreen());
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