import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DirectContactPage extends StatelessWidget {
  const DirectContactPage({super.key});

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xff1F1F1F),

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(width * 0.04),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// TOP BAR
              Row(
                children: [

                  GestureDetector(
                    onTap: (){
                      Get.back();
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: const BoxDecoration(
                        color: Colors.white10,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.arrow_back,color: Colors.white),
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

                  const SizedBox(width:40)

                ],
              ),

              SizedBox(height: height * 0.04),

              /// PROFILE
              Center(
                child: Column(
                  children: [

                    Container(
                      height: 90,
                      width: 90,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.eco,
                        color: Colors.green,
                        size: 40,
                      ),
                    ),

                    const SizedBox(height:10),

                    const Text(
                      "Ramesh Kumar",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),

                    const SizedBox(height:4),

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
                title: "+91 9876543210",
                subtitle: "Primary Contact Number",
              ),

              contactCard(
                icon: Icons.email,
                title: "rameshkumar@gmail.com",
                subtitle: "Email Address",
              ),

              contactCard(
                icon: Icons.location_on,
                title: "Coimbatore, Tamilnadu",
                subtitle: "Location",
              ),

              contactCard(
                icon: Icons.access_time,
                title: "10:00 AM - 07:00 PM",
                subtitle: "Available Hours",
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