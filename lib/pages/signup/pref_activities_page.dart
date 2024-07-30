import 'package:flutter/material.dart';
import 'package:wandr/components/primary_button.dart';
import 'package:wandr/config.dart';
import 'package:wandr/pages/home/home_dashboard_screen.dart';
import 'package:wandr/theme/app_colors.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PrefActivitiesPage extends StatefulWidget {
  const PrefActivitiesPage({super.key});

  @override
  _PrefActivitiesPageState createState() => _PrefActivitiesPageState();
}

class _PrefActivitiesPageState extends State<PrefActivitiesPage> {
  // List of activities with their image paths, names, and IDs
  final List<Map<String, dynamic>> activities = [
    {"id": 1, "image": "assets/images/activities/hiking.png", "name": "Hiking"},
    {"id": 2, "image": "assets/images/activities/surfing.png", "name": "Surfing"},
    {"id": 3, "image": "assets/images/activities/scuba-diving.png", "name": "Scuba Diving"},
    {"id": 4, "image": "assets/images/activities/wildlife-safari.png", "name": "Wildlife Safari"},
    {"id": 5, "image": "assets/images/activities/bird-watching.png", "name": "Bird Watching"},
    {"id": 6, "image": "assets/images/activities/cultural-tours.png", "name": "Cultural Tours"},
    {"id": 7, "image": "assets/images/activities/historical-tours.png", "name": "Historical Tours"},
    {"id": 8, "image": "assets/images/activities/temple-visits.png", "name": "Temple Visits"},
    {"id": 9, "image": "assets/images/activities/waterfall-visits.png", "name": "Waterfall Visits"},
    {"id": 10, "image": "assets/images/activities/whale-watching.png", "name": "Whale Watching"},
    {"id": 11, "image": "assets/images/activities/fishing.png", "name": "Fishing"},
    {"id": 12, "image": "assets/images/activities/camping.png", "name": "Camping"},
    {"id": 13, "image": "assets/images/activities/rock-climbing.png", "name": "Rock Climbing"},
    {"id": 14, "image": "assets/images/activities/cycling.png", "name": "Cycling"},
    {"id": 15, "image": "assets/images/activities/kayaking.png", "name": "Kayaking"},
    {"id": 16, "image": "assets/images/activities/canoeing.png", "name": "Canoeing"},
    {"id": 17, "image": "assets/images/activities/boating.png", "name": "Boating"},
    {"id": 18, "image": "assets/images/activities/hot-air-ballooning.png", "name": "Hot Air Ballooning"},
    {"id": 19, "image": "assets/images/activities/tea-plantation-tours.png", "name": "Tea Plantation Tours"},
    {"id": 20, "image": "assets/images/activities/elephant-rides.png", "name": "Elephant Rides"},
    {"id": 21, "image": "assets/images/activities/village-tours.png", "name": "Village Tours"},
    {"id": 22, "image": "assets/images/activities/food-tours.png", "name": "Food Tours"},
    {"id": 23, "image": "assets/images/activities/trekking.png", "name": "Trekking"},
    {"id": 24, "image": "assets/images/activities/photography.png", "name": "Photography"},
    {"id": 25, "image": "assets/images/activities/caving.png", "name": "Caving"},
  ];

  // List to keep track of selected activities
  final List<bool> selectedActivities = List<bool>.filled(25, false);

  final storage = FlutterSecureStorage();

  Future<void> submitSelectedActivities(List<int> selectedActivityIds) async {
    String? token = await storage.read(key: 'accessToken');
    if (token != null) {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      final userId = decodedToken['id']; // Ensure your token has 'id' claim
      final url = Uri.parse('$baseUrl/forward/traveller/$userId/activities');

      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token,
        },
        body: json.encode({
          'activities': selectedActivityIds,
        }),
      );

      if (response.statusCode == 200) {
        print('Activities updated successfully');
      } else {
        print('Failed to update activities with status: ${response.statusCode}');
      }
    } else {
      print('Token not found');
    }
  }

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
                          if (selectedActivities.where((selected) => selected).length < 5 || isSelected) {
                            selectedActivities[index] = !isSelected;
                          }
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Kcolours.white,
                          borderRadius: BorderRadius.circular(15),
                          border: isSelected
                              ? Border.all(color: Kcolours.primary, width: 3)
                              : null,
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
                                    style: TextStyle(
                                        fontSize: 16, color: Kcolours.black),
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
                  final selectedActivityIds = activities
                      .asMap()
                      .entries
                      .where((entry) => selectedActivities[entry.key])
                      .map((entry) => entry.value['id'] as int)
                      .toList();

                  if (selectedActivityIds.isEmpty) {
                    _showError(context, 'Please select at least one activity.');
                  } else {
                    submitSelectedActivities(selectedActivityIds);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DashboardScreen()),
                    );
                  }
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

  void _showError(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
