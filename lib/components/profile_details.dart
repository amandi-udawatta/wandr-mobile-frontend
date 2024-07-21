import 'package:flutter/material.dart';
import 'package:wandr/theme/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class PersonalDetails extends StatelessWidget {
  final String icon;
  final String title;
  final String text;

  const PersonalDetails({
    Key? key,
    required this.icon,
    required this.title,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Define a map to associate titles with icons
    final Map<String, IconData> iconMap = {
      'Email Address': Icons.email,
      'Contact Number': Icons.phone,
      'Date of Birth': Icons.calendar_today,
      'Gender': Icons.person,
      'Favourite Destinations in Sri Lanka': Icons.location_on,
      'Favourite Activities to do in Sri Lanka': Icons.directions_run,
      // Add more titles and icons as needed
    };

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0), // Reduced vertical padding
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200], // Box color
          borderRadius: BorderRadius.circular(16), // Increased curvature
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0), // Further reduced padding
          child: Row(
            children: [
              Icon(
                iconMap[title] ?? Icons.info, // Default icon if title not in map
                color: Kcolours.greyShade1,
                size: 24,
              ),
              SizedBox(width: 14), // Reduced space between icon and text
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: 11,
                        color: Kcolours.greyShade1, // Adjust color as needed
                      ),
                    ),
                    Text(
                      text,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                        color: Kcolours.black, // Adjust color as needed
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
