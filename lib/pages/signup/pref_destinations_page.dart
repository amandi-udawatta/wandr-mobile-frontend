import 'package:flutter/material.dart';
import 'package:wandr/components/primary_button.dart';
import 'package:wandr/pages/signup/pref_activities_page.dart';
import 'package:wandr/theme/app_colors.dart';

class PrefDestinationsPage extends StatefulWidget {
  const PrefDestinationsPage({super.key});

  @override
  _PrefDestinationsPageState createState() => _PrefDestinationsPageState();
}

class _PrefDestinationsPageState extends State<PrefDestinationsPage> {
  // List of destinations with their image paths and names
  final List<Map<String, String>> destinations = [
    {"image": "assets/images/categories/aquarium.png", "name": "Aquarium"},
    {"image": "assets/images/categories/archaeological-site.png", "name": "Archaeological Site"},
    {"image": "assets/images/categories/art-gallery.png", "name": "Art Gallery"},
    {"image": "assets/images/categories/beach.png", "name": "Beach"},
    {"image": "assets/images/categories/botanical-garden.png", "name": "Botanical Garden"},
    {"image": "assets/images/categories/cave.png", "name": "Cave"},
    {"image": "assets/images/categories/church.png", "name": "Church"},
    {"image": "assets/images/categories/city.png", "name": "City"},
    {"image": "assets/images/categories/cultural-landmark.png", "name": "Cultural Landmark"},
    {"image": "assets/images/categories/fortress.png", "name": "Fortress"},
    {"image": "assets/images/categories/historical-site.png", "name": "Historical Site"},
    {"image": "assets/images/categories/lake.png", "name": "Lake"},
    {"image": "assets/images/categories/library.png", "name": "Library"},
    {"image": "assets/images/categories/lighthouse.png", "name": "Lighthouse"},
    {"image": "assets/images/categories/market.png", "name": "Market"},
    {"image": "assets/images/categories/monument.png", "name": "Monument"},
    {"image": "assets/images/categories/mountain.png", "name": "Mountain"},
    {"image": "assets/images/categories/museum.png", "name": "Museum"},
    {"image": "assets/images/categories/national-park.png", "name": "National Park"},
    {"image": "assets/images/categories/neighborhood.png", "name": "Neighborhood"},
    {"image": "assets/images/categories/river.png", "name": "River"},
    {"image": "assets/images/categories/scenic-viewpoint.png", "name": "Scenic Viewpoint"},
    {"image": "assets/images/categories/shopping-mall.png", "name": "Shopping Mall"},
    {"image": "assets/images/categories/temple.png", "name": "Temple"},
    {"image": "assets/images/categories/theme-park.png", "name": "Theme Park"},
    {"image": "assets/images/categories/university.png", "name": "University"},
    {"image": "assets/images/categories/village.png", "name": "Village"},
    {"image": "assets/images/categories/waterfall.png", "name": "Waterfall"},
    {"image": "assets/images/categories/wildlife-sanctuary.png", "name": "Wildlife Sanctuary"},
    {"image": "assets/images/categories/zoo.png", "name": "Zoo"},
  ];

  // List to keep track of selected destinations
  final List<bool> selectedDestinations = List<bool>.filled(30, false);

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
                  'Pick Your Favorite Destinations',
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
                  'Tell us about your preferred places to visit. This will help us tailor your travel recommendations to match your interests.',
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

              // Grid selection of destinations
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
                  itemCount: destinations.length,
                  itemBuilder: (context, index) {
                    final destination = destinations[index];
                    final isSelected = selectedDestinations[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedDestinations[index] = !isSelected;
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
                                    destination["image"]!,
                                    height: 60,
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    destination["name"]!,
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
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PrefActivitiesPage(),
                    ),
                  );
                },
                text: "Proceed",
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
