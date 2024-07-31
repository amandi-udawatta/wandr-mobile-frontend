import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wandr/pages/home/home_destination_profile_screen.dart';

class PlacesCard1 extends StatefulWidget {
  final String title;
  final String location;
  final String? image; // Make image nullable
  final bool isLiked; // New field to indicate if the place is liked

  const PlacesCard1({
    Key? key,
    required this.title,
    required this.location,
    this.image, // Allow image to be nullable
    this.isLiked = false, // Default value for isLiked
  }) : super(key: key);

  @override
  _PlacesCard1State createState() => _PlacesCard1State();
}

class _PlacesCard1State extends State<PlacesCard1> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.isLiked; // Initialize isFavorite based on isLiked
  }

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
        width: 120,
        height: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.black,
          image: widget.image != null && widget.image!.isNotEmpty
              ? DecorationImage(
                  fit: BoxFit.cover,
                  opacity: 0.9,
                  image: AssetImage(widget.image!),
                )
              : null, // No image decoration if image is null or empty
        ),
        child: Stack(
          children: [
            if (widget.image == null || widget.image!.isEmpty)
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey.shade800, // Placeholder background color
                ),
                child: Center(
                  child: Icon(
                    Icons.image,
                    size: 40,
                    color: Colors.grey.shade500, // Placeholder icon color
                  ),
                ),
              ),
            Positioned(
              top: 10,
              right: 10,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isFavorite = !isFavorite;
                  });
                },
                child: Icon(
                  Icons.favorite,
                  color: isFavorite ? Colors.redAccent : Colors.white,
                  size: 24,
                ),
              ),
            ),
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
                  SizedBox(
                      height: 2), // Reduced space between title and location
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 16,
                        color: Colors.white,
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          widget.location,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            fontSize: 10,
                            color: Colors.white,
                          ),
                          maxLines: 1, // Ensure location stays on one line
                          overflow: TextOverflow.ellipsis,
                        ),
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