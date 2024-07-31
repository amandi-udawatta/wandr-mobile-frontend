import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:wandr/theme/app_colors.dart';

import 'package:wandr/components/places_card1.dart';
import 'package:wandr/components/description_card.dart';
import 'package:wandr/components/bottom_nav_bar.dart';
import 'package:wandr/components/categories_button.dart';
import 'package:wandr/components/activity_card.dart';
import 'package:wandr/components/blog_card.dart';
import 'package:wandr/components/primary_button.dart';
import 'package:wandr/components/trip_popup.dart';
import '../../config.dart';

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
  List<String> pendingTrips = [];
  final storage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    fetchPendingTrips();
  }

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

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  @override
  Widget build(BuildContext context) {
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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Location",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Kcolours.brownShade4,
                      ),
                    ),
                    SizedBox(height: 12),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Kcolours.white,
                          width: 1,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          "assets/images/home/Des - location.png",
                          width: MediaQuery.of(context).size.width - 32,
                          fit: BoxFit.cover,
                        ),
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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: PrimaryButton(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return TripPopup(
                          backgroundImage: "assets/images/trip/Trip_popup.png",
                          created_trips: pendingTrips,
                        );
                      },
                    );
                  },
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
