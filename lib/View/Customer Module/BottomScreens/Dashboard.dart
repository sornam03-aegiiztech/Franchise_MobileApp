import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:franchaise_app/Constants/Colors.dart';
import 'package:franchaise_app/View/Customer%20Module/BottomScreens/SearchFilterScreen.dart';

import 'package:get/get.dart';

import 'AllDistributorsScreen.dart';
import 'AllFranchiseScreen.dart';

class CustomerHomePage extends StatefulWidget {
  const CustomerHomePage({super.key});

  @override
  State<CustomerHomePage> createState() => _CustomerHomePageState();
}

class _CustomerHomePageState extends State<CustomerHomePage> {



  List<Map<String, String>> distributors = [
    {
      "title": "Luxe Goods",
      "location": "Luxury Retails, Coimbatore",
      "image": "https://images.unsplash.com/photo-1607082348824-0a96f2a4b9da"
    },
    {
      "title": "Fashion Hub",
      "location": "Fashion Store, Chennai",
      "image": "https://images.unsplash.com/photo-1521334884684-d80222895322"
    },
  ];

  List<Map<String, String>> franchises = List.generate(
    10,
        (index) => {
      "title": "Franchise ${index + 1}",
      "investment": "Investment ₹${(index + 1) * 2} Lakhs",
      "image": "https://picsum.photos/400/300?random=$index"
    },
  );

