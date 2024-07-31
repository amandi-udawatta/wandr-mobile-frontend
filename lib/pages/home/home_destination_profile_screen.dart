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
  const DestinationProfileScreen({super.key});

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
                title: "Sigiriya",
                location: "Mathale, SL",
                image: "assets/images/home/Des - Sigiriya.png",
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CategoriesButton(
                      title: "Rocks",
                      image: "assets/images/home/Des - rocks.png",
                      onPressed: () {
                        // Add onPressed action if needed
                      },
                      isSelected: false, 
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "Sigiriya or Sinhagiri is an ancient rock fortress located in the northern Matale District near the town of Dambulla in the Central Province, Sri Lanka.  It is a site of historical and archaeological significance that is  dominated by a massive column of granite approximately 180 m (590 ft)  high.\n\n"
                  "According to the ancient Sri Lankan chronicle the Cuḷavasa, this area was a large forest, then after storms and landslides it became a hill and was selected by King Kashyapa (AD 477–495) for his new capital. He built his palace on top of this rock and decorated its sides with colourful frescoes.  On a small plateau about halfway up the side of this rock he built a  gateway in the form of an enormous lion. The name of this place is  derived from this structure; Sinhagiri, the Lion Rock.\n\n"
                  "The capital and the royal palace were abandoned after the king's  death. It was used as a Buddhist monastery until the 14th century. Sigiriya today is a UNESCO listed World Heritage Site. It is one of the best preserved examples of ancient urban planning.",
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
                          "assets/images/home/Des - location.png",
                          width: MediaQuery.of(context).size.width - 32, // Adjust width as needed
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
                        children: [
                          ActivityButton(
                            title: "Hill Climbing",
                            image: "assets/images/home/Act - 1.png",
                          ),
                          SizedBox(width: 16),
                          ActivityButton(
                            title: "Cultural Exploration",
                            image: "assets/images/home/Act - 2.png",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Blogs
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

              // Related Destinations
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
                          created_trips: ["My trip to Arugam Bay", "21st Bday Trip", "Honeymoon", "Trip to Sigiriya"], 
                        );
                      }
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