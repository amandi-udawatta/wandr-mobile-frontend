import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wandr/theme/app_colors.dart';

class ShopChip extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onPressed;

  const ShopChip({
    Key? key,
    required this.title,
    required this.isSelected,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: isSelected ? Kcolours.primary : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Kcolours.primary : Kcolours.greyShade1!,
            width: 1.5,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Kcolours.primary.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ]
              : [],
        ),
        child: Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
