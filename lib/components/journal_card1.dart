import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wandr/theme/app_colors.dart';

class JournalCard1 extends StatefulWidget {
  final String title;
  final String image;

  const JournalCard1({
    Key? key,
    required this.title,
    required this.image,
  }) : super(key: key);

  @override
  _JournalCard1State createState() => _JournalCard1State();
}

class _JournalCard1State extends State<JournalCard1> {
  bool isSelected = false; // Track selection state

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected; // Toggle selection state
        });
      },
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.black,
          border: Border.all(
            color: isSelected ? Kcolours.primary : Colors.transparent, // Highlighted color when selected
            width: isSelected ? 4 : 0, // Border width when selected
          ),
          image: DecorationImage(
            fit: BoxFit.cover,
            opacity: 0.9,
            image: AssetImage(widget.image),
          ),
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
                    widget.title,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: Colors.white,
                    ),
                    maxLines: 1, // Ensure title stays on one line
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 2), // Reduced space between title and location
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
