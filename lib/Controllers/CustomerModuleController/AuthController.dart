import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:franchaise_app/View/Customer%20Module/AuthModule/LoginScreen.dart';
import 'package:franchaise_app/View/Customer%20Module/AuthModule/RegisterScreen.dart';
import 'package:franchaise_app/View/Customer%20Module/BottomBar.dart';
import 'package:get/get.dart';
import '../../Appconfig.dart';
import '../../View/Customer Module/AuthModule/CustomerOtpScreen.dart';
import '../../View/Customer Module/AuthModule/ForgotOTPScreen.dart';
import '../../View/Customer Module/AuthModule/ResetPasswordScreen.dart';



class CustomerRegisterController extends GetxController {

  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var isPasswordHidden = true.obs;

  Future<void> CustomerregisterUser() async {
    try {


      if (nameController.text.isEmpty) {
        EasyLoading.showError("Enter Full Name");
        return;
      }

      if (mobileController.text.length != 10) {
        EasyLoading.showError("Enter valid mobile number");
        return;
      }

      if (emailController.text.isEmpty) {
        EasyLoading.showError("Enter Email");
        return;
      }


      if (!GetUtils.isEmail(emailController.text.trim())) {
        EasyLoading.showError("Enter valid Email");
        return;
      }

      if (passwordController.text.length < 6) {
        EasyLoading.showError("Password must be 6 characters");
        return;
      }

      EasyLoading.show(status: "Registering...");

      final response = await AppConfig.httpPost("register", {

        "full_name":nameController.text,
        "phone": mobileController.text,
        "email": emailController.text,
        "password": passwordController.text,
        "role": "Customer",
      });

      EasyLoading.dismiss();

      if (response != null) {
        var status = response["status"] ;
        String message = response["message"] ?? "Something went wrong";


        if (response["error"] != null) {
          message = response["error"];
        }

        if (response["errors"] != null) {
          message = response["errors"].toString();
        }


        bool isSuccess = false;

        if (status is int) {
          isSuccess = status == 200;
        } else if (status is bool) {
          isSuccess = status == true;
        }

        if (isSuccess) {
          EasyLoading.showSuccess(message);



          await AppConfig.pref.setString("name", nameController.text);
          await AppConfig.pref.setString("mobile", mobileController.text);
          await AppConfig.pref.setString("email", emailController.text);

          if (response["user_id"] != null) {
            await AppConfig.pref.setString(
                "user_id", response["user_id"].toString());
          }

          if (response["token"] != null) {
            await AppConfig.pref.setString(
              "token",
              response["token"].toString(),
            );
          }

          Get.offAll(() => Customerotpscreen(
            email: emailController.text,
          ));



        } else {
          EasyLoading.showError(message);
        }

      }

    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError(e.toString());
    }
  }

  void clearFields() {

    nameController.clear();
    mobileController.clear();
    emailController.clear();
    passwordController.clear();
  }
}


class CustomerOtpController extends GetxController {
  Future<void> CustomerverifyOtp({
    required String email,
    required String otp,
  }) async {
    try {
      EasyLoading.show(status: "Verifying...");

      final response = await AppConfig.httpPost("verify_otp", {
        "email": email,
        "otp": otp,
        "role": "Customer",
      });


      print("========== API CALL ==========");
      print("API NAME   : verify_otp");
      print("REQUEST    : {email: $email, otp: $otp, role: Customer}");
      print("RESPONSE   : $response");
      print("================================");

      EasyLoading.dismiss();

      if (response != null) {
        String message = response["message"] ?? "Something went wrong";

        if (response["status"] == 200) {

          EasyLoading.showSuccess(message);




          if (response["role"] != null) {
            await AppConfig.pref.setString(
              "role",
              response["role"].toString(),
            );
          }

          if (response["user"] != null) {
            var user = response["user"];


            if (user["id"] != null) {
              await AppConfig.pref.setString(
                "user_id",
                user["id"].toString(),
              );
            }
            if (user["business_id"] != null) {
              await AppConfig.pref.setString(
                "business_id",
                user["business_id"].toString(),
              );
            }


            if (response["user"] != null) {
              await AppConfig.pref.setString(
                  "user", response["user"].toString());
            }

            await AppConfig.pref.setString("business_name", user["business_name"] ?? "",);

            await AppConfig.pref.setString("owner_name", user["owner_name"] ?? "",);

            await AppConfig.pref.setString("email", user["business_email"] ?? "",);

            await AppConfig.pref.setString("mobile", user["business_mobile"] ?? "",
            );
          }


          Get.offAll(CustomerBottomBarScreen());

        } else {

          EasyLoading.showError(message);
        }
      } else {
        EasyLoading.showError("No response from server");
      }
    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError(e.toString());
    }
  }
}



class CustomerLoginController extends GetxController {
  var emailController = TextEditingController();
  var passwordController= TextEditingController();
  var isPasswordHidden = true.obs;

