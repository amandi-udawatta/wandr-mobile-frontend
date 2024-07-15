import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ActivityButton extends StatelessWidget {
  final String title;
  final String image;

  const ActivityButton({
    Key? key,
    required this.title,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8), // Matching curvature as the search bar
        border: Border.all(
          color: Colors.grey, // Example border color
          width: 1, // Example border width
        ),
      ),
      child: TextButton(
        onPressed: null, // No onPressed callback provided
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                image,
                width: 60, // Reduced image size
                height: 60, // Reduced image size
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 4), // Reduced space between image and title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500, // Matching font weight as others
                  color: Colors.black, // Set text color to black
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
