// lib/components/places_card1.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wandr/pages/home/home_destination_profile_screen.dart';

class PlacesCard1 extends StatefulWidget {
  final String title;
  final String location;
  final String? image;
  final bool isLiked;
  final VoidCallback? onTap;

  const PlacesCard1({
    Key? key,
    required this.title,
    required this.location,
    this.image, // Nullable image
    this.isLiked = false,
    this.onTap,
  }) : super(key: key);

  @override
  _PlacesCard1State createState() => _PlacesCard1State();
}

class _PlacesCard1State extends State<PlacesCard1> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.isLiked;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: 120,
        height: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.black,
        ),
        child: Stack(
          children: [
            // Use NetworkImage for remote images
            widget.image != null && widget.image!.isNotEmpty
                ? ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                widget.image!,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                          (loadingProgress.expectedTotalBytes ?? 1)
                          : null,
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade800,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.broken_image,
                        size: 40,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  );
                },
              ),
            )
                : Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade800,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Icon(
                  Icons.image,
                  size: 40,
                  color: Colors.grey.shade500,
                ),
              ),
            ),

            // Favorite icon overlay
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

            // Title and location overlay
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
                  SizedBox(height: 2), // Spacing between title and location
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

