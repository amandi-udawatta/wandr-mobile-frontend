// lib/pages/signup/pref_destinations_page.dart

import 'package:flutter/material.dart';
import 'package:wandr/config.dart';

import 'package:wandr/components/primary_button.dart';
import 'package:wandr/pages/signup/pref_activities_page.dart';
import 'package:wandr/theme/app_colors.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../config.dart';
import '../../data.dart'; // Import the data file

class PrefDestinationsPage extends StatefulWidget {
  const PrefDestinationsPage({super.key});

  @override
  _PrefDestinationsPageState createState() => _PrefDestinationsPageState();
}

class _PrefDestinationsPageState extends State<PrefDestinationsPage> {
  // List to keep track of selected destinations
  final List<bool> selectedDestinations = List<bool>.filled(destinations.length, false);
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
      final userId = decodedToken['id']; // Assuming the user ID is stored in the 'id' claim
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
