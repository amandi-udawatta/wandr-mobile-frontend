import 'package:flutter/material.dart';
import 'package:wandr/components/primary_button.dart';
import 'package:wandr/config.dart';
import 'package:wandr/pages/home/home_dashboard_screen.dart';
import 'package:wandr/theme/app_colors.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../data.dart'; // Import the data file

class PrefActivitiesPage extends StatefulWidget {
  const PrefActivitiesPage({super.key});

  @override
  _PrefActivitiesPageState createState() => _PrefActivitiesPageState();
}

class _PrefActivitiesPageState extends State<PrefActivitiesPage> with SingleTickerProviderStateMixin {
  // List to keep track of selected activities
  final List<bool> selectedActivities = List<bool>.filled(activities.length, false);
  final storage = FlutterSecureStorage();

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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

  void _showProcessingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            height: 150, // Set the desired height here
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RotatingDiamondLoadingIndicator(controller: _controller),
                SizedBox(height: 20),
                Text(
                  "Fetching the best destinations in Sri Lanka just for you...",
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );

    // Delay for 5 seconds and then navigate to DashboardScreen
    Future.delayed(Duration(seconds: 5), () {
      Navigator.pop(context); // Close the dialog
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DashboardScreen()),
      );
    });
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
                    _showProcessingDialog();
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

class RotatingDiamondLoadingIndicator extends StatelessWidget {
  final AnimationController controller;

  const RotatingDiamondLoadingIndicator({required this.controller});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Transform.rotate(
          angle: controller.value * 6.3, // Rotate the diamond
          child: child,
        );
      },
      child: Container(
        height: 50,
        width: 50,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 20,
              child: CircleAvatar(
                radius: 5,
                backgroundColor: Colors.green,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 20,
              child: CircleAvatar(
                radius: 5,
                backgroundColor: Colors.green,
              ),
            ),
            Positioned(
              left: 0,
              top: 20,
              child: CircleAvatar(
                radius: 5,
                backgroundColor: Colors.green,
              ),
            ),
            Positioned(
              right: 0,
              top: 20,
              child: CircleAvatar(
                radius: 5,
                backgroundColor: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
