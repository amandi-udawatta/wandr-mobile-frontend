import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wandr/theme/app_colors.dart';

import 'package:wandr/pages/trip/trip_journal.dart'; // Import the JournalScreen

class JournalCard2 extends StatefulWidget {
  final String title;
  final String created_on;
  final String image;

  const JournalCard2({
    Key? key,
    required this.title,
    required this.created_on,
    required this.image,
  }) : super(key: key);

  @override
  _JournalCard2State createState() => _JournalCard2State();
}

class _JournalCard2State extends State<JournalCard2> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => JournalScreen(
              title: widget.title,
              createdOn: widget.created_on,
              image: widget.image,
            ),
          ),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 2.5, // Adjusted height
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16), // Added border radius
          image: DecorationImage(
            image: AssetImage(widget.image),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.4),
              BlendMode.srcOver,
            ),
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: 16,
              left: 20, // Added left padding
              right: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Text(
                    widget.created_on,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Kcolours.white,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
