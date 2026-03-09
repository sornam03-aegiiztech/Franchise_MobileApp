import 'package:flutter/material.dart';
import 'package:franchaise_app/Constants/Colors.dart';
import 'package:get/get.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage({super.key});

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: apptheme,

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
                      child: Padding(
                        padding: const EdgeInsets.only(left: 7.0),
                        child: const Icon(Icons.arrow_back_ios,color: Colors.white,size: 15,),
                      ),
                    ),
                  ),

                  const Spacer(),

                  const Text(
                    "Favorite",
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

              SizedBox(height: height * 0.02),

              /// SEARCH BAR
              Row(
                children: [

                  Expanded(
                    child: Container(
                      height: 50,
                      padding: const EdgeInsets.symmetric(horizontal: 15),

                      decoration: BoxDecoration(
                        color: Colors.white10,
                        borderRadius: BorderRadius.circular(30),
                      ),

                      child: TextFormField(
                        style: const TextStyle(color: Colors.white),

                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Search favorite...",
                          hintStyle: TextStyle(color: Colors.white54,fontSize: 14),
                          contentPadding: EdgeInsets.symmetric(vertical: 13,horizontal: 8),

                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.white54,
                            size: 16,
                          ),

                          suffixIcon: Icon(
                            Icons.close,
                            color: Colors.white54,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),

                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: const Icon(Icons.tune, color: Colors.white),
                  )

                ],
              ),

              SizedBox(height: height * 0.02),

              const Text(
                "1 Results Found",
                style: TextStyle(color: Colors.white70),
              ),

              SizedBox(height: height * 0.02),

              /// RESULT LIST
              Expanded(
                child: ListView(
                  children: [

                    resultCard(
                      title: "Pulse Fitness",
                      subtitle: "Investment: ₹150,000",
                      category: "Health & Wellness . 12 Locations",
                      image: "https://images.unsplash.com/photo-1556911220-e15b29be8c8f",
                    ),

                    resultCard(
                      title: "Luxe Goods",
                      subtitle: "Minimum Order 500units",
                      category: "Skin care . 2 Locations",
                      image: "https://images.unsplash.com/photo-1521334884684-d80222895322",
                    ),

                  ],
                ),
              )

            ],
          ),
        ),
      ),
    );
  }

  /// CARD WIDGET
  Widget resultCard({
    required String title,
    required String subtitle,
    required String category,
    required String image
  }){

    return Stack(
      children: [

        /// MAIN CARD
        Container(

          margin: const EdgeInsets.only(bottom:15),
          padding: const EdgeInsets.all(16),

          decoration: BoxDecoration(
            color: Colors.white10,
            borderRadius: BorderRadius.circular(20),
          ),

          child: Column(
            children: [

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// TEXT
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text(
                          title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),

                        const SizedBox(height:4),

                        Text(
                          subtitle,
                          style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 12),
                        ),

                        const SizedBox(height:10),

                        Text(
                          category,
                          style: const TextStyle(
                              color: Colors.white54,
                              fontSize: 12),
                        )

                      ],
                    ),
                  ),

                  const SizedBox(width:10),

                  /// IMAGE
                  Stack(
                    children: [

                      Padding(
                        padding: const EdgeInsets.only(right: 30.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            image,
                            height:70,
                            width:80,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      /// RATING
                      Positioned(
                        bottom:5,
                        left:5,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal:6,
                              vertical:2
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Row(
                            children: [
                              Icon(Icons.star,
                                  color: Colors.amber,
                                  size:12),
                              SizedBox(width:2),
                              Text(
                                "4.5",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize:10
                                ),
                              )
                            ],
                          ),
                        ),
                      ),

                    ],
                  )

                ],
              ),

              const SizedBox(height:15),

              /// BUTTON
              Container(
                height:45,
                width: double.infinity,

                decoration: BoxDecoration(
                  color: buttontheme,
                  borderRadius: BorderRadius.circular(25),
                ),

                child: const Center(
                  child: Text(
                    "View Details",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )

            ],
          ),
        ),

        /// SAVE ICON (CARD TOP RIGHT)
        Positioned(
          top: 8,
          right: 8,
          child: Container(
            height: 25,
            width: 25,
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
                color: Colors.white12,
                shape: BoxShape.circle

            ),
            child: const Icon(
              Icons.favorite,
              color: Colors.white,
              size:8,
            ),
          ),
        ),

      ],
    );
  }
}