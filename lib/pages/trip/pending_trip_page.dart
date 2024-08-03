import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:wandr/pages/trip/trip_main.dart';
import 'package:wandr/theme/app_colors.dart';
import '../../components/bottom_nav_bar.dart';
import 'package:wandr/components/places_card1.dart';
import 'package:wandr/components/trip_recommended_item.dart';
import 'package:wandr/components/trip_recommended_service.dart';

class PendingTripPage extends StatefulWidget {
  final String title;
  final String createdOn;
  final List<dynamic> tripPlaces; // Accept tripPlaces as a parameter

  const PendingTripPage({
    Key? key,
    required this.title,
    required this.createdOn,
    required this.tripPlaces, // Add tripPlaces to the constructor
  }) : super(key: key);

  @override
  _PendingTripPageState createState() => _PendingTripPageState();
}

class _PendingTripPageState extends State<PendingTripPage> {
  // Dropdown selection state
  int? _selectedOption;
  final List<Map<String, dynamic>> _dropdownOptions = [
    {"id": 1, "name": "Optimized Route (Shortest Path)"},
    {"id": 2, "name": "Custom Route (Your Selection)"},
    {"id": 3, "name": "Recommended Route (By Us)"}
  ];

  // Function to send the selected ID to the backend
  Future<void> _sendSelectionToBackend(int id) async {
    // Implement backend request here
  }

  @override
  Widget build(BuildContext context) {
    // Define a common padding value
    const EdgeInsets commonPadding = EdgeInsets.symmetric(horizontal: 10.0);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context); // Use pop to go back to the previous screen
          },
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.title, style: TextStyle(color: Kcolours.black)),
            Text(
              widget.createdOn,
              style: TextStyle(
                fontSize: 12,
                color: Kcolours.greyShade1,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: commonPadding,
                child: Text(
                  "Your Current Destination List",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Kcolours.primary,
                  ),
                ),
              ),
              Padding(
                padding: commonPadding,
                child: Text(
                  "Drag the places to adjust the order",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
              ),
              SizedBox(height: 10),
              // Destinations list
              ReorderableListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                onReorder: (int oldIndex, int newIndex) {
                  setState(() {
                    if (newIndex > oldIndex) {
                      newIndex -= 1;
                    }
                    final item = widget.tripPlaces.removeAt(oldIndex);
                    widget.tripPlaces.insert(newIndex, item);

                    // Update the order values
                    for (int i = 0; i < widget.tripPlaces.length; i++) {
                      widget.tripPlaces[i]['placeOrder'] = i + 1;
                    }
                  });
                },
                children: widget.tripPlaces.map((destination) {
                  return Card(
                    key: ValueKey(destination['placeOrder']),
                    color: Colors.grey[200],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: Icon(Icons.menu, color: Kcolours.black),
                      title: Text(destination['title']),
                      trailing: IconButton(
                        icon: Icon(Icons.delete_outline, color: Colors.red),
                        onPressed: () {
                          // Handle deletion here
                        },
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 16),
              Padding(
                padding: commonPadding,
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle Set Order action here
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Kcolours.primary, // Background color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: Text(
                          'Set Order',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        border: Border.all(color: Kcolours.primary, width: 2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        icon: Icon(Icons.add, color: Kcolours.primary),
                        iconSize: 35,
                        onPressed: () {
                          // Handle Add action here
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 25),
              Padding(
                padding: commonPadding,
                child: Text(
                  "Select Your Route",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Kcolours.primary,
                  ),
                ),
              ),
              Padding(
                padding: commonPadding,
                child: Text(
                  "Choose an option to calculate the estimated time for your trip",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: commonPadding,
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    border: Border.all(color: Kcolours.primary, width: 1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<int>(
                      isExpanded: true,
                      value: _selectedOption,
                      hint: Text("Select an option"),
                      items: _dropdownOptions.map((option) {
                        return DropdownMenuItem<int>(
                          value: option['id'],
                          child: Text(option['name']),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedOption = value;
                        });
                        if (value != null) {
                          _sendSelectionToBackend(value);
                        }
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),

              // Recommended services based on your preferences
              Padding(
                padding: commonPadding,
                child: Text(
                  "Recommended services to enhance your trip",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Kcolours.brownShade4,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: commonPadding,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ServiceCard(
                        title: "Cane Laundry Basket",
                        store: "Rattan Wonders",
                        rating: 3.1,
                        image: "assets/images/shops/item-cane-laundry-basket.png",
                      ),
                      SizedBox(width: 16),
                      ServiceCard(
                        title: "Handwoven Baskets",
                        store: "Rattan Wonders",
                        rating: 3.1,
                        image: "assets/images/shops/item-handwoven-baskets.png",
                      ),
                      SizedBox(width: 16),
                      ServiceCard(
                        title: "Rattan Round Serving Tray",
                        store: "Rattan Wonders",
                        rating: 3.1,
                        image: "assets/images/shops/item-rattan-round-serving-tray.png",
                      ),
                      SizedBox(width: 16),
                      ServiceCard(
                        title: "Shopping Basket",
                        store: "Rattan Wonders",
                        rating: 3.1,
                        image: "assets/images/shops/item-shopping-basket.png",
                      ),
                    ],
                  ),
                ),
              ),


              SizedBox(height: 20),

              // Recommended items based on your preferences
              Padding(
                padding: commonPadding,
                child: Text(
                  "Recommended items to make your trip memorable",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Kcolours.brownShade4,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: commonPadding,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ItemCard(
                        title: "Handcrafted Wooden Elephant",
                        store: "Elephant Craft Store",
                        rating: 4.9,
                        image: "assets/images/shops/item-elephant.png",
                      ),
                      SizedBox(width: 16),
                      ItemCard(
                        title: "Handwoven Rattan Basket",
                        store: "Rattan Wonders",
                        rating: 4.5,
                        image: "assets/images/shops/item-basket.png",
                      ),
                      SizedBox(width: 16),
                      ItemCard(
                        title: "Batik Print Scarf",
                        store: "Batik Boutique",
                        rating: 4.2,
                        image: "assets/images/shops/item-scarf.png",
                      ),
                      SizedBox(width: 16),
                      ItemCard(
                        title: "Handwoven Baskets",
                        store: "Rattan Wonders",
                        rating: 3.1,
                        image: "assets/images/shops/item-handwoven-baskets.png",
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
