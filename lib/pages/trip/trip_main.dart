import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wandr/theme/app_colors.dart';

import 'package:wandr/components/search_bar3.dart' as custom;
import 'package:wandr/components/bottom_nav_bar.dart';
import 'package:wandr/components/trip_card.dart';
import 'package:wandr/components/trip_ongoing.dart';

class TripScreen extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            SingleChildScrollView( // Added SingleChildScrollView to handle overflow
              child: Column(
                children: [
                  SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      "Where do you want to travel today?",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w800,
                        fontSize: 22,
                        color: Kcolours.primary,
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
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "On-going Trip",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
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
                              "Planned Trips",
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
                              TripCard(
                                title: "Mihintale Rock",
                                created_on: "created on 12th July 2024",
                                image: "assets/images/home/Related - 1.png",
                              ),
                              SizedBox(width: 16),
                              TripCard(
                                title: "Jetawanaramaya",
                                created_on: "created on 12th July 2024",
                                image: "assets/images/home/Related - 2.png",
                              ),
                              SizedBox(width: 16),
                              TripCard(
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
                              "Completed Trip",
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
                              TripCard(
                                title: "Mihintale Rock",
                                created_on: "created on 12th July 2024",
                                image: "assets/images/home/Related - 1.png",
                              ),
                              SizedBox(width: 16),
                              TripCard(
                                title: "Jetawanaramaya",
                                created_on: "created on 12th July 2024",
                                image: "assets/images/home/Related - 2.png",
                              ),
                              SizedBox(width: 16),
                              TripCard(
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
        bottomNavigationBar: BottomNavBar(),
      ),
    );
  }
}
