import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wandr/pages/trip/finalized_trip_screen.dart';

class TripCard2 extends StatelessWidget {
  final String title;
  final String created_on;
  final String image;

  const TripCard2({
    Key? key,
    required this.title,
    required this.created_on,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FinalizedTripScreen(),
          ),
        );
      },
      child: Container(
        width: 120,
        height: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.black,
          image: DecorationImage(
            fit: BoxFit.cover,
            opacity: 0.9,
            image: AssetImage(image),
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
                    title,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: Colors.white,
                    ),
                    maxLines: 1, // Ensure title stays on one line
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 2), // Reduced space between title and created_on
                  Text(
                    created_on,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400,
                      fontSize: 10,
                      color: Colors.white,
                    ),
                    maxLines: 1, // Ensure created_on stays on one line
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
