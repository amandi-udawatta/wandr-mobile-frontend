import 'package:flutter/material.dart';
import 'package:wandr/theme/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePic extends StatelessWidget {
  final String background_image;
  final String image;
  final String name;
  final VoidCallback onEdit;

  const ProfilePic({
    Key? key,
    required this.background_image,
    required this.image,
    required this.name,
    required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none, // Ensure content can extend beyond bounds
      children: [
        // Background Image
        Container(
          width: double.infinity,
          height: 150, // Height set to half of the original height
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(background_image),
              fit: BoxFit.cover,
            ),
          ),
        ),
        // Profile Picture and Other Elements
        Positioned(
          top: 70, // Adjust to center the profile picture vertically
          left: 16,
          right: 16,
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none, // Allow child widgets to extend beyond this widget's bounds
                children: [
                  Container(
                    width: 110, // Adjust size as needed
                    height: 110, // Adjust size as needed
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(image),
                        fit: BoxFit.cover,
                      ),
                      border: Border.all(
                        color: Kcolours.primary, // Border color
                        width: 4, // Border width
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -10, // Adjust to move the icon lower
                    right: 40, // Adjust to move the icon left
                    child: Container(
                      width: 30, // Size of the circle (decreased)
                      height: 30, // Size of the circle (decreased)
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black, // Background color
                      ),
                      child: IconButton(
                        icon: Icon(Icons.edit, color: Colors.white),
                        iconSize: 16, // Decreased icon size
                        onPressed: onEdit,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Text(
                name,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: Kcolours.brownShade2, // Adjust color as needed
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
