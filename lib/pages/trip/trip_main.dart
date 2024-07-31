// lib/pages/trip/trip_main.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wandr/config.dart';
import 'package:wandr/theme/app_colors.dart';
import 'package:wandr/components/search_bar3.dart' as custom;
import 'package:wandr/components/bottom_nav_bar.dart';
import 'package:wandr/components/trip_card.dart';
import 'package:wandr/components/trip_card2.dart';
import 'package:wandr/components/trip_ongoing.dart';
import 'package:wandr/pages/trip/pending_trip_page.dart';
import 'package:wandr/pages/trip/finalized_trip_page.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'dart:convert';

class TripScreen extends StatefulWidget {
  @override
  _TripScreenState createState() => _TripScreenState();
}

class _TripScreenState extends State<TripScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FlutterSecureStorage _storage = FlutterSecureStorage();
  List<Map<String, dynamic>> pendingTrips = [];
  List<Map<String, String>> finalizedTrips = [
    {"title": "Adam's Peak", "created_on": "12th July 2024"},
    {"title": "Arugam Bay Trip", "created_on": "17th August 2023"},
    {"title": "Mihintale Rock", "created_on": "8th July 2024"},
  ];

  @override
  void initState() {
    super.initState();
    _fetchPendingTrips();
  }

  Future<void> _fetchPendingTrips() async {
    try {
      String? token = await _storage.read(key: 'accessToken');
      if (token != null) {
        Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
        final userId = decodedToken['id'];
        final url = Uri.parse('$baseUrl/forward/trip/pending/$userId');

        final response = await http.get(
          url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': token,
          },
        );

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          final trips = data['data'] as List<dynamic>;

          setState(() {
            pendingTrips = trips.map((trip) {
              final createdAt = DateTime.fromMillisecondsSinceEpoch(trip['createdAt']);
              final createdOn = "${createdAt.day}th ${_monthName(createdAt.month)} ${createdAt.year}";
              return {
                'title': trip['name'],
                'created_on': createdOn,
              };
            }).toList();
          });
        } else {
          print('Failed to load trips with status: ${response.statusCode}');
        }
      }
    } catch (e) {
      print('Error fetching trips: $e');
    }
  }

  String _monthName(int month) {
    const months = [
      '', 'January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months[month];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 25),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        "Where do you want to travel today?",
                        style: TextStyle(
                          color: Kcolours.primary,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins-Bold',
                        ),
                      ),
                    ),
                    SizedBox(height: 25),
                    custom.SearchBar3(
                      controller: _searchController,
                      onChanged: (query) {
                        // Handle search query change if needed
                      },
                    ),
                    SizedBox(height: 20),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "On-going Trip",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Kcolours.brownShade4,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12),
                          Column(
                            children: [
                              TripOngoing(
                                title: "My Trip to Sigiriya",
                                created_on: "created on 12th July 2024",
                                image: "assets/images/home/Blogs - 1.png",
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
                                "Pending Trips",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Kcolours.brownShade4,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: pendingTrips.map((trip) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 16.0),
                                  child: TripCard(
                                    title: trip['title'] as String,
                                    created_on: trip['created_on'] as String,
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => PendingTripPage(
                                            title: trip['title'] as String,
                                            createdOn: trip['created_on'] as String,
                                          ),
                                        ),
                                      );
                                    },
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
                                "Finalized Trips",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Kcolours.brownShade4,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: finalizedTrips.map((trip) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 16.0),
                                  child: TripCard2(
                                    title: trip['title']!,
                                    created_on: trip['created_on']!,
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => FinalizedTripPage(
                                            title: trip['title']!,
                                            createdOn: trip['created_on']!,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavBar(),
      ),
    );
  }
}
