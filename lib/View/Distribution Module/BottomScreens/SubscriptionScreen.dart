// import 'package:flutter/material.dart';
// import 'package:franchaise_app/Constants/Colors.dart';
//
// class SubscriptionScreen extends StatelessWidget {
//   const SubscriptionScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//     final height = MediaQuery.of(context).size.height;
//
//     return Scaffold(
//       backgroundColor:apptheme,
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: width * 0.05),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//
//               /// TOP BAR
//               SizedBox(height: height * 0.02),
//               Row(
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                       color: const Color(0xff2E2E2E),
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                     child: const Icon(Icons.arrow_back, color: Colors.white),
//                   ),
//                   const Expanded(
//                     child: Center(
//                       child: Text(
//                         "Subscription",
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 18,
//                             fontWeight: FontWeight.w600),
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: width * 0.08)
//                 ],
//               ),
//
//               SizedBox(height: height * 0.03),
//
//               /// ACTIVE PLAN CARD
//               Container(
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(22),
//                   color: const Color(0xff2A2A2A),
//                 ),
//                 child: Column(
//                   children: [
//
//                     /// RED HEADER
//                     Container(
//                       width: double.infinity,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(22),
//                         color: Colors.white,
//                       ),
//                       child: Column(
//                         children: [
//
//                           /// 🔴 RED HEADER
//                           Container(
//                             width: double.infinity,
//                             padding: EdgeInsets.all(width * 0.05),
//                             decoration: const BoxDecoration(
//                               gradient: LinearGradient(
//                                 colors: [
//                                   Color(0xffF23E46),
//                                   Color(0xff8C2429),
//                                 ],
//                                 begin: Alignment.topCenter,
//                                 end: Alignment.bottomCenter
//                               ),
//                               borderRadius: BorderRadius.vertical(
//                                 top: Radius.circular(22),
//                               ),
//                             ),
//                             child: Stack(
//                               children: [
//
//                                 /// TEXT
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       "ACTIVE PLAN",
//                                       style: TextStyle(
//                                         color: Colors.white70,
//                                         fontSize: 12,
//                                       ),
//                                     ),
//                                     SizedBox(height: 8),
//                                     Text(
//                                       "Annual Membership",
//                                       style: TextStyle(color: Colors.white70),
//                                     ),
//                                     SizedBox(height: 5),
//                                     Text(
//                                       "Franchise Pro Plan",
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontSize: 18,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//
//                                 /// RIGHT IMAGE
//                                 Positioned(
//                                   right: 0,
//                                   top: 0,
//                                   bottom: 0,
//                                   child: Opacity(
//                                     opacity: 0.60,
//                                     child: Image.asset(
//                                       "assets/images/Explore.png", // your image
//                                       width: 90,
//                                       fit: BoxFit.contain,
//
//                                     ),
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),
//
//                           /// ⚪ WHITE STATUS CONTAINER
//                           Padding(
//                             padding: EdgeInsets.all(width * 0.05),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//
//                                 const Text(
//                                   "SUBSCRIPTION STATUS",
//                                   style: TextStyle(
//                                     color: Colors.grey,
//                                     fontSize: 12,
//                                     letterSpacing: 1,
//                                   ),
//                                 ),
//
//                                 const SizedBox(height: 10),
//
//                                 const Text(
//                                   "Your Premium access to listing\nmanagement and lead tracking is active.",
//                                   style: TextStyle(
//                                     color: Colors.black87,
//                                   ),
//                                 ),
//
//                                 const SizedBox(height: 8),
//
//                                 const Text(
//                                   "Next renewal: Oct 24,2026",
//                                   style: TextStyle(
//                                     color: Colors.black,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//
//                                 const SizedBox(height: 20),
//
//                                 /// RENEW BUTTON
//                                 Container(
//                                   width: double.infinity,
//                                   padding: const EdgeInsets.symmetric(vertical: 14),
//                                   decoration: BoxDecoration(
//                                     color: const Color(0xffFF4D4D),
//                                     borderRadius: BorderRadius.circular(30),
//                                   ),
//                                   child: const Center(
//                                     child: Text(
//                                       "Renew Now ₹199",
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ),
//                                 )
//                               ],
//                             ),
//                           )
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//
//               SizedBox(height: height * 0.03),
//
//               /// BILLING HISTORY
//               const Text(
//                 "Billing History",
//                 style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600),
//               ),
//
//               SizedBox(height: height * 0.02),
//
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: 3,
//                   itemBuilder: (context, index) {
//                     return Container(
//                       margin: const EdgeInsets.only(bottom: 15),
//                       padding: const EdgeInsets.all(15),
//                       decoration: BoxDecoration(
//                         color: const Color(0xff2A2A2A),
//                         borderRadius: BorderRadius.circular(16),
//                       ),
//                       child: Row(
//                         children: [
//
//                           /// ICON
//                           Container(
//                             padding: const EdgeInsets.all(10),
//                             decoration: BoxDecoration(
//                               color: const Color(0xff3A3A3A),
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             child: const Icon(Icons.receipt,
//                                 color: Colors.white),
//                           ),
//
//                           const SizedBox(width: 15),
//
//                           /// TEXT
//                           const Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   "September 2024 Invoice",
//                                   style: TextStyle(color: Colors.white),
//                                 ),
//                                 SizedBox(height: 4),
//                                 Text(
//                                   "Sep23,2025 - ₹199",
//                                   style: TextStyle(
//                                       color: Colors.grey, fontSize: 12),
//                                 ),
//                               ],
//                             ),
//                           ),
//
//                           const Icon(Icons.download, color: Colors.white70)
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1f1f1f),
      appBar: AppBar(
        backgroundColor: const Color(0xff1f1f1f),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Subscription",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        leading: const Icon(Icons.arrow_back, color: Colors.white),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// Active Plan Card
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xffF23E46),
                    Color(0xff8C2429),
                  ],
                  begin: Alignment.topCenter,
                  end: AlignmentGeometry.bottomCenter
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// top red section
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(.25),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            "ACTIVE PLAN",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600),
                          ),
                        ),

                        const SizedBox(height: 10),

                        const Text(
                          "Annual Membership",
                          style: TextStyle(
                              color: Colors.white70, fontSize: 12),
                        ),

                        const SizedBox(height: 4),

                        const Text(
                          "Franchise Pro Plan",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),

                  /// bottom white section
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      color: Color(0xffeeeeee),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        const Text(
                          "SUBSCRIPTION STATUS",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey),
                        ),

                        const SizedBox(height: 10),

                        const Text(
                          "Your Premium access to listing\nmanagement and lead tracking is active.",
                          style: TextStyle(fontSize: 13),
                        ),
                        const Text(
                          "Next renewal: Oct 24,2026",
                          style: TextStyle(
                              fontWeight: FontWeight.w600),
                        ),

                        const SizedBox(height: 16),

                        /// Renew Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xffff4b4b),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            onPressed: () {},
                            child: const Text(
                              "Renew Now ₹199",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                              color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 25),

            /// Billing History Title
            const Text(
              "Billing History",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 15),

            /// Billing List
            Column(
              children: List.generate(
                3,
                    (index) => Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xff2c2c2c),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [

                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade700,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.receipt,
                            color: Colors.white),
                      ),

                      const SizedBox(width: 12),

                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "September 2024 Invoice",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Sep 23,2025 - ₹199",
                              style: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 12),
                            ),
                          ],
                        ),
                      ),

                      const Icon(Icons.download,
                          color: Colors.white70)
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}