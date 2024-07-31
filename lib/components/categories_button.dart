import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wandr/theme/app_colors.dart';

class CategoriesButton extends StatelessWidget {
  final String title;
  final String? image;
  final VoidCallback onPressed;
  final bool isSelected;

  const CategoriesButton({
    Key? key,
    required this.title,
    this.image,
    required this.onPressed,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8), // Matching curvature as the search bar
        border: Border.all(
          color: isSelected ? Kcolours.primary : Kcolours.greyShade1!, // Highlighted color when selected
          width: isSelected ? 2 : 1, // Border width
        ),
      ),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (image != null)
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
                child: Image.asset(
                  image!,
                  width: 40, // Smaller image size
                  height: 40, // Smaller image size
                  fit: BoxFit.cover,
                ),
              ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: image != null ? 8.0 : 16.0),
              child: Text(
                title,
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
