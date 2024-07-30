import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:wandr/theme/app_colors.dart';
import 'package:wandr/components/places_card1.dart';
import 'package:wandr/components/search_bar.dart' as custom;
import 'package:wandr/components/categories_button.dart';
import 'package:wandr/pages/home/home_filter_screen.dart';
import 'package:wandr/components/bottom_nav_bar.dart';
import 'package:wandr/components/home_profile.dart';
import 'package:wandr/config.dart'; // Ensure you have baseUrl defined here
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 1;
  final TextEditingController _searchController = TextEditingController();
  int _selectedCategoryIndex = -1;
  List<dynamic> popularDestinations = [];
  List<dynamic> favoritePlaces = [];
  final storage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    fetchPopularDestinations();
    fetchFavoritePlaces();
  }

  Future<void> fetchPopularDestinations() async {
    final token = await storage.read(key: 'accessToken');
    if (token == null) {
      _showError(context, 'Token not found. Please login again.');
      return;
    }

    try {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      final userId = decodedToken['id'];
      final url = Uri.parse('$baseUrl/forward/traveller/popular-places/$userId');

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token,
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          popularDestinations = data['data'].take(10).toList(); // Limit to 10 items
        });
      } else {
        print('Failed to load popular destinations with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching popular destinations: $e');
      _showError(context, 'Error fetching popular destinations. Please try again later.');
    }
  }

  Future<void> fetchFavoritePlaces() async {
    final token = await storage.read(key: 'accessToken');
    if (token == null) {
      _showError(context, 'Token not found. Please login again.');
      return;
    }

    try {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      final userId = decodedToken['id'];
      final url = Uri.parse('$baseUrl/forward/traveller/favourite-places/$userId');

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token,
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          favoritePlaces = data['data'].take(10).toList(); // Limit to 10 items
        });
      } else {
        print('Failed to load favorite places with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching favorite places: $e');
      _showError(context, 'Error fetching favorite places. Please try again later.');
    }
  }

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
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                      _onCategorySelected(2);
                    },
                    isSelected: _selectedCategoryIndex == 2,
                  ),
                  SizedBox(width: 12),
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
            popularDestinations.isNotEmpty
                ? SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: popularDestinations.map((destination) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: PlacesCard1(
                            title: destination['name'],
                            location: destination['address'],
                            image: 'assets/places/${destination['image']}',
                          ),
                        );
                      }).toList(),
                    ),
                  )
                : Center(
                    child: CircularProgressIndicator(),
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
            favoritePlaces.isNotEmpty
                ? SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: favoritePlaces.map((place) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: PlacesCard1(
                            title: place['name'],
                            location: place['address'],
                            image: 'assets/places/${place['image']}',
                          ),
                        );
                      }).toList(),
                    ),
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
          ],
        ),
      ),
    );
  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
