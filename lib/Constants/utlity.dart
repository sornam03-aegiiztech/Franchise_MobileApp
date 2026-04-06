import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:franchaise_app/Constants/Colors.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';




class Utility {
  static var screenWidth = MediaQuery.of(Get.context!).size.width;
  static var screenHeight = MediaQuery.of(Get.context!).size.height;

  static Widget checkInternetManagerWidget(Widget child, Function onRefresh) {
    return FutureBuilder(
      future: InternetConnectionChecker().hasConnection,
      builder: (context, snapshot) {
        if (snapshot.hasData && !snapshot.hasError && snapshot.data == true) {
          return child;
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            backgroundColor:apptheme,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.25,
                  ),
                  Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                          color: Colors.red, shape: BoxShape.circle),
                      child: Icon(
                        Icons.signal_wifi_off_outlined,
                        color: Colors.white,
                        size: 80,
                      )),
                  const SizedBox(height: 20),
                  Text("No Network !",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w900)),
                  const SizedBox(height: 10),
                  Text("Looks like something went wrong",
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                  const SizedBox(height: 30),
                  ElevatedButton(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 50)),
                        foregroundColor: MaterialStateProperty.all(Colors.black),
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                      ),
                      child:  Text("Try Again",
                          style: TextStyle(

                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold)),
                      onPressed: () => onRefresh())
                ],
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }



}
