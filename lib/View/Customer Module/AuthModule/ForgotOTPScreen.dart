import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../Appconfig.dart';
import '../../../Controllers/CustomerModuleController/AuthController.dart';


class CustomerForgototpscreen extends StatefulWidget {
  const CustomerForgototpscreen({super.key});

  @override
  State<CustomerForgototpscreen> createState() => _CustomerForgototpscreenState();
}

class _CustomerForgototpscreenState extends State<CustomerForgototpscreen> {
  final CustomerForgotOtpController controller = Get.put(CustomerForgotOtpController());
  final String email = Get.arguments ?? "";
  int secondsRemaining = 30;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    secondsRemaining = 30;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining == 0) {
        timer.cancel();
      } else {
        setState(() {
          secondsRemaining--;
        });
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1E1E1E),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              /// Title
              const Text(
                "Verify your email",
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 8),

              const Text(
                "We've sent 6-digit code to",
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),

              const SizedBox(height: 4),

              Text(
                email,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),

              const SizedBox(height: 30),

              /// PIN Code Field
              PinCodeTextField(
                appContext: context,
                length: 6,
                controller: controller.otpController,
                keyboardType: TextInputType.number,
                textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(10),
                  fieldHeight: 50,
                  fieldWidth: 50,
                  activeColor: Colors.white,
                  inactiveColor: Colors.grey,
                  selectedColor: Colors.white,
                ),
                onChanged: (value) {},
              ),

              const SizedBox(height: 20),

              /// Resend Section
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Didn’t receive code? ",
                    style: TextStyle(color: Colors.grey),
                  ),
                  secondsRemaining == 0
                      ? GestureDetector(
                    onTap: () async {
                      startTimer();

                      await AppConfig.httpPost("forgot_password", {
                        "email": email,
                      });
                    },
                    child: const Text(
                      "Resend",
                      style: TextStyle(
                          color: Colors.orange,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                      : Text(
                    "Resend (00:$secondsRemaining)",
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),

              const Spacer(),

              /// Continue Button
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffF53D3D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    controller.CustomerverifyOtp(email);
                  },
                  child: const Text(
                    "Continue",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
