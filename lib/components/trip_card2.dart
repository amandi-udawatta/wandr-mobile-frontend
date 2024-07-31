// lib/components/trip_card2.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wandr/pages/trip/finalized_trip_page.dart';
import 'package:wandr/theme/app_colors.dart';

class TripCard2 extends StatelessWidget {
  final String title;
  final String created_on;
  final VoidCallback onTap;

  const TripCard2({
    Key? key,
    required this.title,
    required this.created_on,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        height: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          border: Border.all(
            color: Kcolours.primary,
            width: 2, // Adjust the width as needed
          ), // Set the background color to grey
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 50), // Add padding to increase the gap
              child: Center(
                child: Icon(
                  Icons.image,
                  size: 60,
                  color: Colors.grey[300],
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 10,
              right: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: Kcolours.black, // Change text color to black
                    ),
                    maxLines: 1, // Ensure title stays on one line
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 2), // Reduced space between title and created_on
                  Text(
                    "Created on $created_on",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400,
                      fontSize: 10,
                      color: Kcolours.black, // Change text color to black
                    ),
                    maxLines: 1, // Ensure created_on stays on one line
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
