import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class JournalText extends StatelessWidget {
  final String title;
  final String text;
  final String? image; // Make image optional

  const JournalText({
    Key? key,
    required this.title,
    required this.text,
    this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          // Remove the SizedBox between title and text
          Text(
            text,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
          if (image != null) ...[
            SizedBox(height: 12), // This space is between text and image, if needed
            Image.asset(
              image!,
              fit: BoxFit.cover,
            ),
          ],
        ],
      ),
    );
  }
}
