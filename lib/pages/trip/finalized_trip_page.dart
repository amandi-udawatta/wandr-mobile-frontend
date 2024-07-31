// lib/pages/trip/finalized_trip_page.dart

import 'package:flutter/material.dart';
import 'package:wandr/components/bottom_nav_bar.dart';
import 'package:wandr/theme/app_colors.dart';

class FinalizedTripPage extends StatelessWidget {
  final String title;
  final String createdOn;

  const FinalizedTripPage({
    Key? key,
    required this.title,
    required this.createdOn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Mockup data for finalized trip destinations
    final List<String> destinations = [
      "Mihintale Rock",
      "Ruwanwelisaya Stupa",
      "Wilpattu National Park",
      "Kalu Diya Pokuna",
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            size: 30,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(color: Kcolours.black),
            ),
            Text(
              "Created on $createdOn",
              style: TextStyle(
                fontSize: 12,
                color: Kcolours.greyShade1,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                "Your Final Destination List",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Kcolours.primary
                ),
              ),
            ),
            SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: destinations.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.grey[200],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    title: Text(destinations[index]),
                  ),
                );
              },
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                "Your Preferred Path",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Kcolours.primary
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
