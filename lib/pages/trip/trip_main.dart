import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wandr/theme/app_colors.dart';

import 'package:wandr/components/bottom_nav_bar.dart';
import 'package:wandr/components/add_button.dart';

class TripScreen extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Column(
              children: [
                SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    "Where do you want to travel today?",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w800,
                      fontSize: 22,
                      color: Kcolours.primary,
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 20,
              right: 5,
              child: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: AddButton(
                  onTap: () {
                    // Add functionality for the AddButton here
                  },
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavBar(),
      ),
    );
  }
}
