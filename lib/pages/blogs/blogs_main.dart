import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wandr/theme/app_colors.dart';

import 'package:wandr/components/search_bar2.dart' as custom;
import 'package:wandr/components/bottom_nav_bar.dart';
import 'package:wandr/components/journal_card1.dart';
import 'package:wandr/components/journal_card2.dart';
import 'package:wandr/components/add_button.dart';

class BlogScreen extends StatelessWidget {
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
                    "What do you want to journal today?",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w800,
                      fontSize: 22,
                      color: Kcolours.primary,
                    ),
                  ),
                ),
                SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        JournalCard1(
                          title: "My Honeymoon",
                          image: "assets/images/trip/Trip - Sigiriya.png",
                        ),
                        SizedBox(width: 16),
                        JournalCard1(
                          title: "21st Trip",
                          image: "assets/images/trip/Trip - Arugam Bay.png",
                        ),
                        SizedBox(width: 16),
                        JournalCard1(
                          title: "Trip arounnd SL",
                          image: "assets/images/trip/Trip - Horton Plains.png",
                        ),
                        SizedBox(width: 16),
                        JournalCard1(
                          title: "New year week",
                          image: "assets/images/trip/Trip - Kithulgala.png",
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 25),
                custom.SearchBar2(
                  controller: _searchController,
                  onChanged: (query) {
                    // Handle search query change if needed
                  },
                ),
                SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: JournalCard2(
                    trip_title: "My trip around Sri Lanka",
                    created_on: "created on 12th June 2024",
                    trip_image: "assets/images/trip/Trip - Arugam Bay.png",
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