  Future<void> CustomerloginUser() async {
    try {
      if (!GetUtils.isEmail(emailController.text.trim())) {
        EasyLoading.showError("Enter valid Email");
        return;
      }

      EasyLoading.show(status: "Logging in...");

      final response = await AppConfig.httpPost("login", {
        "email": emailController.text.trim(),
        "role": "Customer",
        "password":passwordController.text.trim(),
      });

      EasyLoading.dismiss();

      if (response == null) {
        EasyLoading.showError("Server error");
        return;
      }

      var status = response["status"];
      String message = response["message"] ?? "Something went wrong";
      String error = response["error"] ?? "";


      if (status != 200) {

        if (message == "Account is not active" || message == "Account is blocked") {
          EasyLoading.showError(message);

          /// 👉 Register screen ku redirect
          Future.delayed(Duration(seconds: 1), () {
            Get.offAll(() => CustomerRegisterscreen()); // 👈 unga register screen
          });

          return;
        }
        EasyLoading.showError(
            error.isNotEmpty ? error : message );
        return;
      }

      EasyLoading.showSuccess(message);


      if (response["token"] != null) {
        await AppConfig.pref.setString(
          "token",
          response["token"].toString(),
        );

        print("TOKEN SAVED → ${response["token"]}");
      }

      var user = response["user"];


      if (user != null) {
        await AppConfig.pref.setString(
            "user_id", user["id"]?.toString() ?? "");

        await AppConfig.pref.setString(
            "business_id", user["business_id"]?.toString() ?? "");

        await AppConfig.pref.setString(
            "business_name", user["business_name"] ?? "");

        await AppConfig.pref.setString(
            "owner_name", user["owner_name"] ?? "");

        // await AppConfig.pref.setString(
        //     "email", user["business_email"] ?? "");

        await AppConfig.pref.setString(
            "mobile", user["business_mobile"] ?? "");

        await AppConfig.pref.setString(
            "role", user["role"] ?? "Franchise"); // backup save
      }


      Get.offAll(() => CustomerBottomBarScreen());

    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError("Error: ${e.toString()}");
    }
  }
}



class CustomerForgotPasswordController extends GetxController {
  var emailController = TextEditingController();

  Future<void> CustomerforgotPassword() async {
    try {
      if (!GetUtils.isEmail(emailController.text.trim())) {
        EasyLoading.showError("Enter valid Email");
        return;
      }
      Get.to(CustomerRegisterscreen());

      EasyLoading.show(status: "Sending OTP...");

      final response = await AppConfig.httpPost("forgot_password", {
        "email": emailController.text.trim(),
      });

      EasyLoading.dismiss();

      if (response == null) {
        EasyLoading.showError("Server error");
        return;
      }

      int status = response["status"] ?? 0;
      String message = response["message"] ?? "Something went wrong";

      if (status != 200) {
        EasyLoading.showError(message);
        return;
      }

      EasyLoading.showSuccess(message);

      Get.to(() =>  CustomerForgototpscreen(), arguments: emailController.text.trim());
    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError("Error: ${e.toString()}");
    }
  }
}

class CustomerForgotOtpController extends GetxController {
  var otpController = TextEditingController();

  Future<void> CustomerverifyOtp(String email) async {
    try {

      if (otpController.text.trim().length != 6) {
        EasyLoading.showError("Enter valid OTP");
        return;
      }


      EasyLoading.show(status: "Verifying OTP...");

      final response = await AppConfig.httpPost("verify_forgot_otp", {
        "email": email,
        "otp": otpController.text.trim(),
      });

      EasyLoading.dismiss();


      if (response == null) {
        EasyLoading.showError("Server error");
        return;
      }

      int status = response["status"] ?? 0;
      String message = response["message"] ?? "Something went wrong";


      if (status != 200) {
        EasyLoading.showError(message);
        return;
      }


      EasyLoading.showSuccess(message);

      Get.to(
            () => CustomerResetScreen(),
        arguments: {
          "email": email,
          "otp": otpController.text.trim(),
        },
      );


    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError("Error: ${e.toString()}");
    }
  }
}

class CustomerResetPasswordController extends GetxController {
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  var isPasswordHidden = true.obs;
  var isConfirmPasswordHidden = true.obs;

  RxBool isValid = false.obs;


  RxString passwordError = ''.obs;
  RxString confirmPasswordError = ''.obs;

  void validatePasswords() {

    if (passwordController.text.isEmpty) {
      passwordError.value = "Enter password";
    } else if (passwordController.text.length < 6) {
      passwordError.value = "Minimum 6 characters required";
    } else {
      passwordError.value = "";
    }


    if (confirmPasswordController.text.isEmpty) {
      confirmPasswordError.value = "Enter confirm password";
    } else if (confirmPasswordController.text != passwordController.text) {
      confirmPasswordError.value = "Passwords do not match";
    } else {
      confirmPasswordError.value = "";
    }


    if (passwordError.value.isEmpty &&
        confirmPasswordError.value.isEmpty) {
      isValid.value = true;
    } else {
      isValid.value = false;
    }
  }

  Future<void> CustomerresetPassword(String email, String otp) async {
    try{

      validatePasswords();

      if (!isValid.value) {
        EasyLoading.showError("Fix errors before continuing");
        return;
      }


      EasyLoading.show(status: "Resetting Password...");

      final response = await AppConfig.httpPost("reset_password", {
        "email": email,
        "otp": otp,
        "password": passwordController.text.trim(),
      });

      EasyLoading.dismiss();


      if (response == null) {
        EasyLoading.showError("Server error");
        return;
      }

      int status = response["status"] ?? 0;
      String message = response["message"] ?? "Something went wrong";


      if (status != 200) {
        EasyLoading.showError(message);
        return;
      }


      EasyLoading.showSuccess(message);

      if (Get.isRegistered<CustomerLoginController>()) {
        final loginController = Get.find<CustomerLoginController>();
        loginController.emailController.clear();
        loginController.passwordController.clear();
      }


      Get.offAll(() => CustomerLoginscreen());

    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError("Error: ${e.toString()}");
    }
  }
}