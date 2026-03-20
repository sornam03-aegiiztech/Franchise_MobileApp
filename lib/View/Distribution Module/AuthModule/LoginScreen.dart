import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:franchaise_app/Constants/Colors.dart';
import 'package:franchaise_app/Controllers/DistributorModuleController/AuthControllers.dart';
import 'package:franchaise_app/View/Franchaise%20Module/BottomBar.dart';
import 'package:get/get.dart';

class DistributionLoginscreen extends StatelessWidget {
   DistributionLoginscreen({super.key});

  final DistributorLoginController loginController=Get.put(DistributorLoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: apptheme,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 70.0),
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
                    'Welcome back!',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Access premium franchise opportunites.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white
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
                        controller: loginController.emailController,

                        style: const TextStyle(
                          color: Colors.white,
                        ),

                        decoration: InputDecoration(
                          hintText:'Enter Your email',
                          hintStyle: TextStyle(
                            fontSize: 12,
                            color:  Color(0xff999999),
                          ),
                          contentPadding: EdgeInsets.symmetric(vertical: 10),
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.phone,size: 16,color: Color(0xff989898)),
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
                          loginController.DistributorloginUser();
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
                                'Login',
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
                  SizedBox(height: 20),

                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: 'Dont have an account?',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xff999999),
                        ),
                        children: [
                          TextSpan(
                            text: ' Create an Account',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.to(BottomBarScreen());
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: Text(
                      'By logging in, you agree to olur Terms of Service \nand Privacy policy',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff747474),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
              
                ],
              
              
              
              ),
            ),
          ),
        ),
      ),
    );
  }
}
