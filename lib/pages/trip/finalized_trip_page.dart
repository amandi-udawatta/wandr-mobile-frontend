// lib/pages/trip/finalized_trip_page.dart

import 'package:flutter/material.dart';
import 'package:wandr/theme/app_colors.dart';

class FinalizedTripPage extends StatelessWidget {
  final String title;
  final String createdOn;
  final List<dynamic> tripPlaces;

  const FinalizedTripPage({
    Key? key,
    required this.title,
    required this.createdOn,
    required this.tripPlaces,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            Navigator.pop(context); // Use pop to go back to the previous screen
          },
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(color: Kcolours.black)),
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
            Expanded(
              child: ListView.builder(
                itemCount: tripPlaces.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.grey[200],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      title: Text(tripPlaces[index]['title']),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
