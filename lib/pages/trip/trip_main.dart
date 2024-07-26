import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wandr/theme/app_colors.dart';

import 'package:wandr/components/search_bar.dart' as custom;
import 'package:wandr/pages/home/home_filter_screen.dart';
import 'package:wandr/components/bottom_nav_bar.dart';
import 'package:wandr/components/journal_card1.dart';
import 'package:wandr/components/journal_card2.dart';
import 'package:wandr/components/add_button.dart';

class TripScreen extends StatefulWidget {
  const TripScreen({Key? key}) : super(key: key);

  @override
  State<TripScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<TripScreen> {
  int _selectedIndex = 1;
  final TextEditingController _searchController = TextEditingController();
  int _selectedCategoryIndex = -1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onSearchChanged(String query) {
    // Handle search query change
  }

  void _onCategorySelected(int index) {
    setState(() {
      _selectedCategoryIndex = index;
    });

    // Navigate to FilterScreen for Beach category
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FilterScreen(category: "Beach", initialIndex: 0),
        ),
      );
    }
    // You can add more cases for other categories if needed
  }

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
                  padding: const EdgeInsets.symmetric(horizontal: 20.0), // Added padding
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
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      JournalCard1(
                        title: "Sigiriya",
                        image: "assets/images/trip/Trip - Sigiriya.png",
                      ),
                      SizedBox(width: 16),
                      JournalCard1(
                        title: "Arugam Bay",
                        image: "assets/images/trip/Trip - Arugam Bay.png",
                      ),
                      SizedBox(width: 16),
                      JournalCard1(
                        title: "Horton Plains",
                        image: "assets/images/trip/Trip - Horton Plains.png",
                      ),
                      SizedBox(width: 16),
                      JournalCard1(
                        title: "Kithulgala",
                        image: "assets/images/trip/Trip - Kithulgala.png",
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25),
                custom.SearchBar(
                  controller: _searchController,
                  onChanged: _onSearchChanged,
                ),
                SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: JournalCard2(
                    trip_title: "My trip to Arugam Bay",
                    created_on: "created on 12th June 2024",
                    trip_image: "assets/images/trip/Trip - Arugam Bay.png",
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 20,
              right: 5, // Adjusted right positioning
              child: Padding(
                padding: const EdgeInsets.only(left: 5), // Adjusted padding for AddButton
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
