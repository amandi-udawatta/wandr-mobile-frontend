import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wandr/theme/app_colors.dart';

class ProfileOther extends StatelessWidget {
  final String icon;
  final String title;
  final VoidCallback onTap;

  const ProfileOther({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Define a map to associate titles with icons
    final Map<String, IconData> iconMap = {
      'Privacy': Icons.lock,
      'Terms and Conditions': Icons.description,
      'Cancel the Plan': Icons.cancel,
    };

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Container(
        height: 50, // Reduced height
        decoration: BoxDecoration(
          color: Colors.grey[200], // Box color
          borderRadius: BorderRadius.circular(16), // Increased curvature
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: Row(
            children: [
              Icon(
                iconMap[title] ?? Icons.info, // Default icon if title not in map
                color: Kcolours.greyShade1,
                size: 24,
              ),
              SizedBox(width: 10), // Reduced space between icon and text
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center, // Center align text vertically
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                        color: Kcolours.black, // Adjust color as needed
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(Icons.arrow_forward, color: Kcolours.black),
                iconSize: 20, // Reduced icon size
                onPressed: onTap,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

