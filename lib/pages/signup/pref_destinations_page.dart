import 'package:flutter/material.dart';
import 'package:wandr/components/primary_button.dart';
import 'package:wandr/pages/signup/pref_activities_page.dart';
import 'package:wandr/theme/app_colors.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../config.dart';

class PrefDestinationsPage extends StatefulWidget {
  const PrefDestinationsPage({super.key});

  @override
  _PrefDestinationsPageState createState() => _PrefDestinationsPageState();
}

class _PrefDestinationsPageState extends State<PrefDestinationsPage> {
  // List of destinations with their image paths, names, and IDs
  final List<Map<String, dynamic>> destinations = [
    {"id": 1, "image": "assets/images/categories/mountain.png", "name": "Mountain"},
    {"id": 2, "image": "assets/images/categories/beach.png", "name": "Beach"},
    {"id": 3, "image": "assets/images/categories/national-park.png", "name": "National Park"},
    {"id": 4, "image": "assets/images/categories/historical-site.png", "name": "Historic Site"},
    {"id": 5, "image": "assets/images/categories/museum.png", "name": "Museum"},
    {"id": 6, "image": "assets/images/categories/art-gallery.png", "name": "Art Gallery"},
    {"id": 7, "image": "assets/images/categories/temple.png", "name": "Temple"},
    {"id": 8, "image": "assets/images/categories/church.png", "name": "Church"},
    {"id": 9, "image": "assets/images/categories/monument.png", "name": "Monument"},
    {"id": 10, "image": "assets/images/categories/archaeological-site.png", "name": "Archaeological Site"},
    {"id": 11, "image": "assets/images/categories/waterfall.png", "name": "Waterfall"},
    {"id": 12, "image": "assets/images/categories/lake.png", "name": "Lake"},
    {"id": 13, "image": "assets/images/categories/river.png", "name": "River"},
    {"id": 14, "image": "assets/images/categories/zoo.png", "name": "Zoo"},
    {"id": 15, "image": "assets/images/categories/botanical-garden.png", "name": "Botanical Garden"},
    {"id": 16, "image": "assets/images/categories/theme-park.png", "name": "Theme Park"},
    {"id": 17, "image": "assets/images/categories/wildlife-sanctuary.png", "name": "Wildlife Sanctuary"},
    {"id": 18, "image": "assets/images/categories/scenic-viewpoint.png", "name": "Scenic Viewpoint"},
    {"id": 19, "image": "assets/images/categories/village.png", "name": "Village"},
    {"id": 20, "image": "assets/images/categories/city.png", "name": "City"},
    {"id": 21, "image": "assets/images/categories/neighborhood.png", "name": "Neighborhood"},
    {"id": 22, "image": "assets/images/categories/market.png", "name": "Market"},
    {"id": 23, "image": "assets/images/categories/shopping-mall.png", "name": "Shopping Mall"},
    {"id": 24, "image": "assets/images/categories/library.png", "name": "Library"},
    {"id": 25, "image": "assets/images/categories/university.png", "name": "University"},
    {"id": 26, "image": "assets/images/categories/cave.png", "name": "Cave"},
    {"id": 27, "image": "assets/images/categories/fortress.png", "name": "Fortress"},
    {"id": 28, "image": "assets/images/categories/lighthouse.png", "name": "Lighthouse"},
    {"id": 29, "image": "assets/images/categories/aquarium.png", "name": "Aquarium"},
    {"id": 30, "image": "assets/images/categories/cultural-landmark.png", "name": "Cultural Landmark"},
    {"id": 31, "image": "assets/images/categories/rock.png", "name": "Rock"},
    {"id": 32, "image": "assets/images/categories/coral-reef.png", "name": "Coral Reef"},
    {"id": 33, "image": "assets/images/categories/tea-plantation.png", "name": "Tea Plantation"},
    {"id": 34, "image": "assets/images/categories/forest.png", "name": "Forest"},
  ];

  // List to keep track of selected destinations
  final List<bool> selectedDestinations = List<bool>.filled(34, false);
  final storage = FlutterSecureStorage();

  Future<void> submitSelectedCategories(List<int> selectedCategoryIds) async {
    // Retrieve token from secure storage
    final token = await storage.read(key: 'accessToken');
    if (token == null) {
      _showError(context, 'Token not found. Please login again.');
      return;
    }

    try {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      print(decodedToken);
      final userId = decodedToken['id']; // Assuming the user ID is stored in the 'sub' claim
      print(userId);
      final url = Uri.parse('$baseUrl/forward/traveller/$userId/categories');

      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token,
        },
        body: json.encode({
          'categories': selectedCategoryIds,
        }),
      );

      if (response.statusCode == 200) {
        print('Categories updated successfully');
      } else {
        print('Failed to update categories with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Invalid token: $e');
      _showError(context, 'Invalid token. Please login again.');
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
                          if (selectedDestinations.where((selected) => selected).length < 10 || isSelected) {
                            selectedDestinations[index] = !isSelected;
                          }
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
                                  Container(
                                    width: 60, // Set width of the container
                                    height: 60, // Set height of the container
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(destination["image"]!),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
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
                  final selectedCategoryIds = destinations
                      .asMap()
                      .entries
                      .where((entry) => selectedDestinations[entry.key])
                      .map((entry) => entry.value['id'] as int)
                      .toList();

                  if (selectedCategoryIds.isEmpty) {
                    _showError(context, 'Please select at least one category.');
                  } else {
                    submitSelectedCategories(selectedCategoryIds);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PrefActivitiesPage(),
                      ),
                    );
                  }
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
