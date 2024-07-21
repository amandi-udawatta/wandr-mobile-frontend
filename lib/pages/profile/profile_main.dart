import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wandr/theme/app_colors.dart';

import 'package:wandr/components/profile_pic.dart';
import 'package:wandr/components/profile_details.dart';
import 'package:wandr/components/bottom_nav_bar.dart';
import 'package:wandr/components/premium_banner.dart';
import 'package:wandr/components/profile_blog.dart';
import 'package:wandr/components/profile_item.dart';
import 'package:wandr/components/profile_other.dart';
import 'package:wandr/components/profile_popup.dart';
import 'package:wandr/components/profile_premium_popup.dart';

class ProfileMain extends StatelessWidget {
  const ProfileMain({super.key});

  void _showPrivacyPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ProfilePopup(
          backgroundImage: 'assets/images/profile/Profile_popup.png', // Replace with your background image asset
          title: 'Privacy',
          content: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
        );
      },
    );
  }

  void _showTermsPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ProfilePopup(
          backgroundImage: 'assets/images/profile/Profile_popup.png', // Replace with your background image asset
          title: 'Terms and Conditions',
          content: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
        );
      },
    );
  }

  void _showCancelPlanPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ProfilePopup(
          backgroundImage: 'assets/images/profile/Profile_popup.png', // Replace with your background image asset
          title: 'Cancel the Plan',
          content: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
        );
      },
    );
  }

  void _showPremiumPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ProfilePremiumPopup();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30),
            ProfilePic(
              background_image: 'assets/images/profile/Profile_background.png',
              image: "assets/images/profile/Profile_pic.png",
              name: 'James Green',
              onEdit: () {
                // Define your edit action here
              },
            ),
            SizedBox(height: 80), // Increased height to ensure space below ProfilePic

            // Personal Info
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0), // Added padding here
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Personal Info",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: Kcolours.primary,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 3),
            PersonalDetails(
              icon: "", // This parameter is not used directly now
              title: 'Email Address',
              text: 'jamesgreen@gmail.com',
            ),
            PersonalDetails(
              icon: "", // This parameter is not used directly now
              title: 'Contact Number',
              text: '+1234567890',
            ),
            PersonalDetails(
              icon: "", // This parameter is not used directly now
              title: 'Date of Birth',
              text: '06th March 1990',
            ),
            PersonalDetails(
              icon: "", // This parameter is not used directly now
              title: 'Gender',
              text: 'Male',
            ),

            // Preferences 
            SizedBox(height: 14),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0), // Added padding here
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Preferences",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: Kcolours.primary,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 3),
            PersonalDetails(
              icon: "", // This parameter is not used directly now
              title: 'Favourite Destinations in Sri Lanka',
              text: 'Beach, Mountains, Coral Reefs',
            ),
            PersonalDetails(
              icon: "", // This parameter is not used directly now
              title: 'Favourite Activities to do in Sri Lanka',
              text: 'Surfing, Camping, Train Rides',
            ),

            /// Premium banner
            SizedBox(height: 12),
            PremiumBanner(
              image: 'assets/images/profile/Profile_premium.png', // Corrected the string syntax
              title: "Unlock Premium now!",
              text: "Unlimited Monthly Rs. 5000/ Month",
              onTap: () => _showPremiumPopup(context),
            ),

            // My Blogs 
            SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0), // Added padding here
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "My Blogs",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: Kcolours.primary,
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
            ),
            SizedBox(height: 3),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0), // Added padding here
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ProfileBlog(
                      title: "21st B'day Trip",
                      image: "assets/images/profile/Blog1.png", // Corrected missing image parameter
                    ),
                    SizedBox(width: 16),
                    ProfileBlog(
                      title: "Trip with Fam",
                      image: "assets/images/profile/Blog2.png",
                    ),
                    SizedBox(width: 16),
                    ProfileBlog(
                      title: "Fav Hikes",
                      image: "assets/images/profile/Blog3.png",
                    ),
                  ],
                ),
              ),
            ),

            // Your Items  
            SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0), // Added padding here
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Your Items",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: Kcolours.primary,
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
            ),
            SizedBox(height: 3),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0), // Added padding here
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ProfileItem(
                      title: "Handcraft Elephant",
                      image: "assets/images/profile/Items1.png", // Corrected missing image parameter
                    ),
                    SizedBox(width: 16),
                    ProfileItem(
                      title: "Fruit Backet",
                      image: "assets/images/profile/Items2.png",
                    ),
                    SizedBox(width: 16),
                    ProfileItem(
                      title: "Bathik Cloth",
                      image: "assets/images/profile/Items3.png",
                    ),
                    SizedBox(width: 16),
                    ProfileItem(
                      title: "Bonsai Plant",
                      image: "assets/images/profile/Items4.png",
                    ),
                  ],
                ),
              ),
            ),

            // More Info and Support
            SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0), // Added padding here
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "More Info and Support",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: Kcolours.primary,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 3),
            ProfileOther(
              icon: "", // This parameter is not used directly now
              title: 'Privacy',
              onTap: () => _showPrivacyPopup(context),
            ),
            ProfileOther(
              icon: "", // This parameter is not used directly now
              title: 'Terms and Conditions',
              onTap: () => _showTermsPopup(context),
            ),
            ProfileOther(
              icon: "", // This parameter is not used directly now
              title: 'Cancel the Plan',
              onTap: () => _showCancelPlanPopup(context),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
