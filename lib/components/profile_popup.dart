import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wandr/theme/app_colors.dart';

class ProfilePopup extends StatelessWidget {
  final String backgroundImage;
  final String title;
  final String content;

  const ProfilePopup({
    Key? key,
    required this.backgroundImage,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: IntrinsicHeight(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8, // Adjust width as needed
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Stack(
            children: [
              ColorFiltered(
                colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0), // Adjust the opacity to control brightness
                  BlendMode.lighten,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(backgroundImage),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              Positioned.fill(
                child: Container(
                  color: Colors.black.withOpacity(0), // Slight overlay to make text more readable
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 16), // Space before the title
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Kcolours.brownShade4,
                      ),
                    ),
                    SizedBox(height: 16),
                    Flexible(
                      child: SingleChildScrollView(
                        child: Text(
                          content,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Kcolours.brownShade2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 0,  // Move to the right
                top: 0,    // Move up
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
