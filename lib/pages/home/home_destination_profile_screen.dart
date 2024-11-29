import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:wandr/components/bottom_nav_bar.dart';
import 'package:wandr/pages/home/destination_profile_gmap.dart';
import 'package:wandr/theme/app_colors.dart';
import 'package:wandr/components/places_card1.dart';
import 'package:wandr/components/description_card.dart';
import 'package:wandr/components/categories_button.dart';
import 'package:wandr/components/activity_card.dart';
import 'package:wandr/components/blog_card.dart';
import 'package:wandr/components/primary_button.dart';
import '../../config.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DestinationProfileScreen extends StatefulWidget {
  final Map<String, dynamic> place;

  const DestinationProfileScreen({
    Key? key,
    required this.place,
  }) : super(key: key);

  @override
  _DestinationProfileScreenState createState() =>
      _DestinationProfileScreenState();
}

class _DestinationProfileScreenState extends State<DestinationProfileScreen> {
  // late GoogleMapController mapController;

  List<String> pendingTrips = []; // Stores the user's pending trips
  final storage = FlutterSecureStorage();
  final TextEditingController _tripNameController = TextEditingController(); // Controller for trip name input


  @override
  void initState() {
    super.initState();
    fetchPendingTrips(); // Fetch pending trips on initialization
  }

  /// Fetches the user's pending trips from the backend
  Future<void> fetchPendingTrips() async {
    final token = await storage.read(key: 'accessToken');
    if (token == null) {
      _showError(context, 'Token not found. Please login again.');
      return;
    }

    try {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      final userId = decodedToken['id'];
      final response = await http.get(
        Uri.parse('$baseUrl/forward/trip/pending/$userId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token,
        },
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success']) {
          setState(() {
            pendingTrips = (data['data'] as List)
                .map<String>((trip) => trip['name'] as String)
                .toList();
          });
        } else {
          _showError(context, data['message']);
        }
      } else {
        _showError(context, 'Failed to fetch pending trips');
      }
    } catch (e) {
      _showError(context, 'An error occurred while fetching pending trips');
    }
  }

  /// Saves a new trip to the backend
  Future<void> saveNewTrip(String tripName) async {
    final token = await storage.read(key: 'accessToken');
    if (token == null) {
      _showError(context, 'Token not found. Please login again.');
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/forward/trip/create'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token,
        },
        body: json.encode({
          'name': tripName,
          'placeId': widget.place['id'], // Assuming the place object has an ID field
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success']) {
          Navigator.of(context).pop(); // Close the popup
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Trip saved successfully!')),
          );
        } else {
          _showError(context, data['message']);
        }
      } else {
        _showError(context, 'Failed to save the trip. Please try again.');
      }
    } catch (e) {
      _showError(context, 'An error occurred while saving the trip');
    }
  }

  /// Displays an error message
  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  /// Shows the "Add to Trip" pop-up dialog
  void _showTripPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Text(
            "Save trip to",
            style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (pendingTrips.isNotEmpty) ...[
                for (var trip in pendingTrips)
                  ListTile(
                    title: Text(trip),
                    trailing: Icon(Icons.check_box_outline_blank),
                  ),
                Divider(),
              ],
              TextField(
                controller: _tripNameController,
                decoration: InputDecoration(
                  hintText: "Enter new trip name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10), // Rounded border
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                "Cancel",
                style: TextStyle(
                  color: Colors.green, // Green font color
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                final tripName = _tripNameController.text.trim();
                if (tripName.isNotEmpty) {
                  saveNewTrip(tripName); // Call saveNewTrip
                } else {
                  _showError(context, "Please enter a trip name.");
                }
              },
              child: Text(
                "Save",
                style: TextStyle(
                  color: Colors.green, // Green font color
                ),
              ),
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    final double latitude = widget.place['latitude']; // Latitude from backend
    final double longitude = widget.place['longitude']; // Longitude from backend
    final String placeName = widget.place['name']; // Place name from backend

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DescriptionCard(
                title: widget.place['name'],
                location: widget.place['address'],
                image: 'assets/places/${widget.place['image']}',
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal, // Enable horizontal scrolling
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: widget.place['categories'].map<Widget>((category) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: CategoriesButton(
                          title: category,
                          image:
                          'assets/images/categories/${category.toLowerCase().replaceAll(' ', '-')}.png',
                          onPressed: () {
                            // Add onPressed action if needed
                          },
                          isSelected: false,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  widget.place['description'],
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Kcolours.brownShade4,
                  ),
                ),
              ),
              SizedBox(height: 20),


              // GOOGLE MAPS
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  height: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Kcolours.white,
                      width: 1,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: LatLng(latitude, longitude), // Center map at the destination
                        zoom: 14, // Reasonable zoom level for clarity
                      ),
                      markers: {
                        Marker(
                          markerId: MarkerId('destination_marker'), // Unique marker ID
                          position: LatLng(latitude, longitude), // Marker position on the map
                          infoWindow: InfoWindow(
                            title: placeName, // Place name displayed on tap
                          ),
                        ),
                      },
                      mapType: MapType.normal, // Standard map type (roadmap style)
                      onMapCreated: (GoogleMapController controller) {
                        // Optional: You can use this to customize the map controller.
                      },
                    ),
                  ),
                ),
              ),


              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Activities",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Kcolours.brownShade4,
                      ),
                    ),
                    SizedBox(height: 12),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: widget.place['activities']
                            .map<Widget>((activity) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: ActivityButton(
                              title: activity,
                              image:
                              "assets/images/activities/${activity.toLowerCase().replaceAll(' ', '-')}.png",
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Blogs",
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
                    Column(
                      children: [
                        BlogButton(
                          title: "Sigiriya: A Historical Gem",
                          location: "Mathale, SL",
                          image: "assets/images/home/Blogs - 1.png",
                          image_author: "assets/images/home/Blogs - 3.png",
                          author: "By Kat",
                        ),
                        SizedBox(height: 16),
                        BlogButton(
                          title: "The Lion Rock Adventure at Sigiriya",
                          location: "Mathale, SL",
                          image: "assets/images/home/Blogs - 2.png",
                          image_author: "assets/images/home/Blogs - 3.png",
                          author: "By Jane",
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Related Destinations",
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
                            title: "Mihintale Rock",
                            location: "Mihintale, SL",
                            image: "assets/images/home/Related - 1.png",
                          ),
                          SizedBox(width: 16),
                          PlacesCard1(
                            title: "Jetawanaramaya",
                            location: "Anuradhapura, SL",
                            image: "assets/images/home/Related - 2.png",
                          ),
                          SizedBox(width: 16),
                          PlacesCard1(
                            title: "Ruwanweli Stupa",
                            location: "Anuradhapura, SL",
                            image: "assets/images/home/Related - 3.png",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              // Add to Trip Button
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: PrimaryButton(
                  onTap: _showTripPopup, // Show the popup dialog
                  text: "Add to Trip",
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavBar(),
      ),
    );
  }
}
