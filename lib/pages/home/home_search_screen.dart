import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:wandr/components/places_card1.dart';
import 'package:wandr/components/custom_bottom_navigation_bar.dart';
import 'package:wandr/components/search_bar.dart' as custom;
import 'package:wandr/components/categories_button.dart';
import 'package:wandr/pages/home/home_filter_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
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
        body: Column(
          children: [
            SizedBox(height: 30),
            custom.SearchBar(
              controller: _searchController,
              onChanged: _onSearchChanged,
            ),
            SizedBox(height: 30),
            Expanded(
              child: buildTabContent(),
            ),
          ],
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
          selectedIndex: _selectedIndex,
          onItemTapped: _onItemTapped,
        ),
      ),
    );
  }

  Widget buildTabContent() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            // Categories
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Categories",
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Color(0xFF232323),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  CategoriesButton(
                    title: "Beach",
                    image: "assets/images/Popular - Ella.png",
                    onPressed: () {
                      _onCategorySelected(0);
                    },
                    isSelected: _selectedCategoryIndex == 0,
                  ),
                  SizedBox(width: 16),
                  CategoriesButton(
                    title: "Mountains",
                    image: "assets/images/Popular - Ella.png",
                    onPressed: () {
                      _onCategorySelected(1);
                    },
                    isSelected: _selectedCategoryIndex == 1,
                  ),
                ],
              ),
            ),

            // Recommended Places
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Recommended Places",
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Color(0xFF232323),
                  ),
                ),
                Text(
                  "See all",
                  style: GoogleFonts.robotoCondensed(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: Color(0xFF176FF2),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  PlacesCard1(
                    title: "Alley Palace",
                    location: "4.1",
                    image: "assets/images/Popular - Ella.png",
                  ),
                  SizedBox(width: 16),
                  PlacesCard1(
                    title: "Condures Alpes",
                    location: "4.9",
                    image: "assets/images/Popular - Ella.png",
                  ),
                ],
              ),
            ),
            SizedBox(height: 32),

            // Popular Destinations
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Popular Destinations",
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Color(0xFF232323),
                  ),
                ),
                Text(
                  "See all",
                  style: GoogleFonts.robotoCondensed(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: Color(0xFF176FF2),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  PlacesCard1(
                    title: "Alley Palace",
                    location: "4.1",
                    image: "assets/images/Popular - Ella.png",
                  ),
                  SizedBox(width: 16),
                  PlacesCard1(
                    title: "Condures Alpes",
                    location: "4.9",
                    image: "assets/images/Popular - Ella.png",
                  ),
                ],
              ),
            ),
            SizedBox(height: 32),

            // Favorites
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Favorites",
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Color(0xFF232323),
                  ),
                ),
                Text(
                  "See all",
                  style: GoogleFonts.robotoCondensed(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: Color(0xFF176FF2),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  PlacesCard1(
                    title: "Alley Palace",
                    location: "4.1",
                    image: "assets/images/Popular - Ella.png",
                  ),
                  SizedBox(width: 16),
                  PlacesCard1(
                    title: "Condures Alpes",
                    location: "4.9",
                    image: "assets/images/Popular - Ella.png",
                  ),
                ],
              ),
            ),
            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
