import 'package:flutter/material.dart';
import 'package:wandr/components/primary_button.dart';
import 'package:wandr/pages/home/home_search_screen.dart';
import 'package:wandr/theme/app_colors.dart';

class PrefActivitiesPage extends StatefulWidget {
  const PrefActivitiesPage({super.key});

  @override
  _PrefActivitiesPageState createState() => _PrefActivitiesPageState();
}

class _PrefActivitiesPageState extends State<PrefActivitiesPage> {
  // List of activities with their image paths and names
  final List<Map<String, String>> activities = [
    {"image": "assets/images/activities/bird-watching.png", "name": "Bird Watching"},
    {"image": "assets/images/activities/boating.png", "name": "Boating"},
    {"image": "assets/images/activities/camping.png", "name": "Camping"},
    {"image": "assets/images/activities/canoeing.png", "name": "Canoeing"},
    {"image": "assets/images/activities/caving.png", "name": "Caving"},
    {"image": "assets/images/activities/cycling.png", "name": "Cycling"},
    {"image": "assets/images/activities/elephant-rides.png", "name": "Elephant Rides"},
    {"image": "assets/images/activities/fishing.png", "name": "Fishing"},
    {"image": "assets/images/activities/food-tours.png", "name": "Food Tours"},
    {"image": "assets/images/activities/hiking.png", "name": "Hiking"},
    {"image": "assets/images/activities/historical-tours.png", "name": "Historical Tours"},
    {"image": "assets/images/activities/hot-air-ballooning.png", "name": "Hot Air Ballooning"},
    {"image": "assets/images/activities/kayaking.png", "name": "Kayaking"},
    {"image": "assets/images/activities/photography.png", "name": "Photography"},
    {"image": "assets/images/activities/rock-climbing.png", "name": "Rock Climbing"},
    {"image": "assets/images/activities/scuba-diving.png", "name": "Scuba Diving"},
    {"image": "assets/images/activities/surfing.png", "name": "Surfing"},
    {"image": "assets/images/activities/tea-plantation-tours.png", "name": "Tea Plantation Tours"},
    {"image": "assets/images/activities/temple-visits.png", "name": "Temple Visits"},
    {"image": "assets/images/activities/trekking.png", "name": "Trekking"},
    {"image": "assets/images/activities/village-tours.png", "name": "Village Tours"},
    {"image": "assets/images/activities/waterfall-visits.png", "name": "Waterfall Visits"},
    {"image": "assets/images/activities/whale-watching.png", "name": "Whale Watching"},
    {"image": "assets/images/activities/wildlife-safari.png", "name": "Wildlife Safari"},
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
                          color: Kcolours.white,
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
                                  Container(
                                    width: 60, // Set width of the container
                                    height: 60, // Set height of the container
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(activity["image"]!),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    alignment: Alignment.center,
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    activity["name"]!,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 16, color: Kcolours.black),
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
                                  color: Kcolours.primary,
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
