import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wandr/pages/home/home_filter_screen.dart';

class PlacesCard2 extends StatelessWidget {
  final String title;
  final String location;
  final String image;

  const PlacesCard2({
    super.key,
    required this.title,
    required this.location,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FilterScreen(
            category: "YourCategory", // Replace with actual category
            initialIndex: 0, // Replace with actual index
          ),
        ),
      );
    },
      child: Container(
        width: 200,
        height: 240,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.black,
          image: DecorationImage(
            fit: BoxFit.cover,
            opacity: 0.9,
            image: AssetImage(image),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                      decoration: BoxDecoration(
                        color: Color(0xFF4D5652),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        title,
                        style: GoogleFonts.robotoCondensed(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                      decoration: BoxDecoration(
                        color: Color(0xFF4D5652),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            'assets/vectors/star.svg',
                            width: 20,
                            height: 20,
                          ),
                          SizedBox(width: 5),
                          Text(
                            location,
                            style: GoogleFonts.robotoCondensed(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.favorite,
                    color: Colors.redAccent,
                  ),
                )
              ],
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
