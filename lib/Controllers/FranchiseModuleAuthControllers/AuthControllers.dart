import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:franchaise_app/View/Customer%20Module/DetailsPage/FranchiseDetailsPage.dart';
import 'package:franchaise_app/View/Franchaise%20Module/AuthModule/OTPScreen.dart';
import 'package:get/get.dart';

import '../../Appconfig.dart';
import '../../View/Distribution Module/VerficationScreens/DistributorDetailsScreen.dart';
import '../../View/Franchaise Module/AuthModule/ForgototpScreen.dart';
import '../../View/Franchaise Module/AuthModule/LoginScreen.dart';
import '../../View/Franchaise Module/AuthModule/ResetPasswordScreen.dart';
import '../../View/Franchaise Module/BottomBar.dart';
import '../../View/Franchaise Module/VerficationScreens/FranchiseDetailsScreen.dart';

class RegisterController extends GetxController {
  final businessController = TextEditingController();
  final ownerController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var isPasswordHidden = true.obs;

  Future<void> registerUser() async {
    try {
      if (businessController.text.isEmpty) {
        EasyLoading.showError("Enter Business Name");
        return;
      }

      if (ownerController.text.isEmpty) {
        EasyLoading.showError("Enter Owner Name");
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
        "business_name": businessController.text,
        "owner_name": ownerController.text,
        "business_mobile": mobileController.text,
        "business_email": emailController.text,
        "password": passwordController.text,
        "role": "Franchise",
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


          await AppConfig.pref.setString("business_name", businessController.text);
          await AppConfig.pref.setString("owner_name", ownerController.text);
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

          Get.offAll(() => OtpScreen(
            email: emailController.text,
          ));

          AppConfig.httpPost("send_otp", {
            "email": emailController.text,
            "role": "Franchise",
          }).then((otpResponse) {
            if (otpResponse != null) {
              String otpMsg =
                  otpResponse["message"] ?? "OTP sending failed";

              if (otpResponse["status"] == 200) {
                EasyLoading.showSuccess(otpMsg);
              } else {
                EasyLoading.showError(otpMsg);
              }
            } else {
              EasyLoading.showError("OTP API failed");
            }
          });

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
    businessController.clear();
    ownerController.clear();
    mobileController.clear();
    emailController.clear();
    passwordController.clear();
  }
}


class OtpController extends GetxController {
  Future<void> verifyOtp({
    required String email,
    required String otp,
  }) async {
    try {
      EasyLoading.show(status: "Verifying...");

      final response = await AppConfig.httpPost("verify_otp", {
        "email": email,
        "otp": otp,
        "role": "Franchise",
      });

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

            /// 🔥 USER ID
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


          Get.to(FranchiseDetailsScreen());

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



class LoginController extends GetxController {
  var emailController = TextEditingController();
  var passwordController=TextEditingController();
  var isPasswordHidden = true.obs;

  Future<void> loginUser() async {
    try {
      if (!GetUtils.isEmail(emailController.text.trim())) {
        EasyLoading.showError("Enter valid Email");
        return;
      }

      EasyLoading.show(status: "Logging in...");

      final response = await AppConfig.httpPost("login", {
        "email": emailController.text.trim(),
        "password": passwordController.text.trim(),
        "role": "Franchise",
      });
      print("LOGIN RESPONSE → $response");

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


      Get.offAll(() => BottomBarScreen());

    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError("Error: ${e.toString()}");
    }
  }
}




class ForgotPasswordController extends GetxController {
  var emailController = TextEditingController();

  Future<void> forgotPassword() async {
    try {
      if (!GetUtils.isEmail(emailController.text.trim())) {
        EasyLoading.showError("Enter valid Email");
        return;
      }

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

      Get.to(() => Forgototpscreen(), arguments: emailController.text.trim());
    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError("Error: ${e.toString()}");
    }
  }
}

class ForgotOtpController extends GetxController {
  var otpController = TextEditingController();

  Future<void> verifyOtp(String email) async {
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
            () => Resetpasswordscreen(),
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

class ResetPasswordController extends GetxController {
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  var isPasswordHidden = true.obs;
  var isConfirmPasswordHidden = true.obs;

  RxBool isValid = false.obs;

  void validatePasswords() {
    if (passwordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty &&
        passwordController.text == confirmPasswordController.text) {
      isValid.value = true;
    } else {
      isValid.value = false;
    }
  }

  Future<void> resetPassword(String email, String otp) async {
    try {
      /// 🔍 Validation
      if (passwordController.text.isEmpty ||
          confirmPasswordController.text.isEmpty) {
        EasyLoading.showError("Enter all fields");
        return;
      }

      if (passwordController.text != confirmPasswordController.text) {
        EasyLoading.showError("Passwords do not match");
        return;
      }

      if (passwordController.text.length < 6) {
        EasyLoading.showError("Password must be at least 6 characters");
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

      if (Get.isRegistered<LoginController>()) {
        final loginController = Get.find<LoginController>();
        loginController.emailController.clear();
        loginController.passwordController.clear();
      }


      Get.offAll(() => Loginscreen());

    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError("Error: ${e.toString()}");
    }
  }
}