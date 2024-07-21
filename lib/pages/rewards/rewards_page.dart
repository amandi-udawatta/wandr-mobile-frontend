import 'package:flutter/material.dart';
import 'package:wandr/theme/app_colors.dart';
import '../../components/bottom_nav_bar.dart';
import '../dashboard_page.dart';

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

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_outlined, size: 30,),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DashboardPage()),
              );
            },
          ),
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
                  'Achieve and Unlock',
                  textAlign: TextAlign.left, // Center the text
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
                  textAlign: TextAlign.left, // Center the text
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Badges Section Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0), // Add horizontal padding
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Your Badges',
                      style: TextStyle(
                        fontSize: 25,
                        color: Kcolours.blackAlternative,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Handle navigation to completed challenges
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
                          padding: const EdgeInsets.all(4.0), // Add padding to create gap
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
            ],
          ),
        ),
      ),
    );
  }
}
