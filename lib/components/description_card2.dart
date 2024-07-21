import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wandr/theme/app_colors.dart';

class DescriptionCard2 extends StatefulWidget {
  final String title;
  final String image;

  const DescriptionCard2({
    Key? key,
    required this.title,
    required this.image,
  }) : super(key: key);

  @override
  _DescriptionCard2State createState() => _DescriptionCard2State();
}

class _DescriptionCard2State extends State<DescriptionCard2> {
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
