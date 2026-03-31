import 'package:flutter/material.dart';
import 'package:franchaise_app/Constants/Colors.dart';
import 'package:get/get.dart';

import '../../../Appconfig.dart';
import '../../../Controllers/CustomerModuleController/DashboardController.dart';
import '../Contact/DistributorContact.dart';
import '../Subscriptions/PremiumScreen.dart';

class DistributorsDetailsPage extends StatefulWidget {
  final String type;
  final String businessId;

  const DistributorsDetailsPage({
    super.key,
    required this.type,
    required this.businessId,
  });

  @override
  State<DistributorsDetailsPage> createState() =>
      _DistributorsDetailsPageState();
}

class _DistributorsDetailsPageState
    extends State<DistributorsDetailsPage> {

  final controller = Get.put(GetDistributorDetailsController());

  @override
  void initState() {
    super.initState();

    controller.fetchDistributorDetails(
      type: widget.type,
      businessId: widget.businessId,
      viewType: "profile",
    );
  }

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xff1F1F1F),
      resizeToAvoidBottomInset: true,

      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final data = controller.details.value;

        if (data == null) {
          return const Center(child: Text("No Data"));
        }

        return SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),

            child: Column(
              children: [

                /// 🔥 IMAGE HEADER
                Stack(
                  children: [

                    SizedBox(
                      height: height * 0.45,
                      width: double.infinity,
                      child: (data.logo.isNotEmpty)
                          ? Image.network(
                        "${AppConfig.imageURL}${data.logo}",
                        fit: BoxFit.cover,
                      )
                          : Container(
                        color: Colors.black26,
                        child: const Icon(Icons.image,
                            color: Colors.white),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: width * 0.04, vertical: 10),
                      child: Row(
                        children: [

                          /// BACK
                          InkWell(
                            onTap: () => Get.back(),
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: const BoxDecoration(
                                color: Colors.black45,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.arrow_back_ios,
                                  color: Colors.white, size: 18),
                            ),
                          ),

                          const Spacer(),

                          const Text(
                            "Distributor Details",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const Spacer(),

                          const SizedBox(width: 40)
                        ],
                      ),
                    ),
                  ],
                ),

                /// 🔥 MAIN CONTENT
                Container(
                  width: width,
                  padding: EdgeInsets.all(width * 0.05),

                  decoration: const BoxDecoration(
                    color: Color(0xff2A2A2A),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      /// HEADER
                      Row(
                        children: [

                          Container(
                            height: 55,
                            width: 55,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(Icons.store,
                                color: Colors.black),
                          ),

                          const SizedBox(width: 12),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              /// 🔥 FIXED
                              Text(
                                data.brandName,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              Text(
                                data.category,
                                style: const TextStyle(
                                    color: Colors.white70),
                              ),
                            ],
                          )
                        ],
                      ),

                      const SizedBox(height: 20),

                      /// UNITS
                      const Text(
                        "Minimum Order",
                        style: TextStyle(color: Colors.white70),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        "${data.units} Units",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 15),

                      /// DAYS
                      const Text(
                        "Delivery Time",
                        style: TextStyle(color: Colors.white70),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        "${data.days} Days",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 20),

                      /// ABOUT
                      const Text(
                        "About Distributor",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 8),

                      /// 🔥 FIXED
                      Text(
                        data.description,
                        style: const TextStyle(
                          color: Colors.white70,
                          height: 1.4,
                        ),
                      ),

                      const SizedBox(height: 20),

                      /// TERRITORY
                      const Text(
                        "Territory",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        data.territory,
                        style: const TextStyle(
                          color: Colors.white70,
                        ),
                      ),

                      const SizedBox(height: 30),

                      /// 🔥 CONTACT BUTTON
                      InkWell(
                        onTap: () {
                          Get.to(
                            DistributorContactPage(
                              type: widget.type,
                              businessId: widget.businessId,
                            ),
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          height: 55,
                          decoration: BoxDecoration(
                            color: buttontheme,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Center(
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: [
                                Icon(Icons.lock,
                                    color: Colors.white, size: 16),
                                SizedBox(width: 5),
                                Text(
                                  "Contact Owner",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      /// 🔥 OVERFLOW FIX
                      const SizedBox(height: 40),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}