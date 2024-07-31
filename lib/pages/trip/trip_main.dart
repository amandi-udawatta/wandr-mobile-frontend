// lib/pages/trip/trip_main.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wandr/theme/app_colors.dart';
import 'package:wandr/components/search_bar3.dart' as custom;
import 'package:wandr/components/bottom_nav_bar.dart';
import 'package:wandr/components/trip_card.dart';
import 'package:wandr/components/trip_card2.dart';
import 'package:wandr/components/trip_ongoing.dart';
import 'package:wandr/pages/trip/pending_trip_page.dart';

class TripScreen extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();

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
                // Added SingleChildScrollView to handle overflow
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
                                    color: Kcolours.brownShade4
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
                                    color: Kcolours.brownShade4
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                TripCard(
                                  title: "Mihintale Rock",
                                  created_on: "created on 12th July 2024",
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PendingTripPage(
                                          title: "Mihintale Rock",
                                          createdOn: "created on 12th July 2024",
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                SizedBox(width: 16),
                                TripCard(
                                  title: "Jetawanaramaya",
                                  created_on: "created on 12th July 2024",
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PendingTripPage(
                                          title: "Jetawanaramaya",
                                          createdOn: "created on 12th July 2024",
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                SizedBox(width: 16),
                                TripCard(
                                  title: "Ruwanweli Stupa",
                                  created_on: "created on 12th July 2024",
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PendingTripPage(
                                          title: "Ruwanweli Stupa",
                                          createdOn: "created on 12th July 2024",
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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
                                "Finalized Trips",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Kcolours.brownShade4
                                ),
                              ),
                              Text(
                                "See All",
                                style: TextStyle(
                                  color: Kcolours.blueShade2,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                TripCard2(
                                  title: "Mihintale Rock",
                                  created_on: "created on 12th July 2024",
                                  image: "assets/images/home/Related - 1.png",
                                ),
                                SizedBox(width: 16),
                                TripCard2(
                                  title: "Jetawanaramaya",
                                  created_on: "created on 12th July 2024",
                                  image: "assets/images/home/Related - 2.png",
                                ),
                                SizedBox(width: 16),
                                TripCard2(
                                  title: "Ruwanweli Stupa",
                                  created_on: "created on 12th July 2024",
                                  image: "assets/images/home/Related - 3.png",
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
            ],
          ),
        ),
        bottomNavigationBar: BottomNavBar(),
      ),
    );
  }
}
