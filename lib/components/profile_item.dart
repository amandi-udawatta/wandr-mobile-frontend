import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wandr/theme/app_colors.dart';

class ProfileItem extends StatelessWidget {
  final String title;
  final String image;

  const ProfileItem({
    Key? key,
    required this.title,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
       width: 100,
        height: 140,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
          opacity: 0.9,
        ),
        borderRadius: BorderRadius.circular(12), // Rounded edges for the container
      ),
      child: Stack(
        children: [
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
                      color: Colors.white,
                    ),
                    maxLines: 1, // Ensure title stays on one line
                    overflow: TextOverflow.ellipsis,
                  ),
                SizedBox(height: 2),
                // Removed location row
              ],
            ),
          ),
        ],
      ),
    );
  }
}
