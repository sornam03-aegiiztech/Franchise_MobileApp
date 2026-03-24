import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Constants/Colors.dart';
import '../../../Controllers/DistributorModuleController/AuthControllers.dart';
import 'ForgotOTPScreen.dart';

class DistributorForgotPassword extends StatelessWidget {
 DistributorForgotPassword({super.key});

  final DistributorForgotPasswordController controller =
  Get.put(DistributorForgotPasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: apptheme,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image(image: AssetImage('assets/images/applogo.png'),
                    height: 75,
                    width: 75,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Forgot Password',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),


                  SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Color(0xff999999),
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: TextFormField(
                        controller: controller.emailController,
                        keyboardType: TextInputType.emailAddress,
                        style: const TextStyle(
                          color: Colors.white,
                        ),

                        decoration: InputDecoration(
                          hintText:'Enter Your Email',
                          hintStyle: TextStyle(
                            fontSize: 12,
                            color:  Color(0xff999999),
                          ),
                          contentPadding: EdgeInsets.symmetric(vertical: 10),
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.mail,size: 16,color: Color(0xff989898)),
                        ),
                      ),
                    ),
                  ),




                  SizedBox(
                    height: 30,
                  ),

                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: InkWell(
                        onTap: (){
                          controller.DistributorforgotPassword();
                        },
                        child: Container(
                          width: 300,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: buttontheme
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12.0),
                              child: Text(
                                'Send OTP',
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
    );
  }
}