  double dragPosition = 0;



  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: apptheme,

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// TOP BAR
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    const CircleAvatar(
                      radius: 22,
                      backgroundImage: NetworkImage(
                          "https://randomuser.me/api/portraits/men/32.jpg"),
                    ),

                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white10,

                      ),
                      child: const Icon(Icons.notifications_none,
                          color: Colors.white),
                    )
                  ],
                ),

                const SizedBox(height: 15),

                /// WELCOME TEXT
                const Text(
                  "Welcome Guhan,",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),

                const SizedBox(height: 4),

                const Text(
                  "Find the perfect franchise to invest in.",
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),

                const SizedBox(height: 18),

                /// SEARCH BAR
                GestureDetector(
                  onTap: (){
                    Get.to(() => SearchFilterPage());
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color(0xff3F3F3F),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.search, color: Colors.white54),
                        SizedBox(width: 10),
                        Text("Search franchises...",
                            style: TextStyle(color: Colors.white54))
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                /// FEATURED FRANCHISE HEADER
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:  [
                    Text("Featured Franchises",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600)),
                    InkWell(
                      onTap: (){
                        Get.to(AllFranchisePage());
                      },
                      child: Text("View All",
                          style:
                          TextStyle(color: Colors.white54, fontSize: 13)),
                    )
                  ],
                ),

                const SizedBox(height: 15),

                /// FRANCHISE STACK SWIPE
                SizedBox(
                  height: 280,
                  child: Stack(
                    children: franchises
                        .asMap()
                        .entries
                        .map((entry) {

                      int index = entry.key;
                      var data = entry.value;

                      double left;
                      double right;

                      if (index == 0) {
                        left = 40;
                        right = 40;
                      } else if (index == 1) {
                        left = 20;
                        right = 20;
                      } else {
                        left = 0;
                        right = 0;
                      }

                      return Positioned(
                        top: index * 15,
                        left: left,
                        right: right,
                        bottom: index * 10,

                        child: Dismissible(
                          key: ValueKey(data["title"]),

                          direction: DismissDirection.horizontal,

                          onDismissed: (direction) {
                            setState(() {
                              franchises.removeAt(index);
                            });
                          },

                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),

                            child: Stack(
                              children: [

                                Positioned.fill(
                                  child: Image.network(
                                    data["image"]!,
                                    fit: BoxFit.cover,
                                  ),
                                ),

                                Positioned.fill(
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.transparent,
                                          Colors.black87
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      ),
                                    ),
                                  ),
                                ),

                                /// CLOSE BUTTON (FRONT CARD ONLY)
                                if (index == 0)
                                  Positioned(
                                    right: 10,
                                    top: 10,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          franchises.removeAt(index);
                                        });
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(6),
                                        decoration: const BoxDecoration(
                                          color: Colors.black45,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.close,
                                          size: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),

                                /// TEXT
                                Positioned(
                                  left: 15,
                                  bottom: 65,
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data["title"]!,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        data["investment"]!,
                                        style: const TextStyle(
                                          color: Colors.white70,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),

                                /// SEE MORE (FRONT CARD ONLY)


                                Positioned(
                                  left: 15,
                                  bottom: 10,
                                  child: StatefulBuilder(
                                    builder: (context, setStateBtn) {
                                      return GestureDetector(

                                        onHorizontalDragUpdate: (details) {
                                          setStateBtn(() {
                                            dragPosition += details.delta.dx;

                                            if (dragPosition < 0)
                                              dragPosition = 0;
                                            if (dragPosition > 150)
                                              dragPosition = 150;
                                          });
                                        },

                                        onHorizontalDragEnd: (details) {
                                          if (dragPosition > 130) {

                                            /// NAVIGATE PAGE
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (
                                                    context) => const  AllFranchisePage (),
                                              ),
                                            );
                                          }

                                          setStateBtn(() {
                                            dragPosition = 0;
                                          });
                                        },

                                        child: Container(
                                          width: 220,
                                          height: 45,

                                          decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(
                                                .25),
                                            borderRadius: BorderRadius.circular(
                                                30),
                                          ),

                                          child: Stack(
                                            alignment: Alignment.centerLeft,
                                            children: [

                                              const Center(
                                                child: Text(
                                                  "See more",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),

                                              AnimatedPositioned(
                                                duration: const Duration(
                                                    milliseconds: 100),
                                                left: dragPosition,

                                                child: Container(
                                                  height: 40,
                                                  width: 40,

                                                  decoration: const BoxDecoration(
                                                    color: Colors.white,
                                                    shape: BoxShape.circle,
                                                  ),

                                                  child: const Icon(
                                                    Icons.arrow_forward_ios,
                                                    size: 16,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),

                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                      );

                    }).toList().reversed.toList(),
                  ),
                ),

                const SizedBox(height: 25),

                /// FEATURED DISTRIBUTORS HEADER
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:  [
                    Text("Featured Distributors",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600)),
                    InkWell(
                      onTap: (){
                        Get.to(AllDistributorsPage());
                      },
                      child: Text("View All",
                          style:
                          TextStyle(color: Colors.white54, fontSize: 13)),
                    )
                  ],
                ),

                const SizedBox(height: 15),

                /// DISTRIBUTOR LIST
                SizedBox(
                  height: 190,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: distributors.length,
                    itemBuilder: (context, index) {

                      final data = distributors[index];

                      return Container(
                        width: width * 0.45,
                        margin: const EdgeInsets.only(right: 12),

                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),

                          child: Stack(
                            children: [

                              Positioned.fill(
                                child: Image.network(
                                  data["image"]!,
                                  fit: BoxFit.cover,
                                ),
                              ),

                              Positioned.fill(
                                child: Container(
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.transparent,
                                        Colors.black87
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ),
                                  ),
                                ),
                              ),

                             Positioned(
                                top: 10,
                                left: 10,
                                child: Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(
                                            .25),
                                        borderRadius: BorderRadius.circular(15)
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                        child: Row(
                                          children: [
                                            Icon(Icons.star,
                                                color: Colors.amber, size: 12),
                                            SizedBox(width: 3),
                                            Text("4.5",
                                                style: TextStyle(color: Colors.white))
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),

                              Positioned(
                                bottom: 0,
                                left: 0,
                                child: Container(
                                  height: 55,
                                  width: 200,
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(.25),
                                    borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(20),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [

                                      /// TEXT SECTION
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [

                                            Text(
                                              data["title"]!,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),

                                            Text(
                                              data["location"]!,
                                              style: const TextStyle(
                                                color: Colors.white70,
                                                fontSize: 8,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      /// RIGHT ICON
                                      Padding(
                                        padding: const EdgeInsets.only(right: 32.0),
                                        child: InkWell(
                                          onTap: (){
                                            Get.to(AllDistributorsPage());
                                          },
                                          child: Container(
                                            height: 35,
                                            width: 35,
                                            decoration: BoxDecoration(
                                              color: Colors.white.withOpacity(.2),
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Icon(
                                              Icons.arrow_forward_ios,
                                              size: 13,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}