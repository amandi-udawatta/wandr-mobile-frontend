import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wandr/components/search_bar.dart' as custom;
import 'package:wandr/components/places_card2.dart';
import 'package:wandr/components/categories_button.dart';
import 'package:wandr/components/filter_button.dart';
import 'package:wandr/components/bottom_nav_bar.dart';

class FilterScreen extends StatefulWidget {
  final String category;
  final int initialIndex;

  const FilterScreen({Key? key, required this.category, required this.initialIndex}) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  int _selectedIndex = 1;
  final TextEditingController _searchController = TextEditingController();
  int _selectedCategoryIndex = -1;

  @override
  void initState() {
    super.initState();
    _selectedCategoryIndex = widget.initialIndex; // Set initial selected index
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onSearchChanged(String query) {
    // Handle search query change
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
        bottomNavigationBar: BottomNavBar(),
      ),
    );
  }

  Widget buildTabContent() {
    final places = [
      {
        "title": "Mirissa Beach",
        "location": "Mirissa, Sri Lanka",
        "image": "assets/images/home/Filter - Mirissa.png",
      },
      {
        "title": "Bentota Beach",
        "location": "Bentota, Sri Lanka",
        "image": "assets/images/home/Filter - Bentota.png",
      },
      {
        "title": "Jungle Beach",
        "location": "Unawatuna, Sri Lanka",
        "image": "assets/images/home/Filter - Jungle.png",
      },
      {
        "title": "Arugam Bay",
        "location": "Arugam Bay, Sri Lanka",
        "image": "assets/images/home/Filter - Arugam Bay.png",
      },
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16), // Adjusted padding
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
                    title: "Ocean",
                    image: "assets/images/home/Categories - Ocean.png",
                    onPressed: () {
                      _onCategorySelected(0);
                    },
                    isSelected: _selectedCategoryIndex == 0,
                  ),
                  SizedBox(width: 16),
                  CategoriesButton(
                    title: "Beach",
                    image: "assets/images/home/Categories - Beach.png",
                    onPressed: () {
                      _onCategorySelected(1);
                    },
                    isSelected: _selectedCategoryIndex == 1,
                  ),
                  SizedBox(width: 16),
                  CategoriesButton(
                    title: "Mountains",
                    image: "assets/images/home/Categories - Mountains.png",
                    onPressed: () {
                      _onCategorySelected(2);
                    },
                    isSelected: _selectedCategoryIndex == 2,
                  ),
                  SizedBox(width: 16),
                  CategoriesButton(
                    title: "Forest",
                    image: "assets/images/home/Categories - Forest.png",
                    onPressed: () {
                      _onCategorySelected(3);
                    },
                    isSelected: _selectedCategoryIndex == 3,
                  ),
                ],
              ),
            ),

            // Filter By (Placeholder)
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Filter By",
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
                  FilterButton(
                    text: "Most Popular",
                    onPressed: () {
                      // Handle filter logic for "Most Popular"
                    },
                  ),
                  SizedBox(width: 16),
                  FilterButton(
                    text: "Recommended",
                    onPressed: () {
                      // Handle filter logic for "Recommended"
                    },
                  ),
                  SizedBox(width: 16),
                  FilterButton(
                    text: "All Destinations",
                    onPressed: () {
                      // Handle filter logic for "All Destinations"
                    },
                  ),
                ],
              ),
            ),

            // Suggested places 
            SizedBox(height: 20),
            GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: places.length, // Update this count based on your data
              itemBuilder: (context, index) {
                final place = places[index];
                return PlacesCard2(
                  title: place["title"]!,
                  location: place["location"]!,
                  image: place["image"]!,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _onCategorySelected(int index) {
    setState(() {
      _selectedCategoryIndex = index;
    });

    // Navigate to FilterScreen for Beach category
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => FilterScreen(category: "Beach", initialIndex: 0),
        ),
      );
    }
    // You can add more cases for other categories if needed
  }
}
