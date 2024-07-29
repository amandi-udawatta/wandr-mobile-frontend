import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wandr/theme/app_colors.dart';

class SearchBar2 extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;

  const SearchBar2({
    Key? key,
    required this.controller,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1, horizontal: 15), // Reduced padding for the overall box
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 1, horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white, // Set the background color to white
          borderRadius: BorderRadius.circular(12), // Reduced border radius
          border: Border.all(color: Kcolours.greyShade2), // Set the border color to grey
        ),
        child: TextField(
          controller: controller,
          onChanged: onChanged,
          style: GoogleFonts.poppins(
            color: Kcolours.black,
            fontSize: 18, // Increase the font size
          ),
          decoration: InputDecoration(
            hintText: "Search Journal",
            hintStyle: GoogleFonts.poppins(
              color: Kcolours.greyShade1, // Set hint text color
              fontSize: 18, // Increase the hint text font size
            ),
            border: InputBorder.none,
            prefixIcon: Icon(Icons.search, color: Colors.black), // Set icon color
            contentPadding: EdgeInsets.symmetric(vertical: 10), // Adjust vertical padding for alignment
          ),
        ),
      ),
    );
  }
}
