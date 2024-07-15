import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wandr/pages/home/home_destination_profile_screen.dart';

class BlogButton extends StatelessWidget {
  final String title;
  final String location;
  final String image;
  final String image_author;
  final String author;

  const BlogButton({
    Key? key,
    required this.title,
    required this.location,
    required this.image,
    required this.image_author,
    required this.author,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DestinationProfileScreen(),
          ),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 140, // Adjust height as needed
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
              top: 10,
              right: 10,
              child: Container(
                padding: EdgeInsets.all(4),
                child: ClipOval(
                  child: Image.asset(
                    image_author,
                    width: 24,
                    height: 24,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 38,
              right: 10,
              child: Text(
                author,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400,
                  fontSize: 10,
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
              left: 10,
              bottom: 10,
              right: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                    maxLines: 1, // Ensure title stays on one line
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 2),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 16,
                        color: Colors.white,
                      ),
                      SizedBox(width: 5),
                      Text(
                        location,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 10,
                          color: Colors.white,
                        ),
                        maxLines: 1, // Ensure location stays on one line
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
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
