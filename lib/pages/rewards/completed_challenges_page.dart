import 'package:flutter/material.dart';
import 'package:wandr/pages/rewards/rewards_page.dart';
import 'package:wandr/theme/app_colors.dart';
import '../../components/bottom_nav_bar.dart';

class CompletedChallengesPage extends StatelessWidget {
  const CompletedChallengesPage({super.key});

  @override
  Widget build(BuildContext context) {
    // List of badge image paths
    final List<String> badges = [
      'assets/images/badges/badge-1.png',
      'assets/images/badges/badge-1.png',
      'assets/images/badges/badge-1.png',
      'assets/images/badges/badge-1.png',
      'assets/images/badges/badge-1.png',
      'assets/images/badges/badge-1.png',
      'assets/images/badges/badge-1.png',
      'assets/images/badges/badge-1.png',
      'assets/images/badges/badge-1.png',
      'assets/images/badges/badge-1.png',
    ];

    // Mock data for completed challenges
    final List<Map<String, dynamic>> completedChallenges = [
      {
        "name": "Plan first trip with Wandr.",
        "completedParts": 1,
        "totalParts": 1,
      },
      {
        "name": "Reserve your first item from our marketplace",
        "completedParts": 1,
        "totalParts": 1,
      },
      {
        "name": "Create your first blog",
        "completedParts": 1,
        "totalParts": 1,
      },
      {
        "name": "Visit 5 different cities",
        "completedParts": 5,
        "totalParts": 5,
      },
      {
        "name": "Visit 5 cultural sites",
        "completedParts": 5,
        "totalParts": 5,
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined, size: 30,),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const RewardsPage()),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
      body: SafeArea(
        child: Center(
          child: ListView(
            children: [
              const SizedBox(height: 5),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  'Completed Challenges',
                  textAlign: TextAlign.left, // Align the text to the left
                  style: TextStyle(
                    color: Color(0xFF437B17),
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins-Bold',
                  ),
                ),
              ),

              // Description
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0), // Add horizontal padding
                child: Text(
                  'Complete challenges, earn badges, and unlock exclusive rewards.',
                  textAlign: TextAlign.left, // Align the text to the left
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Completed Challenges Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  children: List.generate(completedChallenges.length, (index) {
                    final challenge = completedChallenges[index];
                    final completedParts = challenge["completedParts"];
                    final totalParts = challenge["totalParts"];
                    final progress = completedParts / totalParts;

                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(color: Kcolours.primary.withOpacity(0.5)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [

                              // Badge Image
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.green, width: 3),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0), // Add padding to create gap
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: AssetImage(badges[index % badges.length]),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(width: 15),

                              // Challenge Details
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Woo Hoo! You've done it!",
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Kcolours.greyShade1,
                                      ),
                                    ),

                                    const SizedBox(height: 5),

                                    Text(
                                      challenge["name"],
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: Kcolours.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 10),

                          LinearProgressIndicator(
                            value: progress,
                            backgroundColor: Colors.grey.withOpacity(0.3),
                            color: Kcolours.primary,
                          ),

                          const SizedBox(height: 5),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Completed!",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Kcolours.blackAlternative,
                                ),
                              ),
                              Text(
                                "Goal : $totalParts parts",
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Kcolours.blackAlternative,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 5),
                        ],
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(height: 10)
            ],
          ),
        ),
      ),
    );
  }
}
