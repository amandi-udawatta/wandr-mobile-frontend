import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wandr/theme/app_colors.dart'; // Assuming you have this import for your custom colors

class ProfilePremiumPopup extends StatelessWidget {
  const ProfilePremiumPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: AssetImage('assets/images/profile/Profile_popup.png'), // Replace with the actual path to your background image
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0), // Add a semi-transparent overlay for better readability
            borderRadius: BorderRadius.circular(16),
          ),
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Crown image at the top middle
                  Image.asset(
                    'assets/images/profile/crown.png', // Replace with the actual path to your crown image
                    height: 50,
                  ),
                  SizedBox(height: 16),
                  // Upgrade to Premium text
                  Text(
                    'UPGRADE TO PREMIUM',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Kcolours.black, // Ensure the text is readable on the background
                    ),
                  ),
                  SizedBox(height: 16),
                  // Additional text for upgrade notice
                  Text(
                    'Please upgrade to PREMIUM to access all the features:',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600, // Make the text less bold
                      color: Kcolours.brownShade3, // Ensure the text is readable on the background
                    ),
                  ),
                  SizedBox(height: 16),
                  // List of features with icons
                  Row(
                    children: [
                      Icon(Icons.location_on, color: Kcolours.primary),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Better travel recommendations',
                          style: GoogleFonts.poppins(fontSize: 14, color: Kcolours.brownShade2),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.edit, color: Kcolours.primary),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'More journaling tools',
                          style: GoogleFonts.poppins(fontSize: 14, color: Kcolours.brownShade2),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.card_giftcard, color: Kcolours.primary),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Promotions in the online store',
                          style: GoogleFonts.poppins(fontSize: 14, color: Kcolours.brownShade2),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 18),

                  // Unlock Premium button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Kcolours.greenShade1, // Set button color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                    ),
                    onPressed: () {
                      // Handle button press
                    },
                    child: Text(
                      'Unlock Premium for Rs. 5000.00',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.white, // Set text color to white
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
              // Close button (cross mark) at the top right corner
              Positioned(
                right: -10,  // Move to the right
                top: -10,    // Move up
                child: IconButton(
                  icon: Icon(Icons.close, color: Kcolours.black),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
