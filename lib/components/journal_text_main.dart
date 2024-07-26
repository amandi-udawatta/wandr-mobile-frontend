import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class JournalTextMain extends StatelessWidget {
  final String full_trip_title;
  final String full_trip_description;
  final String? full_trip_image; 

  const JournalTextMain({
    Key? key,
    required this.full_trip_title,
    required this.full_trip_description,
    this.full_trip_image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            full_trip_title,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          // Remove the SizedBox between title and text
          Text(
            full_trip_description,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
          if (full_trip_image != null) ...[
            SizedBox(height: 12), // This space is between text and image, if needed
            Image.asset(
              full_trip_image!,
              fit: BoxFit.cover,
            ),
          ],
        ],
      ),
    );
  }
}
