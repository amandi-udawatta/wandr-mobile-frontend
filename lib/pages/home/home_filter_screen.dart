import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:wandr/theme/app_colors.dart';
import 'package:wandr/components/categories_button.dart';
import 'package:wandr/components/filter_button.dart';
import 'package:wandr/components/places_card1.dart';
import 'package:wandr/components/search_bar.dart' as custom;
import 'package:wandr/components/bottom_nav_bar.dart';
import 'package:wandr/config.dart'; // Ensure you have baseUrl defined here
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:wandr/data.dart'; // Importing destinations from data.dart

class FilterScreen extends StatefulWidget {
  final String category;
  final int initialIndex;

  const FilterScreen({Key? key, required this.category, required this.initialIndex}) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  int _selectedIndex = 0; // Default index for filter
  final TextEditingController _searchController = TextEditingController();
  int _selectedCategoryIndex = -1;
  List<Map<String, dynamic>> _places = [];
  final storage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    _selectedCategoryIndex = widget.initialIndex; // Set initial category index
    _fetchAndUpdatePlaces(); // Fetch initial places
  }

  Future<void> _fetchAndUpdatePlaces() async {
    final token = await storage.read(key: 'accessToken');
    if (token == null) {
      _showError(context, 'Token not found. Please login again.');
      return;
    }

    try {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      final userId = decodedToken['id'];
      String category = _selectedCategoryIndex == -1 ? "All" : destinations.firstWhere((d) => d['id'] == _selectedCategoryIndex)['name'];
      String filter = _selectedIndex == 0 ? "All Destinations" :
                      _selectedIndex == 1 ? "Most Popular" :
                      "Recommended";
      final url = Uri.parse('$baseUrl/forward/traveller/all-places/$userId');
      
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token,
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success']) {
          List<dynamic> placesData = data['data'];
          setState(() {
            _places = placesData.where((place) {
              bool matchesCategory = category == "All" || place['categories'].contains(category);
              bool matchesFilter = filter == "All Destinations" ||
                                   (filter == "Most Popular" && place['activities'].contains('Popular Activity')) ||
                                   (filter == "Recommended" && place['liked']);
              return matchesCategory && matchesFilter;
            }).map((place) {
              return {
                'title': place['name'],
                'location': place['address'],
                'image': place['image']
              };
            }).take(10).toList(); // Take only the first 10 items
          });
        } else {
          throw Exception('Failed to load places');
        }
      } else {
        throw Exception('Failed to load places');
      }
    } catch (e) {
      print('Error fetching places: $e');
      _showError(context, 'Error fetching places. Please try again later.');
    }
  }

  void _onCategorySelected(int index) {
    setState(() {
      _selectedCategoryIndex = index;
    });
    _fetchAndUpdatePlaces();
  }

  void _onFilterSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _fetchAndUpdatePlaces();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            SizedBox(height: 25),
            custom.SearchBar(
              controller: _searchController,
              onChanged: (query) {
                // Handle search query change
              },
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
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0), // Adjust the right padding as needed
                    child: CategoriesButton(
                      title: "All",
                      onPressed: () {
                        _onCategorySelected(-1); // Update the logic as needed
                      },
                      isSelected: _selectedCategoryIndex == -1,
                    ),
                  ),
                  ...destinations.map((destination) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: CategoriesButton(
                        title: destination['name'],
                        image: destination['image'],
                        onPressed: () {
                          _onCategorySelected(destination['id']);
                        },
                        isSelected: _selectedCategoryIndex == destination['id'],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // Filter By
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Filter By",
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
                  FilterButton(
                    text: "All Destinations",
                    onPressed: () {
                      _onFilterSelected(0); // Handle filter logic for "All Destinations"
                    },
                    isSelected: _selectedIndex == 0,
                  ),
                  SizedBox(width: 12),
                  FilterButton(
                    text: "Most Popular",
                    onPressed: () {
                      _onFilterSelected(1); // Handle filter logic for "Most Popular"
                    },
                    isSelected: _selectedIndex == 1,
                  ),
                  SizedBox(width: 12),
                  FilterButton(
                    text: "Recommended",
                    onPressed: () {
                      _onFilterSelected(2); // Handle filter logic for "Recommended"
                    },
                    isSelected: _selectedIndex == 2,
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
              itemCount: _places.length,
              itemBuilder: (context, index) {
                final place = _places[index];
                return PlacesCard1(
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

  void _showError(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}
