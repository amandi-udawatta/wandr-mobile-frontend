import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ServiceCard extends StatefulWidget {
  final String title;
  final String store;
  final String? image; // Make image nullable
  final bool isLiked; // New field to indicate if the place is liked
  final double rating; // New field for rating
  final VoidCallback? onTap; // Add onTap callback

  const ServiceCard({
    Key? key,
    required this.title,
    required this.store,
    this.image, // Allow image to be nullable
    this.isLiked = false, // Default value for isLiked
    required this.rating, // Initialize rating
    this.onTap, // Initialize onTap
  }) : super(key: key);

  @override
  _ServiceCardState createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.isLiked; // Initialize isFavorite based on isLiked
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
                  Row(
                    children: [
                      Text(
                        widget.store,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 10,
                          color: Colors.white,
                        ),
                        maxLines: 1, // Ensure store stays on one line
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        size: 16,
                        color: Color.fromARGB(255, 219, 199, 19),
                      ),
                      SizedBox(width: 5),
                      Text(
                        widget.rating.toString(),
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 10,
                          color: Colors.white,
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
