import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class JournalText extends StatelessWidget {
  final String trip_place_name;
  final String trip_place_description;
  final String? trip_place_image; 

  const JournalText({
    Key? key,
    required this.trip_place_name,
    required this.trip_place_description,
    this.trip_place_image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            trip_place_name,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          // Remove the SizedBox between title and text
          Text(
            trip_place_description,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
          if (trip_place_image != null) ...[
            SizedBox(height: 12), // This space is between text and image, if needed
            Image.asset(
              trip_place_image!,
              fit: BoxFit.cover,
            ),
          ],
        ],
      ),
    );
  }
}
