import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Appconfig.dart';
import '../../../Controllers/CustomerModuleController/DashboardController.dart';

class FranchiseContactPage extends StatefulWidget {
  final String type;
  final String businessId;

  const FranchiseContactPage({super.key, required this.type, required this.businessId});

  @override
  State<FranchiseContactPage> createState() => _FranchiseContactPageState();
}

class _FranchiseContactPageState extends State<FranchiseContactPage> {
  final controller = Get.put(FranchiseContactController());

  @override
  void initState() {
    super.initState();

    controller.fetchContactDetails(
      type: widget.type,
      businessId: widget.businessId,
    );
  }
  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xff1F1F1F),

      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        final data = controller.details.value;

        if (data == null) {
          return Center(child: Text("No Data"));
        }
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.all(width * 0.04),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// TOP BAR
                Row(
                  children: [

                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: const BoxDecoration(
                          color: Colors.white10,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.arrow_back,
                            color: Colors.white),
                      ),
                    ),

                    const Spacer(),

                    const Text(
                      "Direct Contact",
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

                SizedBox(height: height * 0.04),

                /// PROFILE
                Center(
                  child: Column(
                    children: [

                      CircleAvatar(
                        radius: 45,
                        backgroundImage: NetworkImage(
                          "${AppConfig.imageURL}${data.ownerImage}",
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        data.ownerName,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),

                      const SizedBox(height: 4),

                      const Text(
                        "Franchise Owner",
                        style: TextStyle(color: Colors.white70),
                      )

                    ],
                  ),
                ),

                SizedBox(height: height * 0.04),

                const Text(
                  "Direct Contact Details",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: height * 0.02),

                /// CONTACT CARDS
                contactCard(
                  icon: Icons.call,
                  title: data.mobile,
                  subtitle: "Primary Contact Number",
                ),

                contactCard(
                  icon: Icons.email,
                  title: data.email,
                  subtitle: "Email Address",
                ),





                SizedBox(height: height * 0.02),

                const Text(
                  "Contact details are shared exclusively with Subscribed user. Please respect the privacy of our franchise partners.",
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 12,
                  ),
                )

              ],
            ),
          ),
        );
      }
      ),
    );
  }

  /// CONTACT CARD
  Widget contactCard({
    required IconData icon,
    required String title,
    required String subtitle
  }){

    return Container(
      margin: const EdgeInsets.only(bottom:12),
      padding: const EdgeInsets.all(12),

      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(15),
      ),

      child: Row(
        children: [

          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.white12,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon,color: Colors.white),
          ),

          const SizedBox(width:12),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Text(
                subtitle,
                style: const TextStyle(
                  color: Colors.white54,
                  fontSize: 12,
                ),
              )

            ],
          )

        ],
      ),
    );
  }
}