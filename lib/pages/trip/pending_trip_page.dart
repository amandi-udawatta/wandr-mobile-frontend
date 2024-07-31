// lib/pages/trip/pending_trip_page.dart

import 'package:flutter/material.dart';
import 'package:wandr/pages/trip/trip_main.dart';
import 'package:wandr/theme/app_colors.dart';
import '../../components/bottom_nav_bar.dart';

class PendingTripPage extends StatefulWidget {
  final String title;
  final String createdOn;

  const PendingTripPage({
    Key? key,
    required this.title,
    required this.createdOn,
  }) : super(key: key);

  @override
  _PendingTripPageState createState() => _PendingTripPageState();
}

class _PendingTripPageState extends State<PendingTripPage> {
  // Mockup data for destinations with their order
  List<Map<String, dynamic>> destinations = [
    {"name": "Mihintale Rock", "order": 1},
    {"name": "Ruwanwelisaya Stupa", "order": 2},
    {"name": "Wilpattu National Park", "order": 3},
    {"name": "Kalu Diya Pokuna", "order": 4}
  ];

  // Dropdown selection state
  int? _selectedOption;
  final List<Map<String, dynamic>> _dropdownOptions = [
    {"id": 1, "name": "Optimized Route (Shortest Path)"},
    {"id": 2, "name": "Custom Route (Your Selection)"},
    {"id": 3, "name": "Recommended Route (By Us)"}
  ];

  // Function to send the selected ID to the backend
  Future<void> _sendSelectionToBackend(int id) async {
    // final url = Uri.parse('http://your-backend-url/endpoint'); // Replace with your actual backend URL
    //
    // try {
    //   final response = await http.post(
    //     url,
    //     headers: {'Content-Type': 'application/json'},
    //     body: json.encode({"selectedId": id}),
    //   );
    //
    //   if (response.statusCode == 200) {
    //     print('Selection sent successfully');
    //   } else {
    //     print('Failed to send selection with status: ${response.statusCode}');
    //   }
    // } catch (e) {
    //   print('Error sending selection: $e');
    // }
  }

  @override
  Widget build(BuildContext context) {
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
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TripScreen()),
            );
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
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  "Your Current Destination List",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Kcolours.primary
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 10.0), // Add horizontal padding
                child: Text(
                  "Drag the places to adjust the order",
                  textAlign: TextAlign.left, // Center the text
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
                    final item = destinations.removeAt(oldIndex);
                    destinations.insert(newIndex, item);

                    // Update the order values
                    for (int i = 0; i < destinations.length; i++) {
                      destinations[i]['order'] = i + 1;
                    }
                  });
                },
                children: destinations.map((destination) {
                  return Card(
                    key: ValueKey(destination['order']),
                    color: Colors.grey[200],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: Icon(Icons.menu, color: Kcolours.black),
                      title: Text(destination['name']),
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
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  "Select Your Route",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Kcolours.primary
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 10.0), // Add horizontal padding
                child: Text(
                  "Choose an option to calculate the estimated time for your trip",
                  textAlign: TextAlign.left, // Center the text
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}


