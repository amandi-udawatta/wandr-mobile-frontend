import 'package:flutter/material.dart';
import 'package:wandr/theme/app_colors.dart';
import '../../components/bottom_nav_bar.dart';
import '../dashboard_page.dart';
import 'completed_challenges_page.dart';
import 'new_challenges_page.dart';
import 'package:google_fonts/google_fonts.dart';

class RewardsPage extends StatelessWidget {
  const RewardsPage({super.key});

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

    // Mock data for ongoing challenges
    final List<Map<String, dynamic>> ongoingChallenges = [
      {
        "name": "Reserve 5 items from our marketplace",
        "completedParts": 3,
        "totalParts": 5,
      },
      {
        "name": "Plan 5 trips with Wandr.",
        "completedParts": 2,
        "totalParts": 5,
      },
      {
        "name": "Reserve 10 items from our marketplace",
        "completedParts": 3,
        "totalParts": 10,
      },
      {
        "name": "Plan 10 trips with Wandr.",
        "completedParts": 5,
        "totalParts": 10,
      },
      {
        "name": "Visit 5 destinations",
        "completedParts": 4,
        "totalParts": 5,
      },
    ];

    // Mock data for new challenges
    final List<Map<String, dynamic>> newChallenges = [
      {
        "name": "Visit 10 destinations",
        "completedParts": 0,
        "totalParts": 10,
      },
      {
        "name": "Plan 20 trips with Wandr.",
        "completedParts": 0,
        "totalParts": 20,
      },
    ];

    // Function to get progress text based on parts completed
    String getProgressText(int completedParts, int totalParts) {
      if (completedParts < totalParts / 2) {
        return "You are off to a great start!";
      } else if (completedParts == totalParts / 2) {
        return "You're doing great so far!";
      } else {
        return "You're nearly there. Keep going!";
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            size: 30,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const DashboardScreen()),
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

              Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "Achieve and unlock badges now!",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w800,
                  fontSize: 22,
                  color: Kcolours.primary,
                ),
              ),
            ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
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

              // Badges Section Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Your Badges",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Kcolours.brownShade4,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const CompletedChallengesPage()),
                        );
                      },
                      child: const Text(
                        'See Completed Challenges',
                        style: TextStyle(
                          color: Kcolours.blueShade1,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // Badges Slider
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  height: 150, // Increased height of the container
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: badges.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10.0),
                        width: 120, // Set width of the container
                        height: 120, // Set height of the container
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.green, width: 3),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(
                              4.0), // Add padding to create gap
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage(badges[index]),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Ongoing Challenges Section Header
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Ongoing Challenges",
                        style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Kcolours.brownShade4,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // Ongoing Challenges Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: SizedBox(
                  height: 350, // Height of the container
                  child: ListView.builder(
                    itemCount: ongoingChallenges.length,
                    itemBuilder: (context, index) {
                      final challenge = ongoingChallenges[index];
                      final completedParts = challenge["completedParts"];
                      final totalParts = challenge["totalParts"];
                      final progress = completedParts / totalParts;
                      final progressText =
                          getProgressText(completedParts, totalParts);

                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 10.0),
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(
                              color: Kcolours.primary.withOpacity(0.5)),
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
                                    border: Border.all(
                                        color: Colors.green, width: 3),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(
                                        4.0), // Add padding to create gap
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: AssetImage(badges[index]),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        progressText,
                                        style: const TextStyle(
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "$completedParts parts completed",
                                  style: const TextStyle(
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
                            LinearProgressIndicator(
                              value: progress,
                              backgroundColor: Colors.grey.withOpacity(0.3),
                              color: Kcolours.primary,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // New Challenges Section Header
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'New Challenges',
                      style: TextStyle(
                        fontSize: 25,
                        color: Kcolours.blackAlternative,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const NewChallengesPage()),
                        );
                      },
                      child: Text(
                        'See All',
                        style: TextStyle(
                          color: Kcolours.blueShade1,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // New Challenges Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  children: List.generate(newChallenges.length, (index) {
                    final challenge = newChallenges[index];
                    final completedParts = challenge["completedParts"];
                    final totalParts = challenge["totalParts"];
                    final progress = completedParts / totalParts;

                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(
                            color: Kcolours.primary.withOpacity(0.5)),
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
                                  border:
                                      Border.all(color: Colors.green, width: 3),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(
                                      4.0), // Add padding to create gap
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: AssetImage(
                                            badges[index % badges.length]),
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
                                      "Start Challenge!",
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "$completedParts parts completed",
                                style: const TextStyle(
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
                          LinearProgressIndicator(
                            value: progress,
                            backgroundColor: Colors.grey.withOpacity(0.3),
                            color: Kcolours.primary,
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
              SizedBox(height: 10)
            ],
          ),
        ),
      ),
    );
  }
}
