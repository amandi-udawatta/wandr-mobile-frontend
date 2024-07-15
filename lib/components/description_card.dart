import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wandr/theme/app_colors.dart';

class DescriptionCard extends StatefulWidget {
  final String title;
  final String location;
  final String image;

  const DescriptionCard({
    Key? key,
    required this.title,
    required this.location,
    required this.image,
  }) : super(key: key);

  @override
  _DescriptionCardState createState() => _DescriptionCardState();
}

class _DescriptionCardState extends State<DescriptionCard> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 3,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(widget.image),
          fit: BoxFit.cover,
          opacity: 0.9,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 10,
            right: 10,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isFavorite = !isFavorite;
                });
              },
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.favorite,
                  color: isFavorite ? Colors.redAccent : Kcolours.white,
                  size: 24,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 20,  // Added left padding
            right: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                    color: Colors.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 16,
                      color: Kcolours.white,
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        widget.location,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: Kcolours.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: 10,
            left: 10,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                color: Kcolours.white,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
