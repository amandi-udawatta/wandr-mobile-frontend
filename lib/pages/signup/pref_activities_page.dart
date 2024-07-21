import 'package:flutter/material.dart';
import 'package:wandr/components/primary_button.dart';
import 'package:wandr/pages/home/home_search_screen.dart';
import 'package:wandr/theme/app_colors.dart';

import '../../components/bottom_nav_bar.dart';

class PrefActivitiesPage extends StatefulWidget {
  const PrefActivitiesPage({super.key});

  @override
  _PrefActivitiesPageState createState() => _PrefActivitiesPageState();
}

class _PrefActivitiesPageState extends State<PrefActivitiesPage> {
  // List of activities with their image paths and names
  final List<Map<String, String>> activities = [
    {"image": "assets/images/categories/bird-watching.png", "name": "Bird Watching"},
    {"image": "assets/images/categories/boating.png", "name": "Boating"},
    {"image": "assets/images/categories/camping.png", "name": "Camping"},
    {"image": "assets/images/categories/canoeing.png", "name": "Canoeing"},
    {"image": "assets/images/categories/caving.png", "name": "Caving"},
    {"image": "assets/images/categories/cycling.png", "name": "Cycling"},
    {"image": "assets/images/categories/elephant-rides.png", "name": "Elephant Rides"},
    {"image": "assets/images/categories/fishing.png", "name": "Fishing"},
    {"image": "assets/images/categories/food-tours.png", "name": "Food Tours"},
    {"image": "assets/images/categories/hiking.png", "name": "Hiking"},
    {"image": "assets/images/categories/historical-tours.png", "name": "Historical Tours"},
    {"image": "assets/images/categories/hot-air-ballooning.png", "name": "Hot Air Ballooning"},
    {"image": "assets/images/categories/kayaking.png", "name": "Kayaking"},
    {"image": "assets/images/categories/photography.png", "name": "Photography"},
    {"image": "assets/images/categories/rock-climbing.png", "name": "Rock Climbing"},
    {"image": "assets/images/categories/scuba-diving.png", "name": "Scuba Diving"},
    {"image": "assets/images/categories/surfing.png", "name": "Surfing"},
    {"image": "assets/images/categories/tea-plantation-tours.png", "name": "Tea Plantation Tours"},
    {"image": "assets/images/categories/temple-visits.png", "name": "Temple Visits"},
    {"image": "assets/images/categories/trekking.png", "name": "Trekking"},
    {"image": "assets/images/categories/village-tours.png", "name": "Village Tours"},
    {"image": "assets/images/categories/waterfall-visits.png", "name": "Waterfall Visits"},
    {"image": "assets/images/categories/whale-watching.png", "name": "Whale Watching"},
    {"image": "assets/images/categories/wildlife-safari.png", "name": "Wildlife Safari"},
  ];

  // List to keep track of selected activities
  final List<bool> selectedActivities = List<bool>.filled(24, false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // BACKGROUND COLOR
      body: SafeArea(
        child: Center(
          child: ListView(
            children: [
              SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  'Pick Your Favorite Activities in Sri Lanka',
                  style: TextStyle(
                    color: Color(0xFF437B17),
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins-Bold',
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0), // Add horizontal padding
                child: Text(
                  'Let us know what activities you love to do during your travels. This will help us tailor your recommendations to match your interests.',
                  textAlign: TextAlign.left, // Align the text to the left
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
              ),

              SizedBox(height: 20),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: const Text(
                  'Select all that apply',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 20,
                  ),
                ),
              ),

              SizedBox(height: 15),

              // Grid selection of activities
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(), // Disable scrolling
                  shrinkWrap: true, // Use only necessary space
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1.0, // Make the boxes square
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: activities.length,
                  itemBuilder: (context, index) {
                    final activity = activities[index];
                    final isSelected = selectedActivities[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedActivities[index] = !isSelected;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          border: isSelected ? Border.all(color: Kcolours.primary, width: 3) : null,
                          boxShadow: isSelected
                              ? [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            )
                          ]
                              : [],
                        ),
                        child: Stack(
                          children: [
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    activity["image"]!,
                                    height: 60,
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    activity["name"]!,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 16, color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                            if (isSelected)
                              Positioned(
                                top: 8,
                                right: 8,
                                child: Icon(
                                  Icons.check_circle,
                                  color: Color(0xFF437B17),
                                  size: 20,
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              SizedBox(height: 50),

              // Proceed Button
              PrimaryButton(
                text: "Proceed",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SearchScreen()),
                  );
                },
              ),

              SizedBox(height: 20),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0), // Add horizontal padding
                child: Text(
                  '(Your preferences can be updated anytime in your profile settings)',
                  textAlign: TextAlign.left, // Align the text to the left
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
              ),

              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
