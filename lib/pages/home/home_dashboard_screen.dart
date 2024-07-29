import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wandr/theme/app_colors.dart';

import 'package:wandr/components/places_card1.dart';
import 'package:wandr/components/search_bar.dart' as custom;
import 'package:wandr/components/categories_button.dart';
import 'package:wandr/pages/home/home_filter_screen.dart';
import 'package:wandr/components/bottom_nav_bar.dart';
import 'package:wandr/components/home_profile.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
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
          builder: (context) =>
              FilterScreen(category: "Beach", initialIndex: 0),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: HomeProfile(
                image: 'assets/images/profile/Profile_pic.png',
                text: 'Ayubowan James!',
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0), // Added padding
              child: Text(
                "Where do you want to explore today?",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w800,
                  fontSize: 22,
                  color: Kcolours.primary,
                ),
              ),
            ),
            SizedBox(height: 20),
            custom.SearchBar(
              controller: _searchController,
              onChanged: _onSearchChanged,
            ),
            SizedBox(height: 20),
            Expanded(
              child: buildTabContent(),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavBar(),
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
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: Kcolours.brownShade4,
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
                    title: "Ocean",
                    image: "assets/images/home/Categories - Ocean.png",
                    onPressed: () {
                      _onCategorySelected(0);
                    },
                    isSelected: _selectedCategoryIndex == 0,
                  ),
                  SizedBox(width: 12),
                  CategoriesButton(
                    title: "Beach",
                    image: "assets/images/home/Categories - Beach.png",
                    onPressed: () {
                      _onCategorySelected(1);
                    },
                    isSelected: _selectedCategoryIndex == 1,
                  ),
                  SizedBox(width: 12),
                  CategoriesButton(
                    title: "Mountains",
                    image: "assets/images/home/Categories - Mountains.png",
                    onPressed: () {
                      _onCategorySelected(1);
                    },
                    isSelected: _selectedCategoryIndex == 1,
                  ),
                  SizedBox(width: 12),
                  CategoriesButton(
                    title: "Forest",
                    image: "assets/images/home/Categories - Forest.png",
                    onPressed: () {
                      _onCategorySelected(1);
                    },
                    isSelected: _selectedCategoryIndex == 1,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Recommended Places
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Recommended Places",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: Kcolours.brownShade4,
                  ),
                ),
                Text(
                  "See all",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: Kcolours.blueShade2,
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
                    title: "Sigiriya",
                    location: "Mathale, SL",
                    image: "assets/images/home/Rec - Sigiriya.png",
                  ),
                  SizedBox(width: 16),
                  PlacesCard1(
                    title: "Nilaweli",
                    location: "Trincomalee, SL",
                    image: "assets/images/home/Rec - Nilaweli.png",
                  ),
                  SizedBox(width: 16),
                  PlacesCard1(
                    title: "Sinharaja",
                    location: "Deniyaya, SL",
                    image: "assets/images/home/Rec - Sinharaja.png",
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Popular Destinations
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Popular Destinations",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: Kcolours.brownShade4,
                  ),
                ),
                Text(
                  "See all",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: Kcolours.blueShade2,
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
                    title: "Ella",
                    location: "Badulla, SL",
                    image: "assets/images/home/Pop - Ella.png",
                  ),
                  SizedBox(width: 16),
                  PlacesCard1(
                    title: "World's End",
                    location: "Nuwara Eliya, SL",
                    image: "assets/images/home/Pop - Worlds End.png",
                  ),
                  SizedBox(width: 16),
                  PlacesCard1(
                    title: "Ruwanweli Stupa",
                    location: "Anuradhapura, SL",
                    image: "assets/images/home/Pop - Ruwanweli Stupa.png",
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Favorites
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Favorites",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: Kcolours.brownShade4,
                  ),
                ),
                Text(
                  "See all",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: Kcolours.blueShade2,
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
                    title: "Sigiriya",
                    location: "Mathale, SL",
                    image: "assets/images/home/Fav - Sigiriya.png",
                  ),
                  SizedBox(width: 16),
                  PlacesCard1(
                    title: "Galle Fort",
                    location: "Galle, SL",
                    image: "assets/images/home/Fav - Galle Fort.png",
                  ),
                  SizedBox(width: 16),
                  PlacesCard1(
                    title: "Adam's Peak",
                    location: "Hatton, SL",
                    image: "assets/images/home/Fav - Adams Peak.png",
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
