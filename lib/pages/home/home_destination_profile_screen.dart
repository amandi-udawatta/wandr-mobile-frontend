import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wandr/theme/app_colors.dart';

import 'package:wandr/components/places_card1.dart';
import 'package:wandr/components/description_card.dart';
import 'package:wandr/components/bottom_nav_bar.dart';
import 'package:wandr/components/categories_button.dart';
import 'package:wandr/components/activity_card.dart';
import 'package:wandr/components/blog_card.dart';
import 'package:wandr/components/primary_button.dart';
import 'package:wandr/components/trip_popup.dart';

class DestinationProfileScreen extends StatelessWidget {
  final Map<String, dynamic> place; // Add this line to accept place data

  const DestinationProfileScreen({
    super.key,
    required this.place, // Add this line to accept place data
  });

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
                title: place['name'],
                location: place['address'],
                image: 'assets/places/${place['image']}',
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: place['categories'].map<Widget>((category) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: CategoriesButton(
                        title: category,
                        image:
                            'assets/images/categories/${category.toLowerCase()}.png',
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
                  place['description'], // Use place description
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Kcolours.brownShade4,
                  ),
                ),
              ),

              // Location
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
                          "assets/images/home/Des - location.png", // Static image for now
                          width: MediaQuery.of(context).size.width -
                              32, // Adjust width as needed
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Activities
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
                        children: place['activities'].map<Widget>((activity) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: ActivityButton(
                              title: activity,
                              image:
                                  "assets/images/activities/${activity.toLowerCase().replaceAll(' ', '-')}.png", // Adjust image source
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),

              // Blogs - NOT CONNECTED WITH BACKEND
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


              // Related Destinations - NOT CONNECTED WITH BACKEND
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

              // Add to Trip
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
                          created_trips: [
                            "My trip to Arugam Bay",
                            "21st Bday Trip",
                            "Honeymoon",
                            "Trip to Sigiriya"
                          ],
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
